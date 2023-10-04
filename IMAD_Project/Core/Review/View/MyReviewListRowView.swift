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
    let review:ReviewDetailsResponseList
    
    var body: some View {
        VStack{
            HStack{
                Text("작품명 : " + review.contentsTitle).bold()
                Spacer()
                Text(review.modifiedAt.relativeTime()).font(.caption).foregroundColor(.gray)
            }
            HStack{
                
                KFImage(URL(string: review.contentsPosterPath.getImadImage()))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 150)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
                VStack(alignment: .leading) {
                    Text(review.title).bold()
                        .padding(.vertical)
                        .font(.subheadline)
                    HStack{
                        Text(review.content)
                            .font(.caption)
                            .lineLimit(5)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom,5)
                            .padding(.horizontal,5)
                        Spacer()
                    }
                    
                }
                Spacer()
                VStack{
                    Circle()
                        .trim(from: 0.0, to: anima ? (review.score) * 0.1 : 0)
                        .stroke(lineWidth: 3)
                        .rotation(Angle(degrees: 270))
                        .frame(width: 50,height: 50)
                        .overlay{
                            VStack{
                                Image(systemName: "star.fill")
                                Text(String(format: "%0.1f", (review.score)))
                            }
                            .font(.caption)
                            Circle().stroke(lineWidth:0.1)
                        }
                        .shadow(radius: 20)
                        .padding(.bottom)
                    HStack(spacing: 15){
                        HStack(spacing: 2){
                            Image(systemName: "heart.fill").foregroundColor(.red)
                            Text("\((review.likeCnt))")
                                .padding(.trailing)
                            Image(systemName: "heart.slash.fill").foregroundColor(.blue)
                            Text("\((review.dislikeCnt))")
                        }
                        .font(.subheadline)
                    }
                    .font(.subheadline)
                }.padding(.horizontal)
                
            }
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
