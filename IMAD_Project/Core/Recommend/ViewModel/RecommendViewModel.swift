//
//  RecommendViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation
import Combine

class RecommendViewModel:ObservableObject{
    
    var canelable = Set<AnyCancellable>()
    @Published var recommendAll:AllRecommendResponse? = nil
    
    
    func fetchAllRecommend(){
        RecommendApiService.all()
            .sink { completion in
                print(completion)
                switch completion{
                case .finished:
                    print(completion)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] work in
                self?.recommendAll = work.data
            }.store(in: &canelable)

    }
}
