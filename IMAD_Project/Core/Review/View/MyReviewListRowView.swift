//
//  MyReviewListRowView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/04.
//

import SwiftUI

struct MyReviewListRowView: View {

    let review:ReadReviewResponse
    
    var body: some View {
            HStack{
                KFImageView(image: review.contentsPosterPath.getImadImage(),width: 100,height: 120)
                VStack(alignment: .leading,spacing: 0) {
                    titleView
                    mainContents
                }
            }
    }
}

struct MyReviewListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MyReviewListRowView(review: CustomData.instance.reviewDetail.first!)
    }
}

extension MyReviewListRowView{
    var titleView:some View{
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
    }
    var mainContents:some View{
        HStack{
            Text(review.content)
                .font(.caption)
                .lineLimit(5)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom,5)
                .padding(.horizontal,5)
            Spacer()
            VStack(alignment: .trailing){
                ScoreView(score: review.score, color: .black,font:.caption,widthHeight:40)
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
}
