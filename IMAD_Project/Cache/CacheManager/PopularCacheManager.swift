//
//  PopularCache.swift
//  IMAD_Project
//
//  Created by 유영웅 on 9/23/24.
//

import Foundation

class PopularCacheManager{
    static let instance = PopularCacheManager()
    private let lock = NSLock()
    private init(){}
    
    var storage = [String:PopularCache]()
    var timeStamp = [String:Date]()
    
    func cachedData(key:String)->PopularCache?{
        guard let data = storage[key] else { return nil }
        return data
    }
    
    func updateData(key:String,data:PopularCache?){
        DispatchQueue.global(qos:.background).async {
            self.lock.lock()
            defer {self.lock.unlock()}
            guard let data else {return}
            self.timeStamp[key] = Date()
            self.storage.updateValue(data, forKey: key)
        }
    }
}
