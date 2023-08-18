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
