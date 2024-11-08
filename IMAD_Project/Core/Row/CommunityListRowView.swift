//
//  CommunityListRowView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import SwiftUI

struct CommunityListRowView: View {
    let community:PostingResponse
    var body: some View {
        HStack{
            VStack(alignment: .leading,spacing: 0) {
                
               firstView
                workDetailsView
                HStack{
                    if community.commentCnt == -1{
                        Text(community.createdAt.relativeTime()).foregroundColor(.customIndigo.opacity(0.7))
                    }
                    Text(community.commentCnt != -1 ? "조회수 \(community.viewCnt)회" : "")
                        .foregroundColor(.customIndigo.opacity(0.7))
                        .font(.caption)
                    if community.commentCnt != -1{
                        workStatusView(image: "arrowshape.up", status: community.likeCnt)
                        workStatusView(image: "arrowshape.down", status: community.dislikeCnt)
                    }
                    Text(community.commentCnt != -1 ? "·  " : "")
                    if community.commentCnt != -1{
                        Text(community.createdAt.relativeTime()).foregroundColor(.customIndigo.opacity(0.7))
                    }
                }.font(.caption)
                
            }
            Spacer()
            KFImageView(image: community.contentsPosterPath.getImadImage(),width: 80,height: 100)
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
        CommunityListRowView(community:CustomData.communityDetails!)
            .background(.gray)
    }
}

extension CommunityListRowView{
    var firstView:some View{
        HStack{
            ProfileImageView(imagePath: community.userProfileImage, widthHeigt: 20)
            Text(community.userNickname ?? "").font(.caption).fontWeight(.medium)
            if community.spoiler{
                Capsule()
                    .stroke(lineWidth: 1)
                    .frame(width: 25,height: 12)
                    .overlay {
                        Text("스포")
                            .font(.system(size: 8))
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
    var workDetailsView:some View{
        VStack(alignment: .leading,spacing: 5) {
            Text(community.contentsTitle)
                .font(.GmarketSansTTFMedium(12))
                .lineLimit(1)
                .fontWeight(.bold)
                .foregroundColor(.customIndigo.opacity(0.8))
            HStack(alignment: .top){
                Text(community.title)
                    .fontWeight(.semibold)
                    .font(.GmarketSansTTFMedium(17.5))
                Text(community.commentCnt != -1 ? "[\(community.commentCnt)]" : "")
                    .font(.GmarketSansTTFMedium(17.5))
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
                    .resizable()
                    .frame(width: 10, height: 10)
                Text("\(status)")
        }
        .foregroundColor(.customIndigo.opacity(0.7))
    }
}
