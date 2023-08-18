//
//  String.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/18.
//

import Foundation


public extension String {
    func sha256() -> String {
        if let stringData = self.data(using: String.Encoding.utf8) {
            return stringData.sha256()
        }
        return ""
    }
    
    func base64() -> String {
        if let strData = self.data(using: .utf8) {
            return strData.base64EncodedString()
        }
        
        return ""
    }
    
    func getImadImage() -> String{
        return "https://image.tmdb.org/t/p" + "/original" + self
    }
}


