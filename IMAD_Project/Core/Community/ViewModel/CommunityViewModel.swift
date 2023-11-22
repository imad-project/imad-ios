//
//  CommunityViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/14.
//

import Foundation
import Combine

class CommunityViewModel:ObservableObject{
    
    
    @Published var currentPage = 1
    @Published var maxPage = 1
    
    @Published var community:CommunityResponse?
    @Published var communityList:[CommunityDetailsListResponse] = []
    
    var refreschTokenExpired = PassthroughSubject<(),Never>()
    var wrtiesuccess = PassthroughSubject<Int,Never>()
    var success = PassthroughSubject<(),Never>()

    var cancelable = Set<AnyCancellable>()

    
    init(community: CommunityResponse?, communityList: [CommunityDetailsListResponse]) {
        self.community = community
        self.communityList = communityList
    }
    
    func writeCommunity(contentsId:Int,title:String,content:String,category:Int,spoiler:Bool){
        CommunityApiService.writeCommunity(contentsId: contentsId, title: title, content: content, category: category, spoiler: spoiler)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { [weak self] data in
                guard let postingId = data.data?.postingID else {return}
                self?.wrtiesuccess.send(postingId)
            }.store(in: &cancelable)

    }
    func readCommunityList(page:Int,category:Int){
        CommunityApiService.readAllCommunityList(page: page,category:category)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
                self.currentPage = page
            } receiveValue: { [weak self] response in
                if let data = response.data{
                    self?.communityList.append(contentsOf: data.postingDetailsResponseList)
                    self?.maxPage = data.totalPages
                }
            }.store(in: &cancelable)

    }
    func readListConditionsAll(searchType:Int,query:String,page:Int,sort:String,order:Int,category:Int){
        CommunityApiService.readListConditionsAll(searchType:searchType,query:query,page:page,sort:sort,order:order,category: category)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
                self.currentPage = page
            } receiveValue: { [weak self] response in
                if let data = response.data{
                    self?.communityList.append(contentsOf: data.postingDetailsResponseList)
                    self?.maxPage = data.totalPages
                }
            }.store(in: &cancelable)
    }
    func readDetailCommunity(postingId:Int){
        CommunityApiService.readPosting(postingId: postingId)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { [weak self] response in
                self?.community = response.data
            }.store(in: &cancelable)
    }
    func like(postingId:Int,status:Int){
        CommunityApiService.postingLike(postingId: postingId, status: status)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in }.store(in: &cancelable)
    }
    func modifyCommunity(postingId:Int,title:String,content:String,category:Int,spoiler:Bool){
        CommunityApiService.modifyCommunity(postingId: postingId, title: title, content: content, category: category, spoiler: spoiler)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in
                self.success.send()
            }.store(in: &cancelable)

    }
    func deleteCommunity(postingId:Int){
        CommunityApiService.deletePosting(postingId: postingId)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in }.store(in: &cancelable)
    }
    
}
