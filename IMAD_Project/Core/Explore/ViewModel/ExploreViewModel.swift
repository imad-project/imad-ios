//
//  ExploreViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/09.
//

import Foundation
import Combine

//class ExploreViewModel:ObservableObject{
//    
//    @Published var exploreContent:Work? = nil
//    var cancelable = Set<AnyCancellable>()
//    
//    func getData(query:String,type:String,page:Int){
//        WorkApiService.workSearch(query: query, type: type, page: page)
//            .sink { completion in
//                print(self.exploreContent)
//            } receiveValue: { work in
//                self.exploreContent = work
//            }.store(in: &cancelable)
//
//    }
//}
