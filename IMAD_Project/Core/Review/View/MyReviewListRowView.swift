//
//  MyReviewListRowView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/04.
//

import SwiftUI
import Kingfisher

struct MyReviewListRowView: View {
    
    @State var anima = false
    let review:ReadReviewResponse
    
    var body: some View {

            HStack{
                
                KFImage(URL(string: review.contentsPosterPath.getImadImage()))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 120)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
                VStack(alignment: .leading,spacing: 0) {
                    HStack(alignment: .top){
                        VStack(alignment: .leading){
                            Text("#" + review.contentsTitle).font(.caption)
                            Text(review.title).bold()
                                .font(.subheadline)
                                .padding(.bottom,5)
                        }
                        
                        Spacer()
                        Text(review.modifiedAt.relativeTime()).font(.caption).foregroundColor(.gray)
                    }
                    HStack{
                        Text(review.content)
                            .font(.caption)
                            .lineLimit(5)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,5)
                            .padding(.horizontal,5)
                        Spacer()
                        VStack(alignment: .trailing){
                            Circle()
                                .trim(from: 0.0, to: anima ? (review.score) * 0.1 : 0)
                                .stroke(lineWidth: 1)
                                .rotation(Angle(degrees: 270))
                                .frame(width: 40,height: 40)
                                .overlay{
                                    VStack{
                                        Image(systemName: "star.fill").font(.system(size: 10))
                                        Text(String(format: "%0.1f", (review.score)))
                                    }
                                    .font(.caption2)
                                    Circle().stroke(lineWidth:0.01)
                                }
                                .shadow(radius: 20)
                                .padding(.bottom,5)
                            HStack{
                                HStack{
                                    Image(systemName: "heart.fill")
                                    Text("\((review.likeCnt))").foregroundColor(.black)
                                        .padding(.trailing,2)
                                }
                                .padding(.horizontal,10)
                                .padding(.vertical,2)
                                .overlay {
                                    Capsule().stroke(lineWidth: 1)
                                }
                                .foregroundColor(.red)
                                HStack{
                                    Image(systemName: "heart.slash.fill")
                                    Text("\((review.dislikeCnt))").foregroundColor(.black)
                                        .padding(.trailing,2)
                                }
                                .padding(.horizontal,10)
                                .padding(.vertical,2)
                                .overlay {
                                    Capsule().stroke(lineWidth: 1)
                                }
                                .foregroundColor(.blue)
                            }.font(.caption2).padding(.top)
                            
                        }.padding(.leading)
                    }
                    
                    
                    
                    
                }
                Spacer()
               
                
            }
        
        
        .onAppear{
            DispatchQueue.main.async {
                withAnimation(.linear(duration: 0.5)){
                    anima = true
                }
            }
        }
    }
}

struct MyReviewListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MyReviewListRowView(review: CustomData.instance.reviewDetail.first!)
    }
}
