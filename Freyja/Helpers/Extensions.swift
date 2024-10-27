//
//  Extensions.swift
//  Freyja
//
//  Created by Vijay Lal on 22/10/24.
//

import Foundation
import UIKit

extension CAGradientLayer {
    static func returnGradient(colors: [CGColor], locations: [NSNumber], maskLayer: CAShapeLayer) -> CAGradientLayer {
        let shape = CAGradientLayer()
        shape.colors = colors
        shape.locations = locations
        shape.startPoint = CGPoint(x: 0, y: 1)
        shape.endPoint = CGPoint(x: 0, y: 0)
        shape.mask = maskLayer
        return shape
    }
}
