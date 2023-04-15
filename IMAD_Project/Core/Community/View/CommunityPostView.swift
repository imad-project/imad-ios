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
    @Binding var isReview:Bool
    let review:Review
    var body: some View {
        ZStack{
            ZStack(alignment: .top){
                BackgroundView(height: 0.63, height1: 0.7)
                VStack{
                    Image(systemName: "chevron.left")
                        
                        .bold()
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding()
                        .onTapGesture {
                            isReview = false
                        }
                    Group{
                        HStack(alignment: .top){
                            KFImage(URL(string: review.thumbnail))
                                .resizable()
                                .frame(width: 200,height: 200)
                                .cornerRadius(20)
                                .shadow(radius: 10)
                            VStack(alignment: .leading,spacing: 5){
                                Text(review.title)
                                    .bold()
                                    .padding(.bottom)
                                Text(review.genre)
                                    .font(.caption)
                                    .bold()
                                Text("개봉일 " + review.opendDate)
                                    .font(.caption)
                                    .padding(.bottom,20)
                                Text(review.desc)
                                    .font(.caption)
                                    .frame(height:70)
                                
                            }.padding([.leading,.bottom])
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.bottom,50)
                    }
                    HStack{
                        Circle()
                            .trim(from: 0.0, to: anima ? review.gradeAvg * 0.1 : 0)
                            .stroke(lineWidth: 3)
                            .rotation(Angle(degrees: 270))
                            .frame(width: 80,height: 80)
                            .overlay{
                                VStack{
                                    Image(systemName: "star.fill")
                                    Text(String(format: "%0.1f", review.gradeAvg))
                                        .font(.title2)
                                }
                            }
                            
                        VStack{
                            CustomTextField(password: false, image: "square.and.pencil", placeholder: "평점 및 리뷰를 작성해주세요 .. ", color: .white, text: $reviewText)
                                .padding(.bottom,5)
                            Divider()
                                .background(Color.white)
                        }
                        .padding(.leading,30)
                    }
                    .padding()
                    .foregroundColor(.white)
                    
                    ScrollView {
                        ForEach(CustomData.instance.userReiveList,id:\.self){ item in
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(height: 120)
                                    .foregroundColor(.black.opacity(0.8))
                                    
                                HStack{
                                    VStack(alignment: .leading,spacing: 10){
                                        HStack{
                                            KFImage(URL(string: item.image))
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .clipShape(Circle())
                                                .padding(.leading)
                                            Text(item.nickName)
                                                .padding(.leading,5)
                                                .bold()
                                        }
                                        Text(item.comment)
                                            .font(.callout)
                                            .padding(.leading,60)
                                        
                                        
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Circle()
                                            .trim(from: 0.0, to: anima ? item.gradeAvg * 0.1 : 0)
                                            .stroke(lineWidth: 3)
                                            .rotation(Angle(degrees: 270))
                                            .frame(width: 50,height: 50)
                                            .overlay {
                                                VStack{
                                                    Image(systemName: "star.fill")
                                                        .font(.caption)
                                                    Text(String(format: "%0.1f", item.gradeAvg))
                                                        .font(.caption)
                                                }
                                                
                                            }
                                            .background{
                                                Circle()
                                                    .stroke(lineWidth: 3)
                                                    .opacity(0.3)
                                            }
                                            .padding(.trailing)
                                        HStack{
                                            Image(systemName: "hand.thumbsup.fill")
                                            Text("\(CustomData.instance.community.like)")
                                            Image(systemName: "hand.thumbsdown.fill")
                                            Text("\(CustomData.instance.community.hate)")
                                            Image(systemName: "message.fill")
                                            Text("\(CustomData.instance.community.reply)")
                                        }
                                        .font(.caption)
                                        .padding(.top)
                                        .padding(.trailing)
                                    }
                                    
                                }
                                
                            }.padding(.horizontal)
                        }.foregroundColor(.white)
                            .padding(.bottom,80)
                    }
                }.foregroundColor(.customIndigo)
                
            }
        }.onAppear{
            withAnimation(.linear(duration: 0.5)){
                anima = true
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ComminityPostView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityPostView(isReview: .constant(true), review: CustomData.instance.reviewList.first!)
    }
}
