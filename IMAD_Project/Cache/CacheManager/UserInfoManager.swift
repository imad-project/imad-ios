//
//  AuthToken.swift
//  IMAD_Project
//
//  Created by 유영웅 on 11/6/24.
//

import Foundation

class UserInfoManager:ObservableObject{
    static let instance = UserInfoManager()
    private let lock = NSLock()
    private init(){}
    
    @Published var cache:UserResponse?
    
    func dataUpdate(data:UserResponse?){
        DispatchQueue.global(qos:.background).async{
            self.lock.lock()
            guard let data else {return}
            DispatchQueue.main.async {
                self.cache = data
            }
            self.lock.unlock()
        }
    }
}
