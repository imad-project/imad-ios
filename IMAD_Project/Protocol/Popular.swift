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
    func userProfile() -> Int
    func userName() -> String
    func poster() -> String
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
    
    func title() -> String {
        return review.title
    }
    
    func userProfile() -> Int {
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
    
    func title() -> String {
        return posting.title
    }
    
    func userProfile() -> Int {
        return posting.userProfileImage
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
