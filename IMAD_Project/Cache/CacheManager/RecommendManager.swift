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
    
    var storage = [String:AllRecommendResponse]()
    var timeStamp = Date()
    
    func cachedData(key:String)->AllRecommendResponse?{
        guard let data = storage[key] else { return nil }
        return data
    }
    
    func updateData(key:String,data:AllRecommendResponse?){
        self.lock.lock()
        guard let data else {return}
        timeStamp = Date()
        storage.updateValue(data, forKey: key)
        self.lock.unlock()
    }
}
