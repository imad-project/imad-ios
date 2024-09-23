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
    let manager = RankingManager.instance
    
    
    @Published var ranking:RankingCache? = nil
    @Published var popularReview:PopularReviewResponse? = nil
    @Published var popularPosting:PopularPostingResponse? = nil

    func getRanking(ranking:RankingCache){
        if let data = manager.cachedData(key: ranking.id),Date().timeDifference(previousTime: manager.timeStamp[ranking.id], curruntTime: Date()) <= 300{
            self.ranking = data
        }else{
            fetchRanking(page: nil, ranking: ranking) { response,ranking in
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
    private func fetchRanking(page:Int?,ranking:RankingCache,completion:@escaping (RankingResponse,RankingCache)->(RankingCache)){
        RankingApiService.ranking(endPoint: ranking.rankingType, page: page ?? ranking.currentPage, mediaType: ranking.mediaType.rawValue)
            .sink { completion in
                switch completion{
                case .finished:
                    print(completion)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] rank in
                guard let response = rank.data else {return}
                self?.ranking = completion(response,ranking)
                self?.manager.updateData(data: self?.ranking)
            }.store(in: &canelable)
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
