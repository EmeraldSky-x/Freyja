//
//  KnobView.swift
//  Freyja
//
//  Created by Vijay Lal on 19/10/24.
//

import Foundation
import UIKit

class KnobView: UIView {
    lazy var backgroundEllipse: CAShapeLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 3, y: 3, width: self.bounds.width - 6, height: self.bounds.height - 6))
        shape.path = path.cgPath
        return shape
    }()
    lazy var backgroundEllipseColorGradient: CAGradientLayer = {
        let shape = CAGradientLayer()
        shape.colors = [
            
            UIColor(red: 0.10, green: 0.11, blue: 0.14, alpha: 1.0).cgColor,
            UIColor(red: 0.23, green: 0.24, blue: 0.26, alpha: 1.20).cgColor
        ]
        shape.frame = self.bounds
        shape.locations = [0.30, 1.0]
        shape.startPoint = CGPoint(x: 0, y: 0)
        shape.endPoint = CGPoint(x: 0, y: 1)
        shape.mask = backgroundEllipse
        return shape
    }()
    
    lazy var ellipseOneShape: CAShapeLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: self.bounds)
        shape.path = path.cgPath
        return shape
    }()
    lazy var ellipsseOneColorGradient: CAGradientLayer = {
        let shape = CAGradientLayer()
        shape.colors = [
            UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.20).cgColor,
            UIColor(red: 0.23, green: 0.24, blue: 0.26, alpha: 0.15).cgColor
            
        ]
        shape.frame = self.bounds
        shape.locations = [0.50, 0.70]
        shape.startPoint = CGPoint(x: 0, y: 1)
        shape.endPoint = CGPoint(x: 0, y: 0)
        shape.mask = ellipseOneShape
        return shape
    }()
    
    lazy var subEllipseTwoShape: CAShapeLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 27, y: 27, width: self.bounds.width - 54, height: self.bounds.height - 54))
        shape.path = path.cgPath
        return shape
    }()
    lazy var subEllipseTwoColorGradient: CAGradientLayer = {
        let shape = CAGradientLayer()
        shape.colors = [
            UIColor(red: 0.10, green: 0.11, blue: 0.14, alpha: 0.10).cgColor,
            UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.20).cgColor
        ]
        shape.frame = self.bounds
        shape.locations = [0.60, 1.0]
        shape.startPoint = CGPoint(x: 0, y: 0)
        shape.endPoint = CGPoint(x: 0, y: 1)
        shape.mask = subEllipseTwoShape
        return shape
    }()
    lazy var backgroundellipseTwoShape: CAShapeLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 29, y: 29, width: self.bounds.width - 58, height: self.bounds.height - 58))
        shape.path = path.cgPath
        return shape
    }()
    lazy var backgroundEllipseTwoColorGradient: CAGradientLayer = {
        let shape = CAGradientLayer()
        shape.colors = [
            UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.90).cgColor,
            UIColor.white.cgColor
        ]
        shape.frame = self.bounds
        shape.locations = [1.0, 1.0]
        shape.startPoint = CGPoint(x: 0, y: 0)
        shape.endPoint = CGPoint(x: 0, y: 1)
        shape.mask = backgroundellipseTwoShape
        return shape
    }()
    lazy var ellipseTwoShape: CAShapeLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 30, y: 30, width: self.bounds.width - 60, height: self.bounds.height - 60))
        shape.path = path.cgPath
        return shape
    }()
    lazy var ellipseTwoColorGradient: CAGradientLayer = {
        let shape = CAGradientLayer()
        shape.colors = [
            UIColor(red: 0.09, green: 0.09, blue: 0.11, alpha: 1.0).cgColor,
            UIColor(red: 0.13, green: 0.15, blue: 0.17, alpha: 0.50).cgColor
            
//            UIColor(red: 0.11, green: 0.12, blue: 0.15, alpha: 1.00)
        ]
        shape.frame = self.bounds
        shape.locations = [0.60, 1.0]
        shape.startPoint = CGPoint(x: 0, y: 0)
        shape.endPoint = CGPoint(x: 0, y: 1)
        shape.mask = ellipseTwoShape
        return shape
    }()
    
    lazy var ellipseThreeShape: CAShapeLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 48, y: 48, width: self.bounds.width - 96, height: self.bounds.height - 96))
        shape.path = path.cgPath
        return shape
    }()
    lazy var ellipseThreeColorGradient: CAGradientLayer = {
        let shape = CAGradientLayer()
        shape.frame = self.bounds
        shape.colors = [
            UIColor(red: 0.20, green: 0.22, blue: 0.25, alpha: 1.00).cgColor,
            UIColor(red: 0.11, green: 0.12, blue: 0.15, alpha: 1.00).cgColor,
        ]
        shape.locations = [0.30, 0.90]
        shape.startPoint = CGPoint(x: 0, y: 0)
        shape.endPoint = CGPoint(x: 0, y: 0.45)
        shape.mask = ellipseThreeShape
        return shape
    }()
    
    lazy var backgroundEllipseThreeShape: CAShapeLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 46, y: 46, width: self.bounds.width - 92, height: self.bounds.height - 92))
        shape.path = path.cgPath
        return shape
    }()
    lazy var backgroundColourEllipseThreeColorGradient: CAGradientLayer = {
        let shape = CAGradientLayer()
        shape.frame = self.bounds
        shape.colors = [
            UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.20).cgColor,
            UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.40).cgColor
        ]
        shape.locations = [0.25, 0.50]
        shape.startPoint = CGPoint(x: 0, y: 0)
        shape.endPoint = CGPoint(x: 0, y: 1)
        shape.mask = backgroundEllipseThreeShape
        return shape
    }()
    
    lazy var ellipseFourColorShape: CAShapeLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 90, y: 90, width: self.bounds.width - 180, height: self.bounds.height - 180))
        shape.path = path.cgPath
        return shape
    }()
    lazy var ellipseFourColorGradient: CAGradientLayer = {
        let shape = CAGradientLayer()
        shape.frame = self.bounds
        shape.colors = [
            UIColor(red: 0.10, green: 0.11, blue: 0.14, alpha: 1.00).cgColor,
            UIColor(red: 0.23, green: 0.24, blue: 0.26, alpha: 1.00).cgColor,
        ]
        shape.locations = [0.40, 1.0]
        shape.startPoint = CGPoint(x: 0, y: 0)
        shape.endPoint = CGPoint(x: 0, y: 1)
        shape.mask = ellipseFourColorShape
        return shape
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
        self.layer.addSublayer(ellipsseOneColorGradient)
        self.layer.addSublayer(backgroundEllipseColorGradient)
        self.layer.addSublayer(subEllipseTwoColorGradient)
        self.layer.addSublayer(backgroundEllipseTwoColorGradient)
        self.layer.addSublayer(ellipseTwoColorGradient)
        self.layer.addSublayer(backgroundColourEllipseThreeColorGradient)
        self.layer.addSublayer(ellipseThreeColorGradient)
        self.layer.addSublayer(ellipseFourColorGradient)
        
    }
}

