//
//  CommunityListRowView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import SwiftUI
import Kingfisher

struct CommunityListRowView: View {
    let community:CommunityDetailsListResponse
    var body: some View {
        VStack(alignment: .leading) {
           firstView
            HStack{
                KFImageView(image: community.contentsPosterPath?.getImadImage() ?? "",width: 80,height: 100)
                VStack(alignment: .leading) {
                    workInfoView
                    HStack{
                        Spacer()
                        workStatusView(image: "heart.fill", status: community.likeCnt,color: .red)
                        workStatusView(image: "heart.slash.fill", status: community.dislikeCnt,color: .blue)
                        workStatusView(image: "message", status: community.commentCnt,color: .customIndigo)
                    }.font(.caption)
                        .padding(.leading)
                }
            }
            Divider()
        }
        .foregroundColor(.black)
    }
}

struct CommunityListRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityListRowView(community:CustomData.instance.communityDetails)
    }
}

extension CommunityListRowView{
    var firstView:some View{
        HStack{
            ProfileImageView(imageCode: community.userProfileImage, widthHeigt: 25)
            Text(community.userNickname).bold()
            Text("·  " + community.createdAt.relativeTime()).foregroundColor(.gray)
                .font(.caption)
            Spacer()
            Text("조회수 \(community.viewCnt)회")
                .foregroundColor(.gray)
                .font(.caption2)
            
        }
        .font(.caption)
            .padding(.bottom,5)
    }
    var workInfoView:some View{
        VStack(alignment: .leading) {
            Text("#" + (community.contentsTitle ?? "")).font(.footnote)
            Text(community.title)
                .bold()
                .font(.subheadline)
            if community.spoiler{
                Text("스포일러")
                    .font(.caption2)
                    .bold()
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .padding(2)
                    .background(Color.customIndigo)
                    .cornerRadius(5)
            }
        }
    }
    func workStatusView(image:String,status:Int,color:Color)->some View{
        Capsule()
            .stroke(lineWidth: 1)
            .frame(width: 50,height: 20)
            .foregroundColor(color)
            .overlay {
                HStack{
                    Image(systemName: image)
                        .foregroundColor(color)
                    Text("\(status)")
                }
            }
    }
}
