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
    
    @Published var rankingList:[RankingResponseList] = []
    @Published var poster = ""
    
    init(rankingList: [RankingResponseList]) {
        self.rankingList = rankingList
    }
    
    func getWeekRanking(page:Int,type:String){
        RankingApiService.weekRanking(page: page, type: type)
            .sink { completion in
                switch completion{
                case .finished:
                    self.success.send()
                    print(completion)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] rank in
                self?.rankingList = rank.data?.contentsDataSet ?? []
                self?.poster = rank.data?.contentsDataSet.first?.posterPath.getImadImage() ?? ""
            }.store(in: &canelable)

    }
    func getMonthRanking(page:Int,type:String){
        RankingApiService.monthRanking(page: page, type: type)
            .sink { completion in
                switch completion{
                case .finished:
                    self.success.send()
                    print(completion)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] rank in
                self?.rankingList = rank.data?.contentsDataSet ?? []
                self?.poster = rank.data?.contentsDataSet.first?.posterPath.getImadImage() ?? ""
            }.store(in: &canelable)

    }
    func getAllRanking(page:Int,type:String){
        RankingApiService.allRanking(page: page, type: type)
            .sink { completion in
                switch completion{
                case .finished:
                    self.success.send()
                    print(completion)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] rank in
                self?.rankingList = rank.data?.contentsDataSet ?? []
                self?.poster = rank.data?.contentsDataSet.first?.posterPath.getImadImage() ?? ""
            }.store(in: &canelable)

    }
}
