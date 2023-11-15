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
    
    var refreschTokenExpired = PassthroughSubject<(),Never>()
    
    @Published var searchText = ""
    @Published var work:[WorkListResponse] = []
    @Published var type:MovieTypeFilter = .multi
    @Published var currentPage = 1
    @Published var maxPage = 0
    
    init(work:[WorkListResponse]) {
        self.work = work
    }
    
    init(){
        textCancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] value in
                self?.initializingOption()
                if value != ""{
                    self?.searchWork(query: value,type: self?.type ?? .multi,page: self?.currentPage ?? 0)
                }
            })
        typeCancellable1 = $type
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] value in
                self?.initializingOption()
                self?.searchWork(query: self?.searchText ?? "",type: value,page: self?.currentPage ?? 0)
            })
    }
    private func initializingOption(){
        self.work = []
        self.currentPage = 1
        self.maxPage = 0
    }
    func searchWork(query:String,type:MovieTypeFilter,page:Int){
        WorkApiService.workSearch(query: query, type: type.rawValue, page: page)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
                self.currentPage = page
            } receiveValue: { [weak self] work in
                    if let results = work.data{
                        self?.work.append(contentsOf: results.results)
                        self?.maxPage = results.totalPages
                    }
            }.store(in: &cancel)
        }
   
}
