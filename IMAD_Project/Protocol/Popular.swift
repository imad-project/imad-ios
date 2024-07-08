//
//  Popular.swift
//  IMAD_Project
//
//  Created by 유영웅 on 3/13/24.
//

import Foundation


enum PopularFilter{
    case review,community
}

protocol Popular{
    var popularFilter:PopularFilter { get }
    func contentsTitle() -> String
    func title() -> String
    func spoiler() -> Bool
    func userProfile() -> String
    func userName() -> String
    func poster() -> String
    func backdrop() -> String
    func contents() -> String
    
}

class PopularReviewClass:Popular{
    var popularFilter:PopularFilter = .review
    let review:PopularReviewResponse
    
    required init(review: PopularReviewResponse) {
        self.review = review
    }
    func contentsTitle() -> String {
        return review.contentsTitle
    }
    func backdrop() -> String{
        return review.contentsBackdropPath
    }
    func title() -> String {
        return review.title
    }
    func spoiler() -> Bool{
        return review.spoiler
    }
    func userProfile() -> String {
        return review.userProfileImage
    }
    
    func userName() -> String {
        return review.userNickname
    }
    
    func poster() -> String {
        return review.contentsPosterPath
    }
    
    func contents() -> String {
        return review.content
    }
    
}

class PopularPostingClass:Popular{
    var popularFilter: PopularFilter = .community
    let posting:PopularPostingResponse
    
    required init(posting:PopularPostingResponse) {
        self.posting = posting
    }
    
    func contentsTitle() -> String {
        return posting.contentsTitle
    }
    func backdrop() -> String{
        return posting.contentsBackdropPath
    }
    func title() -> String {
        return posting.title
    }
    
    func userProfile() -> String {
        return posting.userProfileImage
    }
    func spoiler() -> Bool{
        return posting.spoiler
    }
    func userName() -> String {
        return posting.userNickname
    }
    
    func poster() -> String {
        return posting.contentsPosterPath
    }
    
    func contents() -> String {
        return posting.content
    }
    
    
}
