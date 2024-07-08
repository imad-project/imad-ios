//
//  ProfileImageViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/8/24.
//

import Foundation
import Combine

class ProfileImageViewModel:ObservableObject{
    
    var refreschTokenExpired = PassthroughSubject<(),Never>()
    var cancelable = Set<AnyCancellable>()
    @Published var message = ""
    @Published var customImage:Data?
    @Published var defaultImage:ProfileFilter = .indigo
    
    func fetchProfileImageCustom(image:Data){
        ProfileImageApiService.fetchProfileImageCustom(image: image)
            .sink { completion in
                print(completion)
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { [weak self] noData in
                self?.message = noData.message
            }.store(in: &cancelable)
    }
    func fetchProfileImageDefault(image:String){
        ProfileImageApiService.fetchProfileImageDefault(image: image)
            .sink { completion in
                print(completion)
//                switch completion{
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    self.refreschTokenExpired.send()
//                case .finished:
//                    print(completion)
//                }
            } receiveValue: { [weak self] noData in
                self?.message = noData.message
            }.store(in: &cancelable)
    }
}
