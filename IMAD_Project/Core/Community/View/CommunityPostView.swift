//
//  ComminityPostView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/14.
//

import SwiftUI
import Kingfisher

struct CommunityPostView: View {
    @State var reviewText = ""
    @State var anima = false
    @State var seeMore = false
    @Binding var isReview:Bool
    let review:Review
    var body: some View {
            ZStack(alignment: .top){
                Color.white.ignoresSafeArea()
                VStack(spacing: 0){
                    
                    ZStack{
                        Image(systemName: "chevron.left")
                            .bold()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding()
                            .onTapGesture {
                                isReview = false
                            }
                        HStack{
                            KFImage(URL(string: CustomData.instance.userReiveList[2].image))
                                .resizable()
                                .frame(width: 30,height: 30)
                                .clipShape(Circle())
                            Text("todoroki")
                                .font(.caption)
                                .bold()
                        }.padding(.top,5)
                            
                    }.padding(.bottom,10)
                    
                    Divider()
                    
                    ScrollView {
                        
                        Group{
                            HStack(alignment: .top){
                                KFImage(URL(string: review.thumbnail))
                                    .resizable()
                                    .frame(width: 100,height: 100)
                                    .cornerRadius(20)
                                    .shadow(radius: 10)
                                VStack(alignment: .leading,spacing: 5){
                                    Text("이거 솔직히 엔딩 에바 아닌가")
                                        .bold()
                                        .padding(.top)
                                    Text("5분전").font(.caption)
                                }.padding([.leading,.bottom])
                             Spacer()
                            }
                            .padding(.horizontal)
                            ExpandableTextView(text: CustomData.instance.dummyString, maxLines: 5, font: .callout)
                                .padding(.horizontal)
                        }.padding(.top)
                        Divider().background(Color.black)
                            .padding(.horizontal)
                        ForEach(CustomData.instance.userReiveList,id:\.self){ item in
                            
                            HStack(alignment: .top){
                                if item.nickName != "todoriki"{
                                    KFImage(URL(string: item.image))
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .shadow(radius: 10)
                                        .padding(.trailing,7)
                                }
                                VStack(alignment: item.nickName == "todoriki" ? .trailing: .leading){
                                    Text(item.nickName)
                                        .font(.caption)
                                        .offset(x:item.nickName == "todoriki" ? 5 :-5)
                                        .bold()
                                    Text(item.comment)
                                        .padding(10)
                                        .background(item.nickName == "todoriki" ? Color.whiteYellow : Color.customIndigo)
                                        .foregroundColor(item.nickName == "todoriki" ? .black:.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 10)
                           
                                    HStack{
                                        Image(systemName: "hand.thumbsup")
                                        Text("\(CustomData.instance.community.like)")
                                        Image(systemName: "hand.thumbsdown")
                                        Text("\(CustomData.instance.community.hate)")
                                        Text("·  5분전")
                                    }.font(.caption)
                                }
                                if item.nickName == "todoriki"{
                                    KFImage(URL(string: item.image))
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .shadow(radius: 10)
                                        .padding(.leading,7)
                                }
                            }
                            .frame(maxWidth:.infinity,alignment:item.nickName == "todoriki" ? .trailing:.leading)
                            .padding(.horizontal)
                            .padding(.vertical,10)
                        }
                    }
               
                
                }.foregroundColor(.black)
                    .padding(.bottom,80)
                VStack{
                   
                    HStack{
                        KFImage(URL(string: CustomData.instance.movieList.first!))
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        CustomTextField(password: false, image: nil, placeholder: "댓글을 달아주세요 .. ", color: .black, text: $reviewText)
                            .padding(10)
                            .background{
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.customIndigo)
                                    
                            }
                           // .padding(.bottom,5)
                        Button {

                        } label: {
                            Text("전송")
                                .foregroundColor(.customIndigo)
                        }
                        .padding(.leading,5)
                    }
                    .padding(.horizontal)
                }
                .frame(height: 80)
                .background{
                    VStack{
                        Divider()
                        Spacer()
                    }

                }
                .frame(maxHeight: .infinity,alignment: .bottom)
                

//                VStack{
//

//                }
//                .padding()

            }
            .padding(.bottom,50)
            .onAppear{
                withAnimation(.linear(duration: 0.5)){
                    anima = true
                }
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .navigationBarBackButtonHidden(true)
        
    }
}

struct ComminityPostView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityPostView(isReview: .constant(true), review: CustomData.instance.reviewList.first!)
    }
}
struct MessageBubble: View {
    var message: String
    var isSentByUser: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .trailing) {
                Text(CustomData.instance.dummyString)
                    .padding(10)
                    .foregroundColor(isSentByUser ? .white : .black)
                    .background(isSentByUser ? Color.blue : Color.gray)
                    .cornerRadius(15)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}
