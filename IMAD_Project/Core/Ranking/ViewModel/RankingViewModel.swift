//
//  RankingViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 1/8/24.
//

import Foundation
import Combine

class RankingViewModel:ObservableObject{
    
    var canelable = Set<AnyCancellable>()
    var success = PassthroughSubject<(),Never>()
    
    @Published var currentPage = 1
    @Published var maxPage = 1
    @Published var rankingList:[String:[RankingResponseList]] = [:]
    @Published var popularReview:PopularReviewResponse? = nil
    @Published var popularPosting:PopularPostingResponse? = nil
    
    init(rankingList: [String:[RankingResponseList]]) {
        self.rankingList = rankingList
    }
    func fetchRanking(endPoint:RankingFilter,page:Int,mediaType:TypeFilter){
        let manager = RankingManager.instance
        if let data = manager.cachedData(key: endPoint.rawValue),Date().timeDifference(previousTime: manager.timeStamp[endPoint.rawValue], curruntTime: Date()) <= 300{
            self.rankingList[endPoint.rawValue] = data
        }else{
            RankingApiService.ranking(endPoint: endPoint, page: page, mediaType: mediaType.rawValue)
                .sink { completion in
                    switch completion{
                    case .finished:
                        self.currentPage = page
                        print(completion)
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                } receiveValue: { [weak self] rank in
                    self?.rankingList[endPoint.rawValue,default: []].append(contentsOf: rank.data?.detailsList ?? [])
                    manager.updateData(key: endPoint.rawValue, data: self?.rankingList[endPoint.rawValue])
                    self?.maxPage = rank.data?.totalPages ?? 1
                }.store(in: &canelable)
        }
    }
   
    func getPopularReview(){
        RankingApiService.popularReview()
            .sink { completion in
                switch completion{
                case .finished:
                    print(completion)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] review in
                self?.popularReview = review.data
            }.store(in: &canelable)

    }
    func getPopularPosting(){
        RankingApiService.popluarPosting()
            .sink { completion in
                switch completion{
                case .finished:
                    print(completion)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] posting in
                self?.popularPosting = posting.data
            }.store(in: &canelable)
    }
}
