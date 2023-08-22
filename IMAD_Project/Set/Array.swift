//
//  Array.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/18.
//

import Foundation

extension Array {
    func chunks(ofCount chunkSize: Int) -> [[Element]] {
        stride(from: 0, to: count, by: chunkSize).map { startIndex in
            let endIndex = Swift.min(startIndex + chunkSize, count)
            return Array(self[startIndex..<endIndex])
        }
    }
}
extension Array<Int>{
    func transMovieGenreCode() -> String{
        var stringArr:[String] = []
        for i in MovieGenreFilter.allCases{
            if self.contains(i.rawValue){
                stringArr.append(i.name)
            }
        }
        return stringArr.joined(separator: ", ")
    }
    func transTvGenreCode() -> String{
        var stringArr:[String] = []
        for i in TVGenreFilter.allCases{
            if self.contains(i.rawValue){
                stringArr.append(i.name)
            }
        }
        return stringArr.joined(separator: ", ")
    }
}
