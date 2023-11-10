//
//  CommentViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/10.
//

import Foundation
import Combine

class CommentViewModel:ObservableObject{
    
    var cancelable = Set<AnyCancellable>()
    var success = PassthroughSubject<(),Never>()
    var commentDeleteSuccess = PassthroughSubject<CommentResponse,Never>()
    var tokenExpired = PassthroughSubject<String,Never>()
    
    @Published var parentComment:CommentResponse? = nil
    @Published var replyList:CommentListResponse? = nil
    @Published var replys:[CommentResponse] = []
    
    @Published var currentPage = 1
    @Published var masPage = 0
    
    func addReply(postingId:Int,parentId:Int?,content:String){
//        CommentApiService.addReply(postingId: postingId, parentId: parentId, content: content)
//            .sink { comp in
//                print(comp)
//            } receiveValue: { [weak self] response in
//                switch response.status{
//                case 200...300:
//                    self?.addCommentInList(commentId: response.data.commentId)
////                    self?.communityDetail?.commentListResponse.commentDetailsResponseList.append(<#T##newElement: CommentResponse##CommentResponse#>)
//                case 401:
////                    AuthApiService.getToken()
//                    self?.tokenExpired.send(response.message)
//                default:
//                    break
//                }
//            }.store(in: &cancelable)
    }
    func modifyReply(commentId:Int,content:String){
//        CommentApiService.modifyReply(commentId: commentId, content: content)
//            .sink { comp in
//                print(comp)
//            } receiveValue: { [weak self] response in
//                switch response.status{
//                case 200...300:
//                    self?.modifySuccess.send()
//                case 401:
////                    AuthApiService.getToken()
//                    self?.tokenExpired.send(response.message)
//                default:
//                    break
//                }
//            }.store(in: &cancelable)
    }
    func deleteyReply(commentId:Int){
//        CommentApiService.deleteReply(commentId: commentId)
//            .sink { comp in
//                print(comp)
//            } receiveValue: { [weak self] response in
//                switch response.status{
////                case 200...300:
////                    self?.commentDeleteSuccess.send(response.)
//                case 401:
////                    AuthApiService.getToken()
//                    self?.tokenExpired.send(response.message)
//                default:
//                    break
//                }
//            }.store(in: &cancelable)
    }
    func addCommentInList(commentId:Int){
//        CommunityApiService.readComment(commentId: commentId)
//            .sink { comp in
//                print(comp)
//            } receiveValue: { [weak self] response in
//                switch response.status{
//                case 200...300:
//                    guard let data = response.data else {return}
//                    self?.communityDetail?.commentListResponse.commentDetailsResponseList.append(data)
//                    self?.replys.append(data)
//                case 401:
////                    AuthApiService.getToken()
//                    self?.tokenExpired.send(response.message)
//                default:
//                    break
//                }
//            }.store(in: &cancelable)
    }
    func readComment(commentId:Int){
//        CommunityApiService.readComment(commentId: commentId)
//            .sink { comp in
//                print(comp)
//            } receiveValue: { [weak self] response in
//                switch response.status{
//                case 200...300:
//                    self?.parentComment = response.data
//                case 401:
////                    AuthApiService.getToken()
//                    self?.tokenExpired.send(response.message)
//                default:
//                    break
//                }
//            }.store(in: &cancelable)
    }
    func readComments(postingId:Int,commentType:Int,page:Int,sort:String,order:Int,parentId:Int){
//        CommentApiService.readListReply(postingId: postingId, commentType: commentType, page: page, sort: sort, order: order, parentId: parentId)
//            .sink { comp in
//                print(comp)
//            } receiveValue: { [weak self] response in
//                switch response.status{
//                case 200...300:
//                    guard let data = response.data else {return}
//                    self?.replyList = data
//                    self?.replys.append(contentsOf: data.commentDetailsResponseList)
//                case 401:
////                    AuthApiService.getToken()
//                    self?.tokenExpired.send(response.message)
//                default:
//                    break
//                }
//            }.store(in: &cancelable)

    }
    func commentLike(commentId:Int,likeStatus:Int){
//        CommentApiService.like(commentId: commentId, likeStatus: likeStatus)
//            .sink { comp in
//                print(comp)
//            } receiveValue: { [weak self] response in
//                switch response.status{
//                case 401:
////                    AuthApiService.getToken()
//                    self?.tokenExpired.send(response.message)
//                default:
//                    break
//                }
//            }.store(in: &cancelable)
    }

}
