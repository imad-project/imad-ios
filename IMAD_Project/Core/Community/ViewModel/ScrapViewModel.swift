//
//  ScrapViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/22.
//

import Foundation
import Combine

class ScrapViewModel:ObservableObject{
    
    @Published var scrapList:[ScrapListResponse] = []
    @Published var currentPage = 1
    @Published var maxPage = 1
    
    var cancel = Set<AnyCancellable>()
    
    
    init(scrapList:[ScrapListResponse]) {
        self.scrapList = scrapList
    }
    
    func readScrapList(page:Int){
        ScrapApiService.readScrap(page: page)
            .sink { completion in
                self.currentPage = page
                print(completion)
            } receiveValue: { [weak self] data in
                guard let response = data.data else {return}
                self?.scrapList.append(contentsOf: response.detailList)
                self?.maxPage = response.totalPages
            }.store(in: &cancel)
    }
    func writeScrap(postingId:Int){
        ScrapApiService.writeScrap(postingId: postingId)
            .sink { completion in
                print(completion)
            } receiveValue: { _ in }.store(in: &cancel)
    }
    func deleteScrap(scrapId:Int){
        ScrapApiService.deleteScrap(scrapId: scrapId)
            .sink { completion in
                print(completion)
            } receiveValue: { _ in }.store(in: &cancel)
    }
}
