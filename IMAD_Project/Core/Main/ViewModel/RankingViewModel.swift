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
    
    func getWeekRanking(){
        RankingApiService.weekRanking()
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
    func getMonthRanking(){
        RankingApiService.monthRanking()
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
    func getAllRanking(){
        RankingApiService.allRanking()
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
