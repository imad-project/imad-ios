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
    @Published var recommendTrend:([WorkGenre],[WorkGenre]) = ([],[])
    @Published var recommendGenre:([WorkGenre],[WorkGenre]) = ([],[])
    @Published var recommendImad:([WorkGenre],[WorkGenre]) = ([],[])
    @Published var recommendActivity:[WorkGenre] = []
    
    init(recommendAll:AllRecommendResponse?) {
        self.recommendAll = recommendAll
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
        case .imadTv:
            let data = recommendAll?.popularRecommendationTv
            return (data?.results.map{ TVWorkGenre(tvGenre: $0) } ?? [],data?.contentsID)
        case .imadMovie:
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
    func fetchTrendRecommend(page:Int){
        RecommendApiService.trend(page: page)
            .sink { completion in
                self.errorManager.actionErrorMessage(completion: completion, failed: { self.refreschTokenExpired.send() })
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
        RecommendApiService.genre(page: page)
            .sink { completion in
                self.errorManager.actionErrorMessage(completion: completion, failed: { self.refreschTokenExpired.send() })
                self.currentPage = page
            } receiveValue: { [weak self] work in
                var tvList:[WorkGenre] = []
                var movieList:[WorkGenre] = []
                (work.data?.preferredGenreRecommendationTv?.results ?? []).forEach{tvList.append(TVWorkGenre(tvGenre: $0))}
                (work.data?.preferredGenreRecommendationMovie?.results ?? []).forEach{movieList.append(MovieWorkGenre(movieGenre: $0))}
                self?.recommendGenre.0.append(contentsOf:tvList)
                self?.recommendGenre.1.append(contentsOf:movieList)
                self?.maxPage = work.data?.preferredGenreRecommendationTv?.totalPages ?? 1
            }.store(in: &cancelable)
    }
    func fetchImadRecommend(page:Int){
        RecommendApiService.imad(page: page)
            .sink { completion in
                self.errorManager.actionErrorMessage(completion: completion, failed: { self.refreschTokenExpired.send() })
                self.currentPage = page
            } receiveValue: { [weak self] work in
                var tvList:[WorkGenre] = []
                var movieList:[WorkGenre] = []
                (work.data?.popularRecommendationTv?.results ?? []).forEach{tvList.append(TVWorkGenre(tvGenre: $0))}
                (work.data?.popularRecommendationMovie?.results ?? []).forEach{movieList.append(MovieWorkGenre(movieGenre: $0))}
                self?.recommendImad.0.append(contentsOf:tvList)
                self?.recommendImad.1.append(contentsOf:movieList)
                self?.maxPage = work.data?.popularRecommendationTv?.totalPages ?? 1
            }.store(in: &cancelable)
    }
    func fetchActivityRecommend(page:Int,contentsId:Int){
        RecommendApiService.activity(page: page, contentsId: contentsId)
            .sink { completion in
                self.errorManager.actionErrorMessage(completion: completion, failed: { self.refreschTokenExpired.send() })
                self.currentPage = page
            } receiveValue: { [weak self] work in
                var list:[WorkGenre] = []
                if let result = work.data?.userActivityRecommendationTv{
                    result.results.forEach{list.append(TVWorkGenre(tvGenre: $0))}
                    self?.maxPage = result.totalPages
                }else if let result = work.data?.userActivityRecommendationMovie{
                    result.results.forEach{list.append(MovieWorkGenre(movieGenre: $0))}
                    self?.maxPage = result.totalPages
                }else if let result = work.data?.userActivityRecommendationTvAnimation{
                    result.results.forEach{list.append(TVWorkGenre(tvGenre: $0))}
                    self?.maxPage = result.totalPages
                }else if let result = work.data?.userActivityRecommendationMovieAnimation{
                    result.results.forEach{list.append(MovieWorkGenre(movieGenre: $0))}
                    self?.maxPage = result.totalPages
                }
                self?.recommendActivity.append(contentsOf: list)
                
            }.store(in: &cancelable)
    }
}
