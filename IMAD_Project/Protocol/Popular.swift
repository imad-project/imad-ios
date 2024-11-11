//
//  Popular.swift
//  IMAD_Project
//
//  Created by 유영웅 on 3/13/24.
//

import Foundation


enum PopularFilter{
    case review,posting
}=
protocol Popular{
    var popularFilter:PopularFilter{ get }
    var contentsTitle:String{ get }
    var title:String{ get }
    var spoiler:Bool{ get }
    var userProfile:String{ get }
    var userName:String{ get }
    var poster:String{ get }
    var backdrop:String{ get }
    var contents:String{ get }
}
class PopularResponse:Popular{
    var review:ReviewResponse?
    var posting:PostingResponse?
    required init(review:ReviewResponse? = nil,posting:PostingResponse? = nil) {
        self.review = review
        self.posting = posting
    }
    var popularFilter: PopularFilter{
        review != nil ? .review : .posting
    }
    var contentsTitle:String {
        return review?.contentsTitle ?? posting?.contentsTitle ?? ""
    }
    var backdrop:String{
        return review?.contentsBackdropPath ?? posting?.contentsBackdropPath ?? ""
    }
    var title:String {
        return review?.title ?? posting?.title ?? ""
    }
    var spoiler:Bool{
        return review?.spoiler ?? posting?.spoiler ?? false
    }
    var userProfile:String {
        return review?.userProfileImage ?? review?.userProfileImage ?? ""
    }
    var userName:String {
        return review?.userNickname ?? posting?.userNickname ?? ""
    }
    var poster:String {
        return review?.contentsPosterPath ?? posting?.contentsPosterPath ?? ""
    }
    var contents:String {
        return review?.content ?? posting?.content ?? ""
    }
}
