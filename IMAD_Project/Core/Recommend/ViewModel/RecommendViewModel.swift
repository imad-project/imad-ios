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
    var refreschTokenExpired = PassthroughSubject<(),Never>()
    let recommendnManager = RecommendCacheManager.instance
    let errorManager = ErrorManager.instance
    
    @Published var currentPage = 1
    @Published var maxPage = 0
    
    @Published var recommendAll:AllRecommendResponse? = nil
    @Published var recommendList:[WorkGenre] = []
    
    init(recommendAll:AllRecommendResponse?,recommendList:[WorkGenre]) {
        self.recommendAll = recommendAll
        self.recommendList = recommendList
    }
    func workList(_ type:RecommendListType)->(list:[WorkGenre],contentsId:Int?){
        switch type{
        case .genreTv:
            let data = recommendAll?.preferredGenreRecommendationTv
            return (data?.results.map{ TVWorkGenre(tvGenre: $0) } ?? [],data?.contentsID)
        case .genreMovie:
            let data = recommendAll?.preferredGenreRecommendationMovie
            return (data?.results.map{ MovieWorkGenre(movieGenre: $0) } ?? [],data?.contentsID)
        case .trendTv:
            let data = recommendAll?.trendRecommendationTv
            return (data?.results.map{ TVWorkGenre(tvGenre: $0) } ?? [],data?.contentsID)
        case .trendMovie:
            let data = recommendAll?.trendRecommendationMovie
            return (data?.results.map{ MovieWorkGenre(movieGenre: $0) } ?? [],data?.contentsID)
        case .activityTv:
            let data = recommendAll?.userActivityRecommendationTv
            return (data?.results.prefix(5).map{ TVWorkGenre(tvGenre: $0) } ?? [],data?.contentsID)
        case .activityAnimationTv:
            let data = recommendAll?.userActivityRecommendationTvAnimation
            return (data?.results.prefix(5).map{ TVWorkGenre(tvGenre: $0) } ?? [],data?.contentsID)
        case .activityMovie:
            let data = recommendAll?.userActivityRecommendationMovie
            return (data?.results.prefix(5).map{ MovieWorkGenre(movieGenre: $0) } ?? [],data?.contentsID)
        case .activityAnimationMovie:
            let data = recommendAll?.userActivityRecommendationMovieAnimation
            return (data?.results.prefix(5).map{ MovieWorkGenre(movieGenre: $0) } ?? [],data?.contentsID)
        case .topRateTv:
            let data = recommendAll?.topRatedRecommendationTv
            return (data?.results.map{ TVWorkGenre(tvGenre: $0) } ?? [],data?.contentsID)
        case .topRateMovie:
            let data = recommendAll?.topRatedRecommendationMovie
            return (data?.results.map{ MovieWorkGenre(movieGenre: $0) } ?? [],data?.contentsID)
        case .popluarTv:
            let data = recommendAll?.popularRecommendationTv
            return (data?.results.map{ TVWorkGenre(tvGenre: $0) } ?? [],data?.contentsID)
        case .popluarMovie:
            let data = recommendAll?.popularRecommendationMovie
            return (data?.results.map{ MovieWorkGenre(movieGenre: $0) } ?? [],data?.contentsID)
        }
    }
    func fetchAllRecommend(){
        if let data = recommendnManager.cachedData(key: "AllRecommand"),Date().timeDifference(previousTime: recommendnManager.timeStamp, curruntTime: Date()) <= 300{
            self.recommendAll = data
        }else{
            RecommendApiService.all()
                .sink { completion in
                    self.errorManager.actionErrorMessage(completion: completion, failed: { self.refreschTokenExpired.send() })
                } receiveValue: { [weak self] work in
                    guard let data = work.data else {return}
                    self?.recommendAll = data
                    self?.recommendnManager.updateData(key: "AllRecommand", data: data)
                }.store(in: &cancelable)
        }
    }
    func fetchTrendRecommend(page:Int,type:WorkGenreType){
        RecommendApiService.trend(page: page,type: type.rawValue)
            .sink { completion in
                self.errorManager.actionErrorMessage(completion: completion, failed: { self.refreschTokenExpired.send() })
                self.currentPage = page
            } receiveValue: { [weak self] work in
                switch type{
                case .tv: 
                    self?.recommendList += work.data?.trendRecommendationTv?.results.map{TVWorkGenre(tvGenre: $0)} ?? []
                    self?.maxPage = work.data?.trendRecommendationTv?.totalPages ?? 0
                case .movie:
                    self?.recommendList += work.data?.trendRecommendationMovie?.results.map{MovieWorkGenre(movieGenre:$0)} ?? []
                    self?.maxPage = work.data?.trendRecommendationMovie?.totalPages ?? 0
                }
            }.store(in: &cancelable)
    }
    func fetchGenreRecommend(page:Int,type:WorkGenreType){
        RecommendApiService.genre(page: page,type: type.rawValue)
            .sink { completion in
                self.errorManager.actionErrorMessage(completion: completion, failed: { self.refreschTokenExpired.send() })
                self.currentPage = page
            } receiveValue: { [weak self] work in
                switch type{
                case .tv: 
                    self?.recommendList += work.data?.preferredGenreRecommendationTv?.results.map{TVWorkGenre(tvGenre: $0)} ?? []
                    self?.maxPage = work.data?.preferredGenreRecommendationTv?.totalPages ?? 0
                case .movie:
                    self?.recommendList += work.data?.preferredGenreRecommendationMovie?.results.map{MovieWorkGenre(movieGenre: $0)} ?? []
                    self?.maxPage = work.data?.preferredGenreRecommendationMovie?.totalPages ?? 0
                }
            }.store(in: &cancelable)
    }
    func fetchImadRecommend(page:Int,type:WorkGenreType,category:ImadRecommendFilter){
        RecommendApiService.imad(page: page,type: type.rawValue,category: category.rawValue)
            .sink { completion in
                self.errorManager.actionErrorMessage(completion: completion, failed: { self.refreschTokenExpired.send() })
                self.currentPage = page
            } receiveValue: { [weak self] work in
                switch (type,category){
                case (.tv,.popular):
                    self?.recommendList += work.data?.popularRecommendationTv?.results.map{TVWorkGenre(tvGenre: $0)} ?? []
                    self?.maxPage = work.data?.popularRecommendationTv?.totalPages ?? 0
                case (.tv,.topRated):
                    self?.recommendList += work.data?.topRatedRecommendationTv?.results.map{TVWorkGenre(tvGenre: $0)} ?? []
                    self?.maxPage = work.data?.topRatedRecommendationTv?.totalPages ?? 0
                case (.movie,.popular):
                    self?.recommendList += work.data?.popularRecommendationMovie?.results.map{MovieWorkGenre(movieGenre: $0)} ?? []
                    self?.maxPage = work.data?.popularRecommendationMovie?.totalPages ?? 0
                case (.movie,.topRated):
                    self?.recommendList += work.data?.topRatedRecommendationMovie?.results.map{MovieWorkGenre(movieGenre: $0)} ?? []
                    self?.maxPage = work.data?.topRatedRecommendationMovie?.totalPages ?? 0
                }
            }.store(in: &cancelable)
    }
    func fetchActivityRecommend(page:Int,contentsId:Int,type:RecommendListType){
        RecommendApiService.activity(page: page, contentsId: contentsId)
            .sink { completion in
                self.errorManager.actionErrorMessage(completion: completion, failed: { self.refreschTokenExpired.send() })
                self.currentPage = page
            } receiveValue: { [weak self] work in
                switch type{
                case .activityTv:
                    self?.recommendList += work.data?.userActivityRecommendationTv?.results.map{TVWorkGenre(tvGenre: $0)} ?? []
                    self?.maxPage = work.data?.userActivityRecommendationTv?.totalPages ?? 0
                case .activityMovie:
                    self?.recommendList += work.data?.userActivityRecommendationMovie?.results.map{MovieWorkGenre(movieGenre: $0)} ?? []
                    self?.maxPage = work.data?.userActivityRecommendationMovie?.totalPages ?? 0
                case .activityAnimationTv:
                    self?.recommendList += work.data?.userActivityRecommendationTvAnimation?.results.map{TVWorkGenre(tvGenre: $0)} ?? []
                    self?.maxPage = work.data?.userActivityRecommendationTvAnimation?.totalPages ?? 0
                case .activityAnimationMovie:
                    self?.recommendList += work.data?.userActivityRecommendationMovieAnimation?.results.map{MovieWorkGenre(movieGenre: $0)} ?? []
                    self?.maxPage = work.data?.userActivityRecommendationMovieAnimation?.totalPages ?? 0
                default:break
                }
            }.store(in: &cancelable)
    }
}
