//
//  ReviewView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/14.
//

import SwiftUI
import Kingfisher

struct ReviewView: View {

    @State var reviewText = ""
    @State var anima = false
    
    let work:WorkResults
    
    var body: some View {
        ZStack(alignment: .top){
            Color.white.ignoresSafeArea()
            VStack{
                HStack{
                    
                        
//                    VStack{
//                        CustomTextField(password: false, image: "square.and.pencil", placeholder: "평점 및 리뷰를 작성해주세요 .. ", color: .white, text: $reviewText)
//                            .padding(.bottom,5)
//                        Divider()
//                            .background(Color.white)
//                    }
//                    .onTapGesture {
//                        writeReview = true
//                    }
//                    .padding(.leading,30)
                }
                
   
                    ForEach(CustomData.instance.userReiveList,id:\.self){ item in
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .frame(height: 120)
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                                
                            HStack{
                                VStack(alignment: .leading,spacing: 10){
                                    HStack{
//                                        KFImage(URL(string: item.image))
//                                            .resizable()
//                                            .frame(width: 30, height: 30)
//                                            .clipShape(Circle())
//                                            .padding(.leading)
                                        Image("happy")
                                            .resizable()
                                            .frame(width: 30,height: 30)
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
//                                        Image(systemName: "hand.thumbsdown.fill")
//                                        Text("\(CustomData.instance.community.hate)")
                                        Image(systemName: "message.fill")
                                        Text("\(CustomData.instance.community.reply)")
                                    }
                                    .font(.caption)
                                    .padding(.top)
                                    .padding(.trailing)
                                }
                                
                            }
                            
                        }.padding(.horizontal)
                    }.padding(.bottom,10)

                Spacer()
                    
        }.padding(.top,20).foregroundColor(.customIndigo)
        }.onAppear{
            withAnimation(.linear(duration: 0.5)){
                anima = true
            }
        }
       
        
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(work: CustomData.instance.workList.first!)
    }
}
