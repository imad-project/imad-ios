//
//  CommunityViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/14.
//

import Foundation
import Combine

class CommunityViewModel:ObservableObject{
    
    @Published var page = 1
    
    @Published var communityList:[CommuityDetailsResponseList] = []
    @Published var posting:CommunityResponse? = nil
    @Published var communityListResponse:CommunityList? = nil
    
    var success = PassthroughSubject<(),Never>()
    var tokenExpired = PassthroughSubject<String,Never>()
    var cancelable = Set<AnyCancellable>()
    
    func writeCommunity(contentsId:Int,title:String,content:String,category:Int,spoiler:Bool){
        CommunityApiService.writeCommunity(contentsId: contentsId, title: title, content: content, category: category, spoiler: spoiler)
            .sink { comp in
                print(comp)
            } receiveValue: { [weak self] response in
                switch response.status{
                case 200...300:
                    self?.posting = response
                    self?.success.send()
                case 401:
                    AuthApiService.getToken()
                    self?.tokenExpired.send(response.message)
                default:
                    break
                }
            }.store(in: &cancelable)

    }
    func readCommunityList(page:Int){
        CommunityApiService.readAllCommunityList(page: page)
            .sink { comp in
                print(comp)
            } receiveValue: { [weak self] response in
                switch response.status{
                case 200...300:
                    self?.communityListResponse = response
                    guard let list = response.data?.postingDetailsResponseList else {return}
                    self?.communityList.append(contentsOf: list)
//                    self?.success.send()
                case 401:
                    AuthApiService.getToken()
                    self?.tokenExpired.send(response.message)
                default:
                    break
                }
            }.store(in: &cancelable)

    }
    
}
