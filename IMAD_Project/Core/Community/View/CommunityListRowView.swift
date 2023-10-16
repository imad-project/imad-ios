//
//  CommunityListRowView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import SwiftUI
import Kingfisher

struct CommunityListRowView: View {
    let community:CommuityDetailsResponseList
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(ProfileFilter.allCases.first(where: {$0.num == community.userProfileImage})!.rawValue)
                    .resizable()
                    .frame(width: 25,height: 25)
                    .cornerRadius(10)
                Text(community.userNickname)
                Spacer()
                Text(community.createdAt.relativeTime()).bold()
            }
            .font(.caption)
                .padding(.bottom,5)
            HStack{
                VStack{
                    KFImage(URL(string: community.contentsPosterPath ?? ""))
                        .loadDiskFileSynchronously()
                        .cacheMemoryOnly()
                        .resizable()
                        .frame(width: 80,height: 100)
                        .cornerRadius(10)
                }
               
                VStack(alignment: .leading) {
                    Text("#" + community.title).font(.subheadline)
                    Text(community.contentsTitle ?? "")
                        .bold()
                        .font(.subheadline)
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
//                                    Text("\(community.reply)")
                                }
                            }
                        
                        
                    }.font(.caption)
                        .padding(.leading)
                    
                        
                    
                }
                
            }
        }
        .foregroundColor(.black)
//        .onAppear {
//            let downloader = ImageDownloader.default
//            let cache = ImageCache.default
//
//                   cache.retrieveImage(forKey: URL(string: image)!.absoluteString) { result in
//                       switch result {
//                       case .success(_):
//                           // 이미지가 캐시에 존재하면 아무 작업도 수행하지 않습니다.
//                           return
//                       case .failure(_):
//                           // 이미지를 다운로드하고 캐시에 저장합니다.
//                           downloader.downloadImage(with: URL(string: image)!) { result in
//                               if case .success(let retrievalResult) = result {
//                                   cache.storeToDisk(retrievalResult.originalData, forKey: URL(string: image)!.absoluteString)
//                               }
//                           }
//                       }
//                   }
//            // 이미지 로드가 필요한 시점에 Kingfisher 캐시를 확인하고, 없으면 이미지를 다운로드합니다.
//
//        }
    }
}

struct CommunityListRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityListRowView(community:CustomData.instance.community)
    }
}
