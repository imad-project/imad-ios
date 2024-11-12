//
//  SearchTypeFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/16.
//

import Foundation

enum SearchCategory:CaseIterable{
    case titleContents
    case title
    case contents
    case writer
    var name:String{
        switch self{
        case .titleContents:
            return "제목+내용"
        case .title:
            return "제목"
        case .contents:
            return "내용"
        case .writer:
            return "글쓴이"
        }
    }
    var num:Int{
        switch self{
        case .titleContents:
            return 0
        case .title:
            return 1
        case .contents:
            return 2
        case .writer:
            return 3
        }
    }
}
