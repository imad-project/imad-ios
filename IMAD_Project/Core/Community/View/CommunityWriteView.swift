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
    let contents:(poster:String,title:String)
    
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
            Color.gray.opacity(0.1)
            ScrollView(showsIndicators: false){
                VStack{
                    header
                    poster
                    categoryView
                    titleView
                    Color.gray.opacity(0.1).frame(height: 20)
                    contentsView
                    Divider()
                    saveView
                }
                .background(Color.white)
            }
           
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
                CommunityPostView(reported: false, postingId: showCommunity.1,back: $goMain)
                    .navigationBarBackButtonHidden()
                    .environmentObject(vmAuth)
            }
        
    }
}

struct CommunityWriteView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityWriteView(contentsId: 1, contents: (CustomData.instance.movieList.first!,"asdasd"), goMain: .constant(true),vm: CommunityViewModel(community:nil, communityList: []))
            .environment(\.colorScheme, .light)
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}
extension CommunityWriteView{
    var header:some View{
        HStack{
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .font(.title3)
                        .fontWeight(.medium)
                }
                Text("글쓰기")
                    .font(.custom("GmarketSansTTFMedium", size: 20))
                Spacer()
            }
            Spacer()
                Button {
                    if !text.isEmpty,!title.isEmpty{
                        if let postingId{
                            vm.modifyCommunity(postingId: postingId, title: title, content: text, category: category.num, spoiler: spoiler)
                        }
                        else if let contentsId{
                            vm.writeCommunity(contentsId: contentsId, title: title, content: text, category: category.num, spoiler: spoiler)
                        }
                        loading = true
                    }
                } label: {
                    Text("등록")
                        .font(.GmarketSansTTFMedium(15))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(5)
                        .background(Capsule().foregroundColor(.customIndigo.opacity(!text.isEmpty && !title.isEmpty ? 1 : 0.5)))
                }
        }
        .padding()
    }
    var poster:some View{
        HStack{
            KFImageView(image: contents.poster, width: 30, height: 30)
                .cornerRadius(10)
            Text(contents.title)
            Spacer()
        }
        .padding([.horizontal,.bottom])
       
    }
    var titleView:some View{
        VStack(alignment: .trailing){
            HStack{
                CustomTextField(password: false, image: "", placeholder: "제목을 입력해 주세요..", color: .black.opacity(0.7),textLimit: 25, text: $title)
                Text("\(title.count)/25")
                    .font(.subheadline)
            }
            .padding(.vertical,5)
            .padding(.leading,10)
            .padding(.trailing)
        }
        
    }
    var categoryView:some View{
        HStack{
            VStack(alignment: .leading){
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
            Button {
                spoiler.toggle()
            } label: {
                Label("스포일러", systemImage: spoiler ? "checkmark.circle.fill" : "checkmark.circle")
                    .foregroundColor(spoiler ? .customIndigo : .gray)
                    .font(.caption)
                    .bold()
            }
        }
        .padding(.horizontal)
    }
    var saveView:some View{
        HStack{
            Button {
                dismiss()
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .foregroundColor(.gray.opacity(0.2))
                    .overlay {
                        Text("취소")
                            .font(.GmarketSansTTFMedium(18))
                            .foregroundColor(.black)
                    }
            }
            .padding([.leading,.top,.bottom])
            Button {
                if !text.isEmpty,!title.isEmpty{
                    if let postingId{
                        vm.modifyCommunity(postingId: postingId, title: title, content: text, category: category.num, spoiler: spoiler)
                    }
                    else if let contentsId{
                        vm.writeCommunity(contentsId: contentsId, title: title, content: text, category: category.num, spoiler: spoiler)
                    }
                    loading = true
                }
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .foregroundColor(.customIndigo.opacity(!text.isEmpty && !title.isEmpty ? 1 : 0.5))
                    .overlay {
                        Text("등록")
                            .font(.GmarketSansTTFMedium(18))
                            .foregroundColor(.white)
                    }
            }
            .padding([.trailing,.top,.bottom])
        }
        
    }
    var contentsView:some View{
        CustomTextEditor(placeholder: "게시물을 작성해주세요..", color: .customIndigo, textLimit: 2500, text: $text)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}
