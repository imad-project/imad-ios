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
    let recommendManager = RecommendCacheManager.instance
    let errorManager = ErrorManager.instance
    
    @Published var currentPage = 1
    @Published var maxPage = 0
    
    @Published var recommendAll:AllRecommendResponse? = nil
    @Published var recommendList:RecommendCache? = nil
    
    init(recommendAll:AllRecommendResponse?,recommendList:RecommendCache?) {
        self.recommendAll = recommendAll
        self.recommendList = recommendList
    }
    func workList(_ type:RecommendCategory)->(list:[RecommendResponse],contentsId:Int?){
        switch type{
        case .genreTv:
            let data = recommendAll?.preferredGenreRecommendationTv
            return (data?.results ?? [],data?.contentsID)
        case .genreMovie:
            let data = recommendAll?.preferredGenreRecommendationMovie
            return (data?.results ?? [],data?.contentsID)
        case .trendTv:
            let data = recommendAll?.trendRecommendationTv
            return (data?.results ?? [],data?.contentsID)
        case .trendMovie:
            let data = recommendAll?.trendRecommendationMovie
            return (data?.results ?? [],data?.contentsID)
        case .activityTv:
            let data = recommendAll?.userActivityRecommendationTv
            return (data?.results ?? [],data?.contentsID)
        case .activityAnimationTv:
            let data = recommendAll?.userActivityRecommendationTvAnimation
            return (data?.results ?? [],data?.contentsID)
        case .activityMovie:
            let data = recommendAll?.userActivityRecommendationMovie
            return (data?.results ?? [],data?.contentsID)
        case .activityAnimationMovie:
            let data = recommendAll?.userActivityRecommendationMovieAnimation
            return (data?.results ?? [],data?.contentsID)
        case .topRateTv:
            let data = recommendAll?.topRatedRecommendationTv
            return (data?.results ?? [],data?.contentsID)
        case .topRateMovie:
            let data = recommendAll?.topRatedRecommendationMovie
            return (data?.results ?? [],data?.contentsID)
        case .popluarTv:
            let data = recommendAll?.popularRecommendationTv
            return (data?.results ?? [],data?.contentsID)
        case .popluarMovie:
            let data = recommendAll?.popularRecommendationMovie
            return (data?.results ?? [],data?.contentsID)
        }
    }
    func getAllRecommend(){
        if let data = recommendManager.recommendAllOfCachedData(key: "AllRecommand"),Date().timeDifference(previousTime: recommendManager.timeStamp["AllRecommand"], curruntTime: Date()) <= 300{
            self.recommendAll = data
        }else{
            fetchAllRecommend()
        }
    }
    func getTrendRecommend(page:Int,getNextPage:Bool,type:RecommendCategory,cache:RecommendCache){
        if getNextPage{
            self.getTrendRecommend(page:page,type:type,cache:cache,getPageMode:true)
        }else{
            isCachingRecommendList(id: type.rawValue){
                self.getTrendRecommend(page:page,type:type,cache:cache,getPageMode:false)
            }
        }
    }
    func getGenreRecommend(page:Int,getNextPage:Bool,type:RecommendCategory,cache:RecommendCache){
        if getNextPage{
            self.getGenreRecommend(page:page,type:type,cache:cache,getPageMode:true)
        }else{
            isCachingRecommendList(id: type.rawValue){
                self.getGenreRecommend(page:page,type:type,cache:cache,getPageMode:false)
            }
        }
    }
    func getImadRecommend(page:Int,getNextPage:Bool,category:ImadRecommendFilter,type:RecommendCategory,cache:RecommendCache){
        if getNextPage{
            self.getImadRecommend(page:page,type:type,category:category,cache:cache,getPageMode:true)
        }else{
            isCachingRecommendList(id: type.rawValue){
                self.getImadRecommend(page:page,type:type,category:category,cache:cache,getPageMode:false)
            }
        }
    }
    func getActivityRecommend(page:Int,getNextPage:Bool,contentsId:Int,type:RecommendCategory,cache:RecommendCache){
        if getNextPage{
            self.getActivityRecommend(page:page,type:type,contentsId:contentsId,cache:cache,getPageMode:true)
        }else{
            isCachingRecommendList(id: type.rawValue){
                self.getActivityRecommend(page:page,type:type,contentsId:contentsId,cache:cache,getPageMode:false)
            }
        }
    }
    private func getTrendRecommend(page:Int,type:RecommendCategory,cache:RecommendCache,getPageMode:Bool){
        self.fetchRecommend(page:page,type:type,cache: cache){ (response:TrendRecommendResponse,cache) in
            var cache = cache
            cache.currentPage = page
            switch type.type{
            case .tv:
                cache.list = (getPageMode ? cache.list : []) + (response.trendRecommendationTv?.results ?? [])
                cache.maxPage = response.trendRecommendationTv?.totalPages ?? 0
            case .movie:
                cache.list = (getPageMode ? cache.list : []) + (response.trendRecommendationMovie?.results ?? [])
                cache.maxPage = response.trendRecommendationMovie?.totalPages ?? 0
            }
            return cache
        }
    }
    private func getGenreRecommend(page:Int,type:RecommendCategory,cache:RecommendCache,getPageMode:Bool){
        self.fetchRecommend(page:page,type:type,cache: cache){ (response:GenreRecommendResponse,cache) in
            var cache = cache
            cache.currentPage = page
            switch type.type{
            case .tv:
                cache.list = (getPageMode ? cache.list : []) + (response.preferredGenreRecommendationTv?.results ?? [])
                cache.maxPage = response.preferredGenreRecommendationTv?.totalPages ?? 0
            case .movie:
                cache.list = (getPageMode ? cache.list : []) + (response.preferredGenreRecommendationMovie?.results ?? [])
                cache.maxPage = response.preferredGenreRecommendationMovie?.totalPages ?? 0
            }
            return cache
        }
    }
    private func getImadRecommend(page:Int,type:RecommendCategory,category:ImadRecommendFilter,cache:RecommendCache,getPageMode:Bool){
        fetchRecommend(page:page,type:type,category:category.rawValue,cache: cache){ (response:ImadRecommendResponse,cache) in
            var cache = cache
            cache.currentPage = page
            switch (type.type,category){
            case (.tv,.popular):
                cache.list = (getPageMode ? cache.list : []) + (response.popularRecommendationTv?.results ?? [])
                cache.maxPage = response.popularRecommendationTv?.totalPages ?? 0
            case (.tv,.topRated):
                cache.list = (getPageMode ? cache.list : []) + (response.topRatedRecommendationTv?.results ?? [])
                cache.maxPage = response.topRatedRecommendationTv?.totalPages ?? 0
            case (.movie,.popular):
                cache.list = (getPageMode ? cache.list : []) + (response.popularRecommendationMovie?.results ?? [])
                cache.maxPage = response.popularRecommendationMovie?.totalPages ?? 0
            case (.movie,.topRated):
                cache.list = (getPageMode ? cache.list : []) + (response.topRatedRecommendationMovie?.results ?? [])
                cache.maxPage = response.topRatedRecommendationMovie?.totalPages ?? 0
            }
            return cache
        }
    }
    private func getActivityRecommend(page:Int,type:RecommendCategory,contentsId:Int,cache:RecommendCache,getPageMode:Bool){
        fetchRecommend(page:page,type:type,contentId:contentsId,cache: cache){ (response:ActivityRecommendResponse,cache) in
            var cache = cache
            switch type{
            case .activityTv:
                cache.list = (getPageMode ? cache.list : []) + (response.userActivityRecommendationTv?.results ?? [])
                cache.maxPage = response.userActivityRecommendationTv?.totalPages ?? 0
            case .activityMovie:
                cache.list = (getPageMode ? cache.list : []) + (response.userActivityRecommendationMovie?.results ?? [])
                cache.maxPage = response.userActivityRecommendationMovie?.totalPages ?? 0
            case .activityAnimationTv:
                cache.list = (getPageMode ? cache.list : []) + (response.userActivityRecommendationTvAnimation?.results ?? [])
                cache.maxPage = response.userActivityRecommendationTvAnimation?.totalPages ?? 0
            case .activityAnimationMovie:
                cache.list = (getPageMode ? cache.list : []) + (response.userActivityRecommendationMovieAnimation?.results ?? [])
                cache.maxPage = response.userActivityRecommendationMovieAnimation?.totalPages ?? 0
            default:break
            }
            return cache
        }
    }
    private func fetchAllRecommend(){
        RecommendApiService.all()
            .sink { completion in
                self.errorManager.actionErrorMessage(completion: completion, failed: { self.refreschTokenExpired.send() })
            } receiveValue: { [weak self] work in
                guard let data = work.data else {return}
                self?.recommendAll = data
                self?.recommendManager.recommendAllOfUpdateData(key:"AllRecommand", data: data)
            }.store(in: &cancelable)
    }
    private func fetchRecommend<T:Codable>(page:Int,type:RecommendCategory,category:String? = nil,contentId:Int? = nil,cache:RecommendCache,copletion:@escaping(T,RecommendCache)->(RecommendCache)){
        RecommendApiService.list(page: page,type:type.type.rawValue,contentsId:contentId,category: category,recommendCategory:type)
            .sink { completion in
                self.errorManager.actionErrorMessage(completion: completion, failed: { self.refreschTokenExpired.send() })
                self.currentPage = page
            } receiveValue: { [weak self] (work:NetworkResponse<T>) in
                guard let data = work.data else {return}
                self?.recommendList = copletion(data,cache)
                self?.recommendManager.recommendListOfUpdateData(key: type.rawValue, data: self?.recommendList)
            }.store(in: &cancelable)
    }
    private func isCachingRecommendList(id:String,completion:@escaping()->()){
        if let data = recommendManager.recommendListOfCachedData(key: id),Date().timeDifference(previousTime:recommendManager.timeStamp[id], curruntTime: Date()) <= 300{
            self.recommendList = data
        }else{
            completion()
        }
    }
}
