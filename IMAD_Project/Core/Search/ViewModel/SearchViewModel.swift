//
//  SearchViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/11.
//

import Foundation
import Combine


class SearchViewModel:ObservableObject{
    
    var cancel = Set<AnyCancellable>()
    
    var textCancellable:AnyCancellable?
    var typeCancellable1:AnyCancellable?
    
    var tokenExpired = PassthroughSubject<String,Never>()
    
    @Published var searchText = ""
    @Published var work:[WorkResults] = []
    @Published var type:MovieTypeFilter = .multi
    @Published var currentPage = 1
    @Published var maxPage = 0
    
    init(work:[WorkResults]) {
        self.work = work
    }
    
    init(){
        textCancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] value in
                self?.work = []
                self?.currentPage = 1
                self?.maxPage = 0
                if value != ""{
                    self?.searchWork(query: value,type: self?.type ?? .multi,page: self?.currentPage ?? 0)
                }
            })
        typeCancellable1 = $type
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] value in
                self?.work = []
                self?.currentPage = 1
                self?.maxPage = 0
                self?.searchWork(query: self?.searchText ?? "",type: value,page: self?.currentPage ?? 0)
            })
    }
    func searchWork(query:String,type:MovieTypeFilter,page:Int){
        WorkApiService.workSearch(query: query, type: type.rawValue, page: page)
            .sink { completion in
                print(completion)
                self.currentPage = page
            } receiveValue: { [weak self] work in
                if work.status >= 200 && work.status < 300{
                    if let results = work.data?.results{
                        self?.work.append(contentsOf: results)
                    }
                    self?.maxPage = work.data?.totalPages ?? 0
                }else if work.status == 401{
//                    AuthApiService.getToken()
                    self?.tokenExpired.send(work.message)
                }
            }.store(in: &cancel)
        }
}
