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
    @Published var bookmarkList:BookmarkResponse? = nil
    @Published var bookmarkResponse:Bookmark? = nil
    
    @Published var myBookmarkList:[BookmarkDetailsList] = []
    
    @Published var page = 1
    
    var success = PassthroughSubject<(),Never>()
    var contentsIdSuccess = PassthroughSubject<Int,Never>()
    var cancelable = Set<AnyCancellable>()
    
    init(workInfo:WorkResponse?){
        self.workInfo = workInfo
    }
    func getWorkInfo(contentsId:Int){
        WorkApiService.workInfo(contentsId:contentsId)
            .sink { comp in
                print(comp)
                self.success.send()
            } receiveValue: { [weak self] work in
                self?.workInfo = work.data
            }.store(in: &cancelable)

    }
    func getWorkInfo(id:Int,type:String){
        WorkApiService.workInfo(id: id, type: type)
            .sink { comp in
                print(comp)
                self.contentsIdSuccess.send(self.workInfo?.contentsId ?? 0)
                self.success.send()
            } receiveValue: { [weak self] work in
                self?.workInfo = work.data
            }.store(in: &cancelable)

    }
    func getBookmark(page:Int){
        WorkApiService.bookRead(page: page)
            .sink { comp in
                print(comp)
            } receiveValue: { [weak self] bookmark in
                guard let data = bookmark.data else {return}
                self?.bookmarkList = data
                if let list = data.bookmarkDetailsList{
                    self?.myBookmarkList.append(contentsOf: list)
                }
            }.store(in: &cancelable)
    }
    func addBookmark(id:Int){
        WorkApiService.bookCreate(id: id)
            .sink { comp in
                print(comp)
            } receiveValue: { [weak self] bookmark in
                self?.bookmarkResponse = bookmark
            }.store(in: &cancelable)

    }
    func deleteBookmark(id:Int){
        WorkApiService.bookDelete(id: id)
            .sink { comp in
                print(comp)
            } receiveValue: { [weak self] bookmark in
                self?.bookmarkResponse = bookmark
            }.store(in: &cancelable)
    }
}
