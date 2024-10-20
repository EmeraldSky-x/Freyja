//
//  KnobView.swift
//  Freyja
//
//  Created by Vijay Lal on 19/10/24.
//

import Foundation
import UIKit

class KnobView: UIView {
    lazy var ellipseOneShape: CAShapeLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: self.bounds)
        shape.path = path.cgPath
        return shape
    }()
    lazy var ellipsseOneColorGradient: CAGradientLayer = {
        let shape = CAGradientLayer()
        shape.colors = [
            UIColor(red: 0.10, green: 0.11, blue: 0.14, alpha: 1.00).cgColor,
            UIColor(red: 0.23, green: 0.24, blue: 0.26, alpha: 1.00).cgColor
        ]
        shape.frame = self.bounds
        shape.locations = [0.55, 1.0]
        shape.startPoint = CGPoint(x: 0, y: 0)
        shape.endPoint = CGPoint(x: 0, y: 1)
        shape.mask = ellipseOneShape
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
            UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00).cgColor,
            UIColor(red: 0.16, green: 0.17, blue: 0.20, alpha: 1.00).cgColor
        ]
        shape.frame = self.bounds
        shape.locations = [1.0, 1.0]
        shape.startPoint = CGPoint(x: 0, y: 0)
        shape.endPoint = CGPoint(x: 0, y: 0.70)
        shape.mask = ellipseTwoShape
        return shape
    }()
    lazy var ellipseThreeShape: CAShapeLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 44, y: 44, width: self.bounds.width - 88, height: self.bounds.height - 88))
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
        shape.locations = [0.0, 1.0]
        shape.startPoint = CGPoint(x: 0, y: 0)
        shape.endPoint = CGPoint(x: 0, y: 0.45)
        shape.mask = ellipseThreeShape
        return shape
    }()
    lazy var ellipseFourColorShape: CAShapeLayer = {
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 82, y: 82, width: self.bounds.width - 164, height: self.bounds.height - 164))
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
        self.layer.addSublayer(ellipseTwoColorGradient)
        self.layer.addSublayer(ellipseThreeColorGradient)
        self.layer.addSublayer(ellipseFourColorGradient)
    }
}

