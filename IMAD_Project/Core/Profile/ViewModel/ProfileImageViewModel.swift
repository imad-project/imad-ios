//
//  ProfileImageViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/8/24.
//

import Foundation
import Combine

class ProfileImageViewModel:ObservableObject{
    
    var isFailedProfileChanged = PassthroughSubject<(alert:Bool,message:String),Never>()
    var isSuccessProfileChanged = PassthroughSubject<(),Never>()
    var cancelable = Set<AnyCancellable>()
    
    @Published var url = ""
    @Published var customImage:Data?
    @Published var defaultImage:ProfileImageColorCategory = .indigo
    
    func fetchProfileImageCustom(image:Data){
        ProfileImageApiService.fetchProfileCustomImage(image: image)
            .sink { completion in
                ErrorManager.instance.actionErrorMessage(completion: completion) {
                    self.isSuccessProfileChanged.send()
                } failed: {
                    self.isFailedProfileChanged.send((true,"프로필 사진 업로드에 실패했습니다."))
                }
            } receiveValue: { [weak self] data in
                guard let data = data.data else {return}
                self?.url = data.url
            }.store(in: &cancelable)
    }
    func fetchProfileImageDefault(image:String){
        ProfileImageApiService.fetchProfileDefaultImage(image: image)
            .sink { completion in
                ErrorManager.instance.actionErrorMessage(completion: completion) {
                    DispatchQueue.main.async{
                        self.isSuccessProfileChanged.send()
                    }
                } failed: {
                    self.isFailedProfileChanged.send((true,"프로필 사진 업로드에 실패했습니다."))
                }
            } receiveValue: { [weak self] data in
                guard let data = data.data else {return}
                self?.url = data.url
            }.store(in: &cancelable)
    }
}
