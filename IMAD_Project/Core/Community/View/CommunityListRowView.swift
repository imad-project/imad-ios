//
//  CommunityListRowView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import SwiftUI
import Kingfisher

struct CommunityListRowView: View {
    let title:String
    let image:String
    let community:Community
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image("happy")
                    .resizable()
                    .frame(width: 25,height: 25)
                Text("착하지 못한천")
                Spacer()
                Text("2분전").bold()
            }.font(.caption)
                .padding(.bottom,5)
            HStack{
                VStack{
                    KFImage(URL(string: image))
                        .loadDiskFileSynchronously()
                        .cacheMemoryOnly()
                        .resizable()
                        .frame(width: 150,height: 200)
                        .cornerRadius(10)
                       
                    Text("#" + title).bold().font(.caption).frame(width: 150)
                }
               
                VStack(alignment: .leading) {
                    Spacer()
                    Text(community.title)
                        .bold()
                        .font(.subheadline)
                    Text(CustomData.instance.dummyString)
                        .frame(maxHeight: 100)
                        .font(.caption)
                    Spacer()
                    HStack{
                        Spacer()
                        Capsule()
                            .stroke(lineWidth: 1)
                            .frame(width: 50,height: 20)
                            .foregroundColor(.red)
                            .overlay {
                                HStack{
                                    Image(systemName: "heart")
                                        .foregroundColor(.red)
                                    Text("\(community.like)")
                                }
                            }
                        Capsule()
                            .stroke(lineWidth: 1)
                            .frame(width: 50,height: 20)
                            .foregroundColor(.customIndigo)
                            .overlay {
                                HStack{
                                    Image(systemName: "message")
                                    Text("\(community.reply)")
                                }
                            }
                        
                        
                    }.font(.caption)
                        .padding(.leading)
                        
                    
                }
                Spacer()
                
            }
        }.frame(maxHeight: 250)
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
        CommunityListRowView(title: "벤자민 버튼의 시간은 거꾸로간다", image: CustomData.instance.community.image, community:CustomData.instance.community)
    }
}
