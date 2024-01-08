//
//  CommunityWriteView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/06/02.
//

import SwiftUI
import Kingfisher

struct CommunityWriteView: View {
    
    //MARK: 초기 변수/상수
    var contentsId:Int?  //게시물 등록
    var postingId:Int?  //게시물 수정
    let image:String
    
    //MARK: 로딩 표시
    @State var loading = false
    
    //MARK: 게시물 작성/수정
    @State var category:CommunityFilter = .free
    @State var spoiler = false
    @State var text = ""
    @State var title = ""
    
    @State var showCommunity:(Bool,Int) = (false,0)
    
    @Binding var goMain:Bool
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = CommunityViewModel(community: nil, communityList: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        
        ZStack{
            Color.white.ignoresSafeArea()
            ScrollView(showsIndicators: false){
                poster
                VStack(alignment: .leading){
                    titleSpoiler
                    titleView
                    categoryView
                    contents
                }
                .padding(.horizontal,30)
            }
            header
           
            if loading{
                CustomProgressView()
            }
        }
        .foregroundColor(.black)
            .onReceive(vm.wrtiesuccess){ postingId in
                showCommunity = (true,postingId)
            }
            .onReceive(vm.refreschTokenExpired){
                vmAuth.logout(tokenExpired: true)
            }
            .onReceive(vm.success){
                dismiss()
            }
            .navigationDestination(isPresented: $showCommunity.0) {
                CommunityPostView(postingId: showCommunity.1,back: $goMain)
                    .navigationBarBackButtonHidden()
                    .environmentObject(vmAuth)
            }
        
    }
}

struct CommunityWriteView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityWriteView(contentsId: 1, image: CustomData.instance.movieList.first!, goMain: .constant(true),vm: CommunityViewModel(community:nil, communityList: []))
            .environment(\.colorScheme, .light)
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}
extension CommunityWriteView{
    var header:some View{
        HStack{
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .padding(10)
                    .font(.caption)
                    .background(Circle().foregroundColor(.white))
                    .shadow(radius: 20)
                
            }.padding(.leading)
            Spacer()
            if text != "" && title != ""{
                Button {
                    if let postingId{
                        vm.modifyCommunity(postingId: postingId, title: title, content: text, category: category.num, spoiler: spoiler)
                    }
                    else if let contentsId{
                        vm.writeCommunity(contentsId: contentsId, title: title, content: text, category: category.num, spoiler: spoiler)
                    }
                    loading = true
                } label: {
                    Text("완료")
                        .font(.body)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(5)
                        .background(Capsule().foregroundColor(.white))
                        .shadow(radius: 10)
                }
            }
        } .frame(maxHeight: .infinity,alignment: .top)
            .padding()
    }
    var poster:some View{
        ZStack(alignment: .top){
            MovieBackgroundView(url: image,height: 2.7)
            VStack{
                Text("게시물을 자유롭게 작성해보세요!")
                    .foregroundColor(.white)
                    .bold()
                KFImageView(image: image, width: 200, height: 300)
                    .padding(.top)
            }
        }.padding(.top,20)
    }
    var titleSpoiler:some View{
        HStack{
            Text("제목")
                .bold()
            Spacer()
            Text("\(title.count)/25")
                .font(.subheadline)
        }
        .padding(.top,40)
    }
    var titleView:some View{
        VStack(alignment: .trailing){
            CustomTextField(password: false, image: "pencil", placeholder: "제목을 입력해 주세요..", color: .gray,textLimit: 25, text: $title)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.5)
                        .foregroundColor(.customIndigo)
                }
            HStack{
                if spoiler{
                    Text("이 게시물은 스포일러를 포함하고 있습니다.").font(.caption).foregroundColor(.gray)
                }
                Spacer()
                Button {
                    spoiler.toggle()
                } label: {
                    Label("스포일러", systemImage: "checkmark")
                        .foregroundColor(spoiler ? .customIndigo : .gray)
                        .font(.caption)
                        .bold()
                }
            }
        }
        
    }
    var categoryView:some View{
        VStack(alignment: .leading){
            Text("카테고리")
                .padding(.top)
                .bold()
            Picker("",selection: $category){
                ForEach(CommunityFilter.allCases,id: \.self){ item in
                    if item != .all{
                        Text(item.name)
                            .tag(item)
                    }
                }.foregroundColor(.black)
            }
            .pickerStyle(.segmented)
        }
    }
    var contents:some View{
        CustomTextEditor(placeholder: "게시물을 작성해주세요..", color: .customIndigo, textLimit: 2500, text: $text)
       .padding(.top,5)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}
