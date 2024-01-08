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
    @Published var rankingList:[RankingResponseList] = []
    
    func getWeekRanking(){
        RankingApiService.weekRanking()
            .sink { completion in
                switch completion{
                case .finished:
                    print(completion)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] week in
                self?.rankingList = week.data?.contentsDataSet ?? []
            }.store(in: &canelable)

    }
    func getMonthRanking(){
        RankingApiService.monthRanking()
            .sink { completion in
                switch completion{
                case .finished:
                    print(completion)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] week in
                self?.rankingList = week.data?.contentsDataSet ?? []
            }.store(in: &canelable)

    }
    func getAllRanking(){
        RankingApiService.allRanking()
            .sink { completion in
                switch completion{
                case .finished:
                    print(completion)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] week in
                self?.rankingList = week.data?.contentsDataSet ?? []
            }.store(in: &canelable)

    }
}
