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
    func translationKorean() -> String{
  
        switch self{
        case "Producer":
            return "프로듀서"
        case "Executive Producer":
            return "총괄 프로듀서"
        case "Director":
            return "감독"
        case "Writer":
            return "작가"
        case "Story":
            return "스토리"
        case "Screenplay":
            return "각본"
        default:
            return "기타"
        }
        
    }
    func relativeTime() -> String {
        let currentDate = Date()
        let calendar = Calendar.current

        
        let inputDate = self.toDate()
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: inputDate, to: currentDate)

        if let years = components.year, years > 0 {
            return "\(years)년 전"
        } else if let months = components.month, months > 0 {
            return "\(months)달 전"
        } else if let days = components.day, days > 0 {
            return "\(days)일 전"
        } else if let hours = components.hour, hours > 0 {
            return "\(hours)시간 전"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes)분 전"
        } else {
            return "방금 전"
        }
    }
    func toDate() -> Date{
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        return formatter.date(from: self)!
    }
    func getImageCode()->Int{
            let index = self.index(self.endIndex, offsetBy: -5)
            let character = self[index]
            let number = Int(String(character))!
            return number
           
    }
    func getImageURL()->String{
        "https://\(Bundle.main.infoDictionary?["IMAGE_PATH"] ?? "")\(self)"
    }
}


