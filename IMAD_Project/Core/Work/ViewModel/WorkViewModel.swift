//
//  WorkViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/18.
//

import Foundation
import Combine

class WorkViewModel:ObservableObject{
    
    @Published var workInfo:WorkInfo? = nil
    
    var success = PassthroughSubject<(),Never>()
    var cancelable = Set<AnyCancellable>()
    
    func getWorkInfo(id:Int,type:String){
        WorkApiService.workInfo(id: id, type: type)
            .sink { comp in
                print(comp)
                self.success.send()
            } receiveValue: { [weak self] work in
                self?.workInfo = work.data
            }.store(in: &cancelable)

    }
}
