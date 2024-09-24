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
    let rankingManager = RankingCacheManager.instance
    let popularManager = PopularCacheManager.instance
    let errorManager = ErrorManager.instance
    
    @Published var ranking:RankingCache? = nil
    @Published var popular:PopularCache? = PopularCache(review: nil,posting: nil)

    func getRanking(ranking:RankingCache){
        if let data = rankingManager.cachedData(key: ranking.id),Date().timeDifference(previousTime: rankingManager.timeStamp[ranking.id], curruntTime: Date()) <= 300{
            self.ranking = data
        }else{
            fetchRanking(page: 1, ranking: ranking) { response,ranking in
                var ranking = ranking
                ranking.maxPage = response.totalPages
                ranking.list = response.detailsList
                return ranking
            }
        }
    }
    func getRankingNextPage(nextPage:Int,ranking:RankingCache){
        fetchRanking(page: nextPage, ranking: ranking) { response,ranking in
            var ranking = ranking
            ranking.list.append(contentsOf: response.detailsList)
            ranking.currentPage = nextPage
            return ranking
        }
    }
    private func fetchRanking(page:Int,ranking:RankingCache,completion:@escaping (RankingResponse,RankingCache)->(RankingCache)){
        RankingApiService.ranking(endPoint: ranking.rankingType, page: page, mediaType: ranking.mediaType.rawValue)
            .sink { completion in
                self.errorManager.showErrorMessage(completion: completion)
            } receiveValue: { [weak self] rank in
                guard let response = rank.data else {return}
                self?.ranking = completion(response,ranking)
                self?.rankingManager.updateData(data: self?.ranking)
            }.store(in: &canelable)
    }
    func getPopularReview(){
        if let data = popularManager.cachedData(key: "review"),Date().timeDifference(previousTime: popularManager.timeStamp["review"], curruntTime: Date()) <= 300{
            self.popular?.review = data.review
        }else{
            RankingApiService.popularReview()
                .sink { completion in
                    self.errorManager.showErrorMessage(completion: completion)
                } receiveValue: { [weak self] review in
                    guard let response = review.data else {return}
                    self?.popular?.review = response
                    self?.popularManager.updateData(key: "review", data: self?.popular)
                }.store(in: &canelable)
        }
    }
    func getPopularPosting(){
        if let data = popularManager.cachedData(key: "posting"),Date().timeDifference(previousTime: popularManager.timeStamp["posting"], curruntTime: Date()) <= 300{
            self.popular?.posting = data.posting
        }else{
            RankingApiService.popluarPosting()
                .sink { completion in
                    self.errorManager.showErrorMessage(completion: completion)
                } receiveValue: { [weak self] posting in
                    guard let response = posting.data else {return}
                    self?.popular?.posting = response
                    self?.popularManager.updateData(key: "posting", data: self?.popular)
                }.store(in: &canelable)
        }
    }
}
