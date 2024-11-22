//
//  ReviewCacheManager.swift
//  IMAD_Project
//
//  Created by 유영웅 on 11/21/24.
//

import Foundation

class ReviewCacheManager{
    static let instance = ReviewCacheManager()
    private let lock = NSLock()
    private init(){}
    
    var reviewStorage = [String:ReviewResponse]()
    var reviewListStorage = [String:ReviewCache]()
    var reviewTimeStamp = [String:Date]()
    var reviewListTimeStamp = [String:Date]()
    
    func reviewCachedData(key:String)->ReviewResponse?{
        guard let data = reviewStorage[key] else { return nil }
        return data
    }
    func reviewListCachedData(key:String)->ReviewCache?{
        guard let data = reviewListStorage[key] else { return nil }
        return data
    }
    func reviewOfUpdateData(data:ReviewResponse?){
        DispatchQueue.global(qos:.background).async {
            self.lock.lock()
            guard let data else {return}
            self.reviewTimeStamp["\(data.reviewID)"] = Date()
            self.reviewStorage.updateValue(data,forKey:"\(data.reviewID)")
            self.lock.unlock()
        }
    }
    func reviewListOfUpdateData(data:ReviewCache?,key:String){
        DispatchQueue.global(qos:.background).async {
            self.lock.lock()
            guard let data else {return}
            self.reviewListTimeStamp[key] = Date()
            self.reviewListStorage.updateValue(data,forKey:key)
            self.lock.unlock()
        }
    }
}
