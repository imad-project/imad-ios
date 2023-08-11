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
    
    @Published var searchText = ""
    @Published var work:[WorkResults] = []
    @Published var type:MovieTypeFilter = .multi
    @Published var currentPage = 1
    @Published var maxPage = 0
    
    init(){
        
        textCancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                self.work = []
                self.currentPage = 1
                self.maxPage = 0
                if value != ""{
                    self.fetchPlaces(query: value,type: self.type,page: self.currentPage)
                }
            })
        typeCancellable1 = $type
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                self.work = []
                self.currentPage = 1
                self.maxPage = 0
                self.fetchPlaces(query: self.searchText,type: value,page: self.currentPage)
            })
        
        
    }
    func fetchPlaces(query:String,type:MovieTypeFilter,page:Int){
        WorkApiService.workSearch(query: query, type: type.rawValue, page: page)
            .sink { completion in
                print(completion)
                self.currentPage = page
            } receiveValue: { work in
                if let results = work.data?.results{
                    self.work.append(contentsOf: results)
                }
                self.maxPage = work.data?.totalPages ?? 0
            }.store(in: &cancel)
        }
}
