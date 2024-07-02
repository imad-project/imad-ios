//
//  RecommendViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation
import Combine

class RecommendViewModel:ObservableObject{
    
    var cancelable = Set<AnyCancellable>()
    
    @Published var currentPage = 1
    @Published var maxPage = 0
    
    @Published var recommendAll:AllRecommendResponse? = nil
    
    
    func fetchAllRecommend(){
        RecommendApiService.all()
            .sink { completion in
                print(completion)
                switch completion{
                case .finished:
                    print(completion)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] work in
                self?.recommendAll = work.data
            }.store(in: &canelable)

    }
    func fetchTrendRecommend(page:Int){
        RecommendApiService.trend(page: page)
        .sink { completion in
            switch completion{
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                print(completion)
            }
            self.currentPage = page
        } receiveValue: { [weak self] work in
            var tvList:[WorkGenre] = []
            var movieList:[WorkGenre] = []
            (work.data?.trendRecommendationTv?.results ?? []).forEach{tvList.append(TVWorkGenre(tvGenre: $0))}
            (work.data?.trendRecommendationMovie?.results ?? []).forEach{movieList.append(MovieWorkGenre(movieGenre: $0))}
            self?.recommendTrend.0.append(contentsOf:tvList)
            self?.recommendTrend.1.append(contentsOf:movieList)
            self?.maxPage = work.data?.trendRecommendationTv?.totalPages ?? 1
        }.store(in: &cancelable)
    }
    func fetchGenreRecommend(page:Int){
        
    }
    func fetchImadRecommend(page:Int){
        
    }
    func fetchActivityRecommend(page:Int,contentsId:Int){
        
    }
}
