//
//  CommunityWriteView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/06/02.
//

import SwiftUI
import Kingfisher

struct CommunityWriteView: View {
    let contentsId:Int
    let image:String
    
    @State var loading = false
    @State var tokenExpired = (false,"")
    @State var category:CommunityFilter = .free
    @State var spoiler = false
    @State var text = ""
    @State var title = ""
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = CommunityViewModel()
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        
        ZStack{
            Color.white.ignoresSafeArea()
            ScrollView(showsIndicators: false){
                
                VStack(alignment: .leading){
                    
                    ZStack(alignment: .top){
                        MovieBackgroundView(url: image,height: 2.7)
                        Text("자유롭게 작성해보세요!")
                            .bold()
                        HStack(alignment: .center){
                            KFImage(URL(string: image))
                                .resizable()
                                .frame(width: 200,height: 250)
                                .cornerRadius(20)
                                .shadow(radius: 10)
                            
                        }.padding(.top,70)
                        
                    }.padding(.top,20)
                    HStack{
                        Text("제목")
                            .bold()
                        
                        Spacer()
                        if spoiler{
                            Text("이 게시물은 스포일러를 포함하고 있습니다.").font(.caption).foregroundColor(.gray)
                        }
                        Button {
                            spoiler.toggle()
                        } label: {
                            Label("스포일러", systemImage: "checkmark")
                                .foregroundColor(spoiler ? .customIndigo : .gray)
                                .font(.caption)
                                .bold()
                        }
                    }.padding(.horizontal,30)
                        .foregroundColor(.black)
                        .padding(.top,40)
                    CustomTextField(password: false, image: "pencil", placeholder: "제목을 입력해 주세요..", color: .gray, text: $title)
                        .padding()
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.customIndigo)
                        }
                        .padding(.horizontal,30)
                    Text("카테고리")
                        .foregroundColor(.black)
                        .padding(.leading,30)
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
                    .environment(\.colorScheme, .light)
                    .padding(.horizontal,30)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.customIndigo, lineWidth: 2)
                            .frame(height: 360)
                            .overlay(
                                TextEditor(text: $text)
                                    .background(Color.clear)
                                    .padding(8)
                                    .overlay(alignment: .topLeading){
                                        if text == ""{
                                            Text("게시물을 작성해주세요..")
                                                .allowsHitTesting(false)
                                                .opacity(0.5)
                                                .padding()
                                        }
                                        
                                    }
                                    .scrollContentBackground(.hidden)
                                    .foregroundColor(.black)
                                
                            )
                            .padding()
                            .padding(.horizontal)
                    }
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
                }
                
            }
            HStack{
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
                            .padding(.leading)
                        
                    }
                    Spacer()
                }
                if text != "" && title != ""{
                    Button {
                        vm.writeCommunity(contentsId: contentsId, title: title, content: text, category: category.num, spoiler: spoiler)
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
            }
            .frame(maxHeight: .infinity,alignment: .top)
            .padding()
            if loading{
                Color.black.opacity(0.5).ignoresSafeArea()
                CustomProgressView()
            }
        }
        
        .foregroundColor(.white)
        .onReceive(vm.tokenExpired) { messages in
            tokenExpired = (true,messages)
        }
        .alert(isPresented: $tokenExpired.0) {
            Alert(title: Text("토큰 만료됨"),message: Text(tokenExpired.1),dismissButton:.cancel(Text("확인")){
                vmAuth.loginMode = false
            })
        }
        .onReceive(vm.success) {
            dismiss()
        }
        
    }
}

struct CommunityWriteView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityWriteView(contentsId: 1, image: CustomData.instance.movieList.first!)
            .environmentObject(AuthViewModel())
    }
}
