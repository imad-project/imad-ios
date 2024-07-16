//
//  ProfileImageViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/8/24.
//

import Foundation
import Combine

class ProfileImageViewModel:ObservableObject{
    
    var failed = PassthroughSubject<(),Never>()
    var profileChanged = PassthroughSubject<(),Never>()
    var cancelable = Set<AnyCancellable>()
    
    @Published var url = ""
    @Published var customImage:Data?
    @Published var defaultImage:ProfileFilter = .indigo
    
    func fetchProfileImageCustom(image:Data){
        ProfileImageApiService.fetchProfileImageCustom(image: image)
            .sink { completion in
                print(completion)
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.failed.send()
                case .finished:
                    self.profileChanged.send()
                    print(completion)
                }
            } receiveValue: { [weak self] noData in
                self?.url = noData.data?.url ?? ""
            }.store(in: &cancelable)
    }
    func fetchProfileImageDefault(image:String){
        ProfileImageApiService.fetchProfileImageDefault(image: image)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.failed.send()
                case .finished:
                    self.profileChanged.send()
                    print(completion)
                }
            } receiveValue: { [weak self] noData in
                self?.url = noData.data?.url ?? ""
            }.store(in: &cancelable)
    }
}
