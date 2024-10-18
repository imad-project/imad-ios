//
//  LinearGradient.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/15/24.
//

import Foundation
import SwiftUI

extension LinearGradient{
    static var theme:[LinearGradient]{
        return [
            LinearGradient(colors: [.green.opacity(0.6),.cyan.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing),
            LinearGradient(colors: [.pink.opacity(0.6),.yellow.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing),
            LinearGradient(colors: [.gray.opacity(0.4),.gray.opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing),
            LinearGradient(colors: [.purple.opacity(0.7),.red.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing),
            LinearGradient(colors: [.brown.opacity(0.5),.orange.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
        ].shuffled()
    }
}
