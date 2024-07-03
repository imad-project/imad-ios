//
//  CommunityListRowView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import SwiftUI

struct CommunityListRowView: View {
    let community:CommunityDetailsListResponse
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
           firstView
            HStack(spacing: 0){
                VStack(alignment: .leading,spacing:5){
                    workInfoView
                    HStack{
                        Text("조회수 \(community.viewCnt)회")
                            .foregroundColor(.customIndigo.opacity(0.7))
                            .font(.caption)
                        workStatusView(image: "heart", status: community.likeCnt)
                        workStatusView(image: "heart.slash", status: community.dislikeCnt)
                        workStatusView(image: "message", status: community.commentCnt)
                        Text("·  " + community.createdAt.relativeTime()).foregroundColor(.customIndigo.opacity(0.7))
                    }.font(.caption)
                    Spacer()
                }
                Spacer()
                KFImageView(image: community.contentsPosterPath?.getImadImage() ?? "",width: 80,height: 100)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                    .padding(.leading)
                    .padding(.trailing,10)
            }
            
            Divider()
                .padding(.vertical,5)
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
            ProfileImageView(imageCode: community.userProfileImage, widthHeigt: 20)
            Text(community.userNickname ?? "").font(.subheadline).fontWeight(.medium)
            if community.spoiler{
                Capsule()
                    .stroke(lineWidth: 1)
                    .frame(width: 30,height: 15)
                    .overlay {
                        Text("스포")
                            .font(.caption2)
                            .bold()
                    }
                    .foregroundColor(.red)
                    .padding(1)
            }
            Spacer()
            
        }
        .font(.caption)
            .padding(.bottom)
    }
    var workInfoView:some View{
        VStack(alignment: .leading,spacing: 5) {
            Text(community.title)
                .lineLimit(2)
                .bold()
                .fontWeight(.medium)
                .font(.title3)
                .multilineTextAlignment(.leading)
            Text(community.contentsTitle ?? "")
                .font(.system(size: 14))
                .lineLimit(1)
                .fontWeight(.medium)
                .foregroundColor(.customIndigo.opacity(0.8))
        }
    }
    func workStatusView(image:String,status:Int)->some View{
        HStack(spacing:2){
            Image(systemName: image)
            Text("\(status)")
        }
        .foregroundColor(.customIndigo.opacity(0.7))
    }
}
