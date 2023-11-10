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
            HStack{
                Image(ProfileFilter.allCases.first(where: {$0.num == community.userProfileImage})!.rawValue)
                    .resizable()
                    .frame(width: 25,height: 25)
                    .cornerRadius(10)
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
            HStack{
                VStack{
                    KFImage(URL(string: community.contentsPosterPath?.getImadImage() ?? ""))
                        .loadDiskFileSynchronously()
                        .cacheMemoryOnly()
                        .resizable()
                        .frame(width: 80,height: 100)
                        .cornerRadius(10)
                }
               
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
                    
                    HStack{
                        Spacer()
                        Capsule()
                            .stroke(lineWidth: 1)
                            .frame(width: 50,height: 20)
                            .foregroundColor(.red)
                            .overlay {
                                HStack{
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                    Text("\(community.likeCnt)")
                                }
                            }
                        Capsule()
                            .stroke(lineWidth: 1)
                            .frame(width: 50,height: 20)
                            .foregroundColor(.blue)
                            .overlay {
                                HStack{
                                    Image(systemName: "heart.slash.fill")
                                        .foregroundColor(.blue)
                                    Text("\(community.dislikeCnt)")
                                }
                            }
                        Capsule()
                            .stroke(lineWidth: 1)
                            .frame(width: 50,height: 20)
                            .foregroundColor(.customIndigo)
                            .overlay {
                                HStack{
                                    Image(systemName: "message")
                                    Text("\(community.commentCnt)")
                                }
                            }
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
        CommunityListRowView(community:CustomData.instance.community)
    }
}
