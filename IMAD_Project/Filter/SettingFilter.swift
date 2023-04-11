//
//  SettingFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/11.
//

import Foundation

enum SettingFilter:CaseIterable{
    case review
    case posting
    case bookmark
    case qna
    case notice
    case setting
    
    var image:String{
        switch self{
        case .review:
            return "ellipsis.message.fill"
        case .posting:
            return "books.vertical.fill"
        case .bookmark:
            return "bookmark.fill"
        case .setting:
            return "gear"
        case .qna:
            return "questionmark.square.fill"
        case .notice:
            return "note.text"
        }
    }
    var name:String{
        switch self{
        case .review:
            return "리뷰"
        case .posting:
            return "게시물"
        case .bookmark:
            return "북마크"
        case .setting:
            return "설정"
        case .qna:
            return "자주 묻는 질문"
        case .notice:
            return "공지사항"
        }
    }
}
