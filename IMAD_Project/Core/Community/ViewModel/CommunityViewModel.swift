//
//  CommunityViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/14.
//

import Foundation
import Combine

class CommunityViewModel:ObservableObject{
    
    @Published var page = 1
    
    @Published var communityList:[CommuityDetailsResponseList] = []
    @Published var posting:CommunityResponse? = nil
    @Published var communityListResponse:CommunityDetails? = nil
    @Published var communityDetail:CommunityDetailsResponse? = nil
    
    @Published var addedComment:CommentResponse? = nil
    
    var modifyComment = PassthroughSubject<(String,Int),Never>()
    
    var success = PassthroughSubject<(),Never>()
    var modifySuccess = PassthroughSubject<(),Never>()
    var deleteSuccess = PassthroughSubject<(),Never>()
    var commentDeleteSuccess = PassthroughSubject<CommentResponse,Never>()
    var tokenExpired = PassthroughSubject<String,Never>()
    
    
    var cancelable = Set<AnyCancellable>()

    
    func writeCommunity(contentsId:Int,title:String,content:String,category:Int,spoiler:Bool){
        CommunityApiService.writeCommunity(contentsId: contentsId, title: title, content: content, category: category, spoiler: spoiler)
            .sink { comp in
                print(comp)
            } receiveValue: { [weak self] response in
                switch response.status{
                case 200...300:
                    self?.posting = response
                    self?.success.send()
                case 401:
                    AuthApiService.getToken()
                    self?.tokenExpired.send(response.message)
                default:
                    break
                }
            }.store(in: &cancelable)

    }
    func readCommunityList(page:Int){
        CommunityApiService.readAllCommunityList(page: page)
            .sink { comp in
                print(comp)
            } receiveValue: { [weak self] response in
                switch response.status{
                case 200...300:
                    self?.communityListResponse = response.data
                    guard let list = response.data?.postingDetailsResponseList else {return}
                    self?.communityList.append(contentsOf: list)
                case 401:
                    AuthApiService.getToken()
                    self?.tokenExpired.send(response.message)
                default:
                    break
                }
            }.store(in: &cancelable)

    }
    func readListConditionsAll(searchType:Int,query:String,page:Int,sort:String,order:Int){
        CommunityApiService.readListConditionsAll(searchType:searchType,query:query,page:page,sort:sort,order:order)
            .sink { comp in
                print(comp)
            } receiveValue: { [weak self] response in
                switch response.status{
                case 200...300:
                    self?.communityListResponse = response.data
                    guard let list = response.data?.postingDetailsResponseList else {return}
                    print(list)
                    self?.communityList.append(contentsOf: list)
                case 401:
                    AuthApiService.getToken()
                    self?.tokenExpired.send(response.message)
                default:
                    break
                }
            }.store(in: &cancelable)
    }
    func readDetailCommunity(postingId:Int){
        CommunityApiService.readPosting(postingId: postingId)
            .sink { comp in
                print(comp)
                self.success.send()
            } receiveValue: { [weak self] response in
                switch response.status{
                case 200...300:
                    self?.communityDetail = response.data
                case 401:
                    AuthApiService.getToken()
                    self?.tokenExpired.send(response.message)
                default:
                    break
                }
            }.store(in: &cancelable)
    }
    func like(postingId:Int,status:Int){
        CommunityApiService.postingLike(postingId: postingId, status: status)
            .sink { comp in
                print(comp)
            } receiveValue: { [weak self] response in
                switch response.status{
                case 401:
                    AuthApiService.getToken()
                    self?.tokenExpired.send(response.message)
                default:
                    break
                }
            }.store(in: &cancelable)
    }
    func modifyCommunity(postingId:Int,title:String,content:String,category:Int,spoiler:Bool){
        CommunityApiService.modifyCommunity(postingId: postingId, title: title, content: content, category: category, spoiler: spoiler)
            .sink { comp in
                print(comp)
            } receiveValue: { [weak self] response in
                switch response.status{
                case 200...300:
                    self?.posting = response
                    self?.success.send()
                case 401:
                    AuthApiService.getToken()
                    self?.tokenExpired.send(response.message)
                default:
                    break
                }
            }.store(in: &cancelable)

    }
    func deleteCommunity(postingId:Int){
        CommunityApiService.deletePosting(postingId: postingId)
            .sink { comp in
                print(comp)
            } receiveValue: { [weak self] response in
                switch response.status{
                case 200...300:
                    self?.deleteSuccess.send()
                case 401:
                    AuthApiService.getToken()
                    self?.tokenExpired.send(response.message)
                default:
                    break
                }
            }.store(in: &cancelable)
    }
    func addReply(postingId:Int,parentId:Int?,content:String){
        ReplyApiService.addReply(postingId: postingId, parentId: parentId, content: content)
            .sink { comp in
                print(comp)
            } receiveValue: { [weak self] response in
                switch response.status{
                case 200...300:
                    self?.readComment(postingId: response.data.commentId)
//                    self?.communityDetail?.commentListResponse.commentDetailsResponseList.append(<#T##newElement: CommentResponse##CommentResponse#>)
                case 401:
                    AuthApiService.getToken()
                    self?.tokenExpired.send(response.message)
                default:
                    break
                }
            }.store(in: &cancelable)
    }
    func modifyReply(commentId:Int,content:String){
        ReplyApiService.modifyReply(commentId: commentId, content: content)
            .sink { comp in
                print(comp)
            } receiveValue: { [weak self] response in
                switch response.status{
                case 200...300:
                    self?.modifySuccess.send()
                case 401:
                    AuthApiService.getToken()
                    self?.tokenExpired.send(response.message)
                default:
                    break
                }
            }.store(in: &cancelable)
    }
    func deleteyReply(commentId:Int){
        ReplyApiService.deleteReply(commentId: commentId)
            .sink { comp in
                print(comp)
            } receiveValue: { [weak self] response in
                switch response.status{
//                case 200...300:
//                    self?.commentDeleteSuccess.send()
                case 401:
                    AuthApiService.getToken()
                    self?.tokenExpired.send(response.message)
                default:
                    break
                }
            }.store(in: &cancelable)
    }
    func readComment(postingId:Int){
        CommunityApiService.readComment(postingId: postingId)
            .sink { comp in
                print(comp)
            } receiveValue: { [weak self] response in
                switch response.status{
                case 200...300:
                    guard let data = response.data else {return}
                    self?.communityDetail?.commentListResponse.commentDetailsResponseList.append(data)
                case 401:
                    AuthApiService.getToken()
                    self?.tokenExpired.send(response.message)
                default:
                    break
                }
            }.store(in: &cancelable)

    }
}
