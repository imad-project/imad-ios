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
        HStack{
            VStack(alignment: .leading,spacing: 0) {
                
               firstView
                workInfoView
                HStack{
                    Text("조회수 \(community.viewCnt)회")
                        .foregroundColor(.customIndigo.opacity(0.7))
                        .font(.caption)
                    workStatusView(image: "heart", status: community.likeCnt)
                    workStatusView(image: "heart.slash", status: community.dislikeCnt)
                    Text("·  " + community.createdAt.relativeTime()).foregroundColor(.customIndigo.opacity(0.7))
                }.font(.caption)
                
            }
            Spacer()
            KFImageView(image: community.contentsPosterPath?.getImadImage() ?? "",width: 80,height: 100)
                .cornerRadius(5)
                .shadow(radius: 1)
                .padding(.leading)
        }
        .padding(10)
        .foregroundColor(.black)
        .background(.white)
    }
}

struct CommunityListRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityListRowView(community:CustomData.instance.communityDetails)
            .background(.gray)
    }
}

extension CommunityListRowView{
    var firstView:some View{
        HStack{
            ProfileImageView(imagePath: community.userProfileImage, widthHeigt: 20)
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
                    .foregroundColor(.customIndigo)
                    .padding(1)
            }
            Spacer()
            
        }
        .font(.caption)
            .padding(.bottom)
    }
    var workInfoView:some View{
        VStack(alignment: .leading,spacing: 5) {
            Text(community.contentsTitle ?? "")
                .font(.GmarketSansTTFMedium(15))
                .lineLimit(1)
                .fontWeight(.medium)
                .foregroundColor(.customIndigo.opacity(0.8))
            HStack(alignment: .top){
                Text(community.title)
                    .bold()
                    .font(.GmarketSansTTFMedium(20))
                Text("[\(community.commentCnt)]")
                    .font(.GmarketSansTTFMedium(15))
                    .foregroundColor(.customIndigo.opacity(0.8))
            }
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .padding(.bottom,5)
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
