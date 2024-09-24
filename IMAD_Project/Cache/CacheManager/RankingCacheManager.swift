//
//  RnakingManager.swift
//  IMAD_Project
//
//  Created by 유영웅 on 9/19/24.
//

import Foundation

class RankingCacheManager{
    static let instance = RankingCacheManager()
    private let lock = NSLock()
    private init(){}
    
    var storage = [String:RankingCache]()
    var timeStamp = [String:Date]()
    
    func cachedData(key:String)->RankingCache?{
        guard let data = storage[key] else { return nil }
        return data
    }
    
    func updateData(data:RankingCache?){
        self.lock.lock()
        guard let data else {return}
        timeStamp[data.id] = Date()
        storage.updateValue(data, forKey: data.id)
        self.lock.unlock()
    }
}
