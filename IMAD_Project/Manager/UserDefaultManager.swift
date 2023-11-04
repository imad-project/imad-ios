//
//  UserDefaultManager.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/13.
//

import Foundation

class UserDefaultManager{
  
    static let shared = UserDefaultManager()    //싱글톤
    
    enum Key:String,CaseIterable{
        case refreshToken,accessToken
    }
    
    func clearAll(){    //데이터 전체 삭제
        Key.allCases.forEach{UserDefaults.standard.removeObject(forKey: $0.rawValue)}
    }
    func setToken(accessToken:String,refreshToken:String){  //토큰 저장
        UserDefaults.standard.set(accessToken, forKey: Key.accessToken.rawValue)
        UserDefaults.standard.set(refreshToken, forKey: Key.refreshToken.rawValue)
        UserDefaults.standard.synchronize()
    }
    func getToken()->Token{
        let accessToken = UserDefaults.standard.string(forKey: Key.accessToken.rawValue) ?? ""
        let refreshToken = UserDefaults.standard.string(forKey: Key.refreshToken.rawValue) ?? ""
        return Token(accessToken: accessToken, refreshToken: refreshToken)
    }
}
