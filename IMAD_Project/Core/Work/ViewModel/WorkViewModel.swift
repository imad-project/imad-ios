//
//  WorkViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/18.
//

import Foundation
import Combine


class WorkViewModel:ObservableObject{
    
    @Published var workInfo:WorkResponse? = nil
//    @Published var bookmarkList:BookmarkResponse? = nil
//    @Published var bookmarkResponse:Bookmark? = nil
    
    @Published var bookmarkList:[BookmarkListResponse] = []
    
    @Published var currentPage = 1
    @Published var maxPage = 1
    var refreschTokenExpired = PassthroughSubject<(),Never>()
    
    var success = PassthroughSubject<Int?,Never>()  // 작품정보 불러오기 성공 후 contentsId 불러오기 위함
//    var success = PassthroughSubject<(),Never>()
//    var contentsIdSuccess = PassthroughSubject<Int,Never>()
    var cancelable = Set<AnyCancellable>()
    
    init(workInfo:WorkResponse?,bookmarkList:[BookmarkListResponse] ){
        self.workInfo = workInfo
        self.bookmarkList = bookmarkList
    }
    func getWorkInfo(contentsId:Int){
        WorkApiService.workInfo(contentsId:contentsId)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { [weak self] work in
                self?.workInfo = work.data
                self?.success.send(work.data?.contentsId)
            }.store(in: &cancelable)

    }
    func getWorkInfo(id:Int,type:String){
        WorkApiService.workInfo(id: id, type: type)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { [weak self] work in
                self?.workInfo = work.data
                self?.success.send(work.data?.contentsId)
            }.store(in: &cancelable)

    }
    func getBookmark(page:Int){
        WorkApiService.bookRead(page: page)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
                self.currentPage = page
            } receiveValue: { [weak self] bookmark in
                if let data = bookmark.data{
                    self?.bookmarkList.append(contentsOf: data.bookmarkDetailsList)
                    self?.maxPage = data.totalPages
                }
//                guard let data = bookmark.data else {return}
//                self?.bookmarkList = data
//                if let list = data.bookmarkDetailsList{
//                    self?.myBookmarkList.append(contentsOf: list)
//                }
            }.store(in: &cancelable)
    }
    func addBookmark(id:Int){
        WorkApiService.bookCreate(id: id)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in}.store(in: &cancelable)

    }
    func deleteBookmark(id:Int){
        WorkApiService.bookDelete(id: id)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in }.store(in: &cancelable)
    }
}
