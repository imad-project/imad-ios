//
//  RnakingManager.swift
//  IMAD_Project
//
//  Created by 유영웅 on 9/19/24.
//

import Foundation

class RankingManager{
    static let instance = RankingManager()
    private let lock = NSLock()
    private init(){}
    
    var storage = [String:[RankingResponseList]]()
    var timeStamp = [String:Date]()
    
    func cachedData(key:String)->[RankingResponseList]?{
        guard let data = storage[key] else { return nil }
        return data
    }
    
    func updateData(key:String,data:[RankingResponseList]?){
        self.lock.lock()
        guard let data else {return}
        timeStamp[key] = Date()
        storage.updateValue(data, forKey: key)
        self.lock.unlock()
    }
}
