//
//  CommunityWriteView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/06/02.
//

import SwiftUI
import Kingfisher

struct CommunityWriteView: View {
    let image:String
    let maximumRating: Double = 5.0
    
    @State var text = ""
    @State var title = ""
    @State private var rating: Double = 0.0
    
    @Environment(\.dismiss) var dismiss
    
    
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
                            .font(.title3)
                            
                        Spacer()
                        Label("스포일러", systemImage: "checkmark")
                            .foregroundColor(.gray)
                            .font(.caption)
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
        }
        
        .foregroundColor(.white)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        
    }
}

struct CommunityWriteView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityWriteView(image: CustomData.instance.movieList.first!)
    }
}
