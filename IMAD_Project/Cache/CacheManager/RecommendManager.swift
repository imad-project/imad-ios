//
//  RecommendManager.swift
//  IMAD_Project
//
//  Created by 유영웅 on 9/19/24.
//

import Foundation
import UIKit

class RecommendCacheManager{
    static let instance = RecommendCacheManager()
    private let lock = NSLock()
    private init(){}
    
    var recommendAllOfStorage = [String:AllRecommendResponse]()
    var recommendListOfStorage = [String:RecommendCache]()
    var timeStamp = [String:Date]()
    
    func recommendAllOfCachedData(key:String)->AllRecommendResponse?{
        return recommendAllOfStorage[key]
    }
    func recommendListOfCachedData(key:String)->RecommendCache?{
        return recommendListOfStorage[key]
    }
    func recommendAllOfUpdateData(key:String,data:AllRecommendResponse?){
        DispatchQueue.global(qos:.background).async {
            self.lock.lock()
            guard let data else {return}
            self.timeStamp[key] = Date()
            self.recommendAllOfStorage.updateValue(data, forKey: key)
            self.lock.unlock()
        }
    }
    func recommendListOfUpdateData(key:String,data:RecommendCache?){
        DispatchQueue.global(qos:.background).async {
            self.lock.lock()
            guard let data else {return}
            self.timeStamp[key] = Date()
            self.recommendListOfStorage.updateValue(data, forKey: key)
            self.lock.unlock()
        }
    }
}
