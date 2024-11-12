//
//  UserViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/20/24.
//

import Foundation
import Combine

class UserViewModel:ObservableObject{
    
    var cancelable = Set<AnyCancellable>()
    var refreschTokenExpired = PassthroughSubject<(),Never>()
    @Published var profile:ProfileResponse? = nil
    @Published var currentPage = 1
    @Published var maxPage = 1
    @Published var bookmarkList:[BookmarkResponse] = []
    
    func fetchProfile(id:Int,page:Int){
        UserApiService.otheruUser(id: id)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
                self.currentPage = page
            } receiveValue: { [weak self] profile in
                if let data = profile.data{
                    self?.profile = data
                    self?.bookmarkList.append(contentsOf:data.bookmarkListResponse.detailList)
                    self?.maxPage = data.bookmarkListResponse.totalPages
                }
            }.store(in: &cancelable)
    }
}
