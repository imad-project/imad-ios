//
//  UIImage.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/5/24.
//

import Foundation
import UIKit

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
