//
//  CGSize.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/29/24.
//

import Foundation

extension CGSize {
  static func + (lhs: Self, rhs: Self) -> Self {
    CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
  }
}
