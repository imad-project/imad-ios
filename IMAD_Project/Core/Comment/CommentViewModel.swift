//
//  CommentViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/10.
//

import Foundation
import Combine

class CommentViewModel:ObservableObject{
    
    var refreschTokenExpired = PassthroughSubject<(),Never>()
    var cancelable = Set<AnyCancellable>()
    
    @Published var currentPage = 1
    @Published var maxPage = 0
    
    
    var success = PassthroughSubject<(),Never>()
    var commentDeleteSuccess = PassthroughSubject<CommentResponse,Never>()
    
    @Published var comment:CommentResponse? = nil
    @Published var replys:[CommentResponse] = []
    
    init(comment:CommentResponse?,replys:[CommentResponse]){
        self.comment = comment
        self.replys = replys
    }
    
    
    func addReply(postingId:Int,parentId:Int?,content:String){
        CommentApiService.addReply(postingId: postingId, parentId: parentId, content: content)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in
                self.success.send()
            }.store(in: &cancelable)
    }
    func modifyReply(commentId:Int,content:String){
        CommentApiService.modifyReply(commentId: commentId, content: content)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in
                self.success.send()
            }.store(in: &cancelable)
    }
    func deleteyReply(commentId:Int){
        CommentApiService.deleteReply(commentId: commentId)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in  }.store(in: &cancelable)
    }
    func readComment(commentId:Int){
        CommentApiService.readComment(commentId: commentId)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { [weak self] data in
                self?.comment = data.data
            }.store(in: &cancelable)
    }
    func readComments(postingId:Int,commentType:Int,page:Int,sort:String,order:Int,parentId:Int){
        CommentApiService.readListReply(postingId: postingId, commentType: commentType, page: page, sort: sort, order: order, parentId: parentId)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
                self.currentPage = page
            } receiveValue: { [weak self] response in
                guard let data = response.data else {return}
                self?.replys.append(contentsOf: data.commentDetailsResponseList)
                self?.maxPage = data.totalPages
            }.store(in: &cancelable)

    }
    func commentLike(commentId:Int,likeStatus:Int){
        CommentApiService.like(commentId: commentId, likeStatus: likeStatus)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in
            self.success.send()
            }.store(in: &cancelable)
    }

}
