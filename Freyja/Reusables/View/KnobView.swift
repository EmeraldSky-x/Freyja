//
//  KnobView.swift
//  Freyja
//
//  Created by Vijay Lal on 19/10/24.
//

import Foundation
import UIKit

class KnobView: UIView {
    
    lazy var outerRimDarkShadow: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.path = UIBezierPath(ovalIn: self.bounds).cgPath
        shape.fillColor = UIColor.black.cgColor
        shape.shadowPath = shape.path
        shape.shadowColor = UIColor(red: 0.08, green: 0.08, blue: 0.10, alpha: 1.00).cgColor
        shape.shadowOpacity = 1.0
        shape.shadowRadius = 20
        shape.shadowOffset = CGSize(width: 20, height: 20)
        return shape
    }()
    lazy var outerRimLightShadow: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.path = UIBezierPath(ovalIn: self.bounds).cgPath
        shape.fillColor = UIColor.black.cgColor
        shape.shadowPath = shape.path
        shape.shadowColor = UIColor(red: 0.22, green: 0.23, blue: 0.26, alpha: 1.00).cgColor
        shape.shadowOpacity = 1.0
        shape.shadowRadius = 40
        shape.shadowOffset = CGSize(width: -20, height: -20)
        return shape
    }()
    lazy var outerRimShape: CAGradientLayer = {
        let shape = CAShapeLayer()
        shape.path = UIBezierPath(ovalIn: self.bounds).cgPath
        shape.shadowColor = UIColor.white.cgColor
        shape.shadowOffset = CGSize(width: 5, height: 5)
        shape.fillColor = UIColor(red: 0.22, green: 0.23, blue: 0.26, alpha: 1.00).cgColor
        let gradient = CAGradientLayer.returnGradient(colors: [UIColor(red: 0.22, green: 0.23, blue: 0.26, alpha: 1.00).cgColor,
                                                               UIColor(red: 0.16, green: 0.17, blue: 0.20, alpha: 1.00).cgColor],
                                                      locations: [0.30, 1.0], maskLayer: shape)
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.type = .radial
        gradient.shadowRadius = 20
        gradient.opacity = 1.0
        return gradient
    }()
    lazy var outerRimInnerReflection: CAGradientLayer = {
        let shape = CAShapeLayer()
        let width = self.bounds.width * 84 / 100
        let padding = self.bounds.width * 8.20 / 100
        let path = UIBezierPath(ovalIn: CGRect(x: padding, y: padding, width: width, height: width))
        shape.path = path.cgPath
        let gradient = CAGradientLayer.returnGradient( colors: [
            UIColor(red: 0.10, green: 0.11, blue: 0.14, alpha: 0.10).cgColor,
            UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.20).cgColor,
        ],locations: [0.60, 1.0], maskLayer: shape)
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    lazy var grooveShape: CAGradientLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 29, y: 29, width: self.bounds.width - 58, height: self.bounds.height - 58))
        shape.path = path.cgPath
        let gradient = CAGradientLayer.returnGradient(colors: [UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.90).cgColor,
                                                               UIColor.white.cgColor],
                                                      locations: [1.0, 1.0], maskLayer: shape)
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    lazy var grooveGradient: CAGradientLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 30, y: 30, width: self.bounds.width - 60, height: self.bounds.height - 60))
        shape.path = path.cgPath
        let gradient = CAGradientLayer.returnGradient(colors: [UIColor(red: 0.09, green: 0.09, blue: 0.11, alpha: 1.0).cgColor,
                                                               UIColor(red: 0.13, green: 0.15, blue: 0.17, alpha: 0.50).cgColor],
                                                      locations: [0.60, 1.0], maskLayer: shape)
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    lazy var knobBaseShape: CAGradientLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 40, y: 40, width: self.bounds.width - 80, height: self.bounds.height - 80))
        shape.path = path.cgPath
        let gradient = CAGradientLayer.returnGradient(colors: [UIColor(red: 0.20, green: 0.21, blue: 0.24, alpha: 1.00).cgColor,
                                                               UIColor(red: 0.16, green: 0.17, blue: 0.20, alpha: 1.00).cgColor],
                                                      locations: [0.30, 0.90], maskLayer: shape)
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.type = .radial
        return gradient
    }()
    lazy var knobOuterReflection: CAGradientLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 39, y: 39, width: self.bounds.width - 78, height: self.bounds.height - 78))
        shape.path = path.cgPath
        
        let gradient = CAGradientLayer.returnGradient(colors: [UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.20).cgColor,
                                                               UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.40).cgColor],
                                                      locations: [0.25, 0.50], maskLayer: shape)
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    lazy var whiteIndicationLight: CAShapeLayer = {
        let shape = CAShapeLayer()
        let width = self.bounds.width * 2.5 / 100
        let topDistance: CGFloat = 17.3 * 346 / 100
        let path = UIBezierPath(ovalIn: CGRect(x: (self.bounds.width / 2) - width / 2, y: topDistance, width: width, height: width))
        shape.path = path.cgPath
        shape.fillColor = UIColor.white.cgColor
        shape.shadowColor = UIColor.white.cgColor
        shape.shadowRadius = 10
        shape.shadowOpacity = 1.0
        shape.shadowOffset = CGSize(width: 1, height: 1)
        return shape
    }()
    lazy var screenShadow: CAShapeLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 90, y: 90, width: self.bounds.width - 180, height: self.bounds.height - 184))
        shape.path = path.cgPath
        shape.fillColor = UIColor(red: 0.17, green: 0.18, blue: 0.21, alpha: 1.00).cgColor
        shape.shadowColor = UIColor(red: 0.10, green: 0.11, blue: 0.14, alpha: 1.00).cgColor
        shape.shadowOffset = CGSize(width: 0, height: 0)
        shape.shadowRadius = 8
        shape.shadowOpacity = 0.8
        return shape
    }()
    lazy var screenShape: CAGradientLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 91, y: 91, width: self.bounds.width - 182, height: self.bounds.height - 182))
        shape.path = path.cgPath
        let gradient = CAGradientLayer.returnGradient(colors: [UIColor(red: 0.10, green: 0.11, blue: 0.14, alpha: 1.00).cgColor,
                                                               UIColor.black.cgColor],
                                                      locations: [0.40, 1.0], maskLayer: shape)
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        initViews()
    }
}
extension KnobView {
    func initViews() {
        self.backgroundColor = .clear
        
        self.layer.addSublayer(outerRimLightShadow)
        self.layer.addSublayer(outerRimDarkShadow)
        self.layer.addSublayer(outerRimShape)
        self.layer.addSublayer(outerRimInnerReflection)
        self.layer.addSublayer(grooveShape)
        self.layer.addSublayer(grooveGradient)
        self.layer.addSublayer(knobOuterReflection)
        self.layer.addSublayer(knobBaseShape)
        self.layer.addSublayer(whiteIndicationLight)
        self.layer.addSublayer(screenShadow)
        self.layer.addSublayer(screenShape)
        
    }
}

