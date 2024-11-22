//
//  ReviewViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/12.
//

import Foundation
import Combine

final class ReviewViewModel:ObservableObject{
    
    var cancelable = Set<AnyCancellable>()
    var success = PassthroughSubject<(),Never>()
    var reportedReview = PassthroughSubject<(),Never>()
    let reviewManager = ReviewCacheManager.instance
    let errorManager = ErrorManager.instance
    
    @Published var user = UserInfoManager.instance
    @Published var review:ReviewResponse?
    @Published var reviewList:ReviewCache? = nil
    
    init(review:ReviewResponse?,reviewList:ReviewCache?){
        self.review = review
        self.reviewList = reviewList
    }
    
    func createReview(contentsId:Int,title:String,content:String,score:Double,spoiler:Bool){
        ReviewApiService.createReview(id: contentsId, title: title, content: content, score: score, spoiler: spoiler)
            .sink {completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.user.cache = nil
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in
                self.success.send()
            }.store(in: &cancelable)
    }
    func getReviewList(id:Int,page:Int,sort:String,order:Int,review:ReviewCache){
        if let data = reviewManager.reviewListCachedData(key:"\(review.id)"),Date().timeDifference(previousTime: reviewManager.reviewListTimeStamp["\(review.id)"],curruntTime:Date()) <= 300{
            self.reviewList = data
        }else{
            fetchReviewList(id:id,page:page,sort:sort,order:order,review:review){ response,review in
                var review = review
                review.list = response.detailList
                review.maxPage = response.totalPages
                return review
            }
        }
    }
    func getReview(id:Int){
        if let data = reviewManager.reviewCachedData(key:"\(id)"),Date().timeDifference(previousTime: reviewManager.reviewTimeStamp["\(id)"],curruntTime:Date()) <= 300{
            self.review = data
        }else{
            fetchReview(id:id)
        }
    }
    func getReviewNextPage(nextPage:Int,id:Int,sort:String,order:Int,review:ReviewCache){
        fetchReviewList(id:id,page:nextPage,sort:sort,order:order,review:review){ response,review in
            var review = review
            review.list.append(contentsOf: response.detailList)
            review.currentPage = nextPage
            return review
        }
    }
    private func fetchReview(id:Int){
        ReviewApiService.readReview(id: id)
            .sink { completion in
                self.errorManager.showErrorMessage(completion:completion)
            } receiveValue: { [weak self] review in
                self?.review = review.data
                self?.reviewManager.reviewOfUpdateData(data:review.data)
            }.store(in: &cancelable)
    }
    
    private func fetchReviewList(id:Int,page:Int,sort:String,order:Int,review:ReviewCache,completion:@escaping(NetworkListResponse<ReviewResponse>,ReviewCache)->(ReviewCache)){
        ReviewApiService.readReviewList(id: id, page: page, sort: sort, order: order)
            .sink { completion in
                self.errorManager.actionErrorMessage(completion:completion)
            } receiveValue: { [weak self] response in
                guard let response = response.data else{return}
                self?.reviewList = completion(response,review)
                self?.reviewManager.reviewListOfUpdateData(data:self?.reviewList)
            }.store(in: &cancelable)
    }
    func updateReview(reviewId:Int,title:String,content:String,score:Double,spoiler:Bool){
        ReviewApiService.updateReview(id: reviewId, title: title, content: content, score: score, spoiler: spoiler)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.user.cache = nil
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in
                self.success.send()
            }.store(in: &cancelable)
    }
    func deleteReview(id:Int){
        ReviewApiService.deleteReview(id: id)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.user.cache = nil
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in
                self.success.send()
            }.store(in: &cancelable)
    }
   
    
    func updateReviewLike(id:Int,status:Int){
        ReviewApiService.updateReviewLike(id: id, status: status)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.user.cache = nil
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in
                self.success.send()
            }.store(in: &cancelable)
    }
    func readMyReviewList(page:Int){
//        ReviewApiService.readMyReviewList(page: page)
//            .sink {  completion in
//                switch completion{
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    self.user.cache = nil
//                case .finished:
//                    print(completion)
//                }
//                self.currentPage = page
//            } receiveValue: { [weak self] data in
//                if let data = data.data{
//                    self?.reviewList.append(contentsOf: data.detailList)
//                    self?.maxPage = data.totalPages
//                }
//            }.store(in: &cancelable)

    }
    func readMyLikeReviewList(page:Int,likeStatus:Int){
//        ReviewApiService.readMyLikeReviewList(page: page,likeStatus: likeStatus)
//            .sink { completion in
//                switch completion{
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    self.user.cache = nil
//                case .finished:
//                    print(completion)
//                }
//                self.currentPage = page
//            } receiveValue: { [weak self] data in
//                if let data = data.data{
//                    self?.reviewList.append(contentsOf: data.detailList)
//                    self?.maxPage = data.totalPages
//                }
//            }.store(in: &cancelable)

    }
    func like(review:ReviewResponse){
        if review.likeStatus < 1{
            if review.likeStatus < 0{
                self.review?.dislikeCnt -= 1
            }
            self.review?.likeCnt += 1
            
            self.review?.likeStatus = 1
            self.updateReviewLike(id: review.reviewID, status: 1)
        }else{
            self.review?.likeCnt -= 1
            self.review?.likeStatus = 0
            self.updateReviewLike(id: review.reviewID, status: 0)
        }
    }
    func disLike(review:ReviewResponse){
        if review.likeStatus > -1{
            if review.likeStatus > 0{
                self.review?.likeCnt -= 1
            }
            self.review?.dislikeCnt += 1
            self.review?.likeStatus = -1
            self.updateReviewLike(id: review.reviewID, status: -1)
        }else{
            self.review?.likeStatus = 0
            self.review?.dislikeCnt -= 1
            self.updateReviewLike(id: review.reviewID, status: 0)
        }
    }
}
