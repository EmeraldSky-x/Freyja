//
//  KnobView.swift
//  Freyja
//
//  Created by Vijay Lal on 19/10/24.
//

import Foundation
import UIKit
import CoreGraphics

class KnobView: UIView {
    weak var delegate: KnobViewDelegate?
    lazy var tapGesture: UIPanGestureRecognizer = {
        let tap = UIPanGestureRecognizer(target: self, action: #selector(screenTapped))
        return tap
    }()
    lazy var outerRimDarkShadow: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.path = UIBezierPath(ovalIn: self.bounds).cgPath
        shape.fillColor = UIColor.black.cgColor
        shape.shadowPath = shape.path
        shape.shadowColor = UIColor.rimDarkShadowColor.cgColor
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
        shape.shadowColor = UIColor.rimLightShadowColor.cgColor
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
        let gradient = CAGradientLayer.returnGradient(colors: [UIColor.rimGradientColorStart.cgColor,
                                                               UIColor.rimGradientColorEnd.cgColor],
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
        let padding = self.bounds.width * 8.50 / 100
        let path = UIBezierPath(ovalIn: CGRect(x: padding, y: padding, width: width, height: width))
        shape.path = path.cgPath
        let gradient = CAGradientLayer.returnGradient( colors: [UIColor.rimOuterReflectionColorStart.cgColor,
                                                                UIColor.rimOuterReflectionColorEnd.cgColor],
                                                       locations: [0.60, 1.0], maskLayer: shape)
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    lazy var grooveShape: CAGradientLayer = {
        let shape = CAShapeLayer()
        let width = self.bounds.width * 84 / 100
        let padding = self.bounds.width * 8.10 / 100
        let path = UIBezierPath(ovalIn: CGRect(x: padding, y: padding, width: width, height: width))
        shape.path = path.cgPath
        let gradient = CAGradientLayer.returnGradient(colors: [UIColor.grooveShapeColorStart.cgColor,
                                                               UIColor.grooveShapeColorEnd.cgColor,],
                                                      locations: [1.0, 0.40], maskLayer: shape)
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    lazy var grooveGradient: CAGradientLayer = {
        let shape = CAShapeLayer()
        let width = self.bounds.width * 83 / 100
        let padding = self.bounds.width * 8.50 / 100
        let path = UIBezierPath(ovalIn: CGRect(x: padding, y: padding, width: width, height: width))
        shape.path = path.cgPath
        let gradient = CAGradientLayer.returnGradient(colors: [UIColor.grooveGradientColorStart.cgColor,
                                                               UIColor.grooveGradientColorEnd.cgColor],
                                                      locations: [0.60, 1.0], maskLayer: shape)
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    lazy var knobBaseShape: CAGradientLayer = {
        let shape = CAShapeLayer()
        let padding = self.bounds.width * 11.50 / 100
        let path = UIBezierPath(ovalIn: CGRect(x: padding, y: padding, width: self.bounds.width - (padding * 2), height: self.bounds.height - (padding * 2)))
        shape.path = path.cgPath
        let gradient = CAGradientLayer.returnGradient(colors: [UIColor.knobBaseShapeColorStart.cgColor,
                                                               UIColor.knobBaseShapeColorEnd.cgColor],
                                                      locations: [0.30, 0.90], maskLayer: shape)
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.type = .radial
        return gradient
    }()
    lazy var knobOuterReflection: CAGradientLayer = {
        let shape = CAShapeLayer()
        let padding = self.bounds.width * 11.0 / 100
        let path = UIBezierPath(ovalIn: CGRect(x: padding, y: padding, width: self.bounds.width - (padding * 2), height: self.bounds.height - (padding * 2)))
        shape.path = path.cgPath
        shape.shadowOffset = CGSize(width: -1, height: -1)
        
        let gradient = CAGradientLayer.returnGradient(colors: [UIColor.knobOuterReflectionColorStart.cgColor,
                                                               UIColor.knobOuterReflectionColorEnd.cgColor],
                                                      locations: [0.25, 0.50], maskLayer: shape)
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
    lazy var rotationBaseShape: CAGradientLayer = {
            let shape = CAShapeLayer()
            let padding = self.bounds.width * 11.50 / 100
            let path = UIBezierPath(ovalIn: CGRect(x: padding, y: padding, width: self.bounds.width - (padding * 2), height: self.bounds.height - (padding * 2)))
            shape.path = path.cgPath
            let gradient = CAGradientLayer.returnGradient(colors: [UIColor.clear.cgColor,
                                                                   UIColor.clear.cgColor],
                                                          locations: [0.30, 0.90], maskLayer: shape)
            gradient.frame = self.bounds
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.type = .radial
            return gradient
        }()
    lazy var whiteIndicationLight: CAShapeLayer = {
        let shape = CAShapeLayer()
        let width = self.bounds.width * 2.5 / 100
        let topDistance: CGFloat = 17.3 * self.bounds.width / 100
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
        let padding = self.bounds.width * 25.80 / 100
        let path = UIBezierPath(ovalIn: CGRect(x: padding, y: padding, width: self.bounds.width - (padding * 2), height: self.bounds.height - (padding * 2)))
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
        let padding = self.bounds.width * 26.01 / 100
        let path = UIBezierPath(ovalIn: CGRect(x: padding, y: padding, width: self.bounds.width - (padding * 2), height: self.bounds.height - (padding * 2)))
        shape.path = path.cgPath
        let gradient = CAGradientLayer.returnGradient(colors: [UIColor.screenShapeColorStart.cgColor,
                                                               UIColor.screenShapeColorEnd.cgColor],
                                                      locations: [0.40, 1.0], maskLayer: shape)
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    lazy var referencePoint: CGPoint = {
            let point = CGPoint(x: self.center.x, y: 0)
            return point
        }()
//    lazy var panGesture: UIPanGestureRecognizer = {
//        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panDetected(sender:)))
//        return gesture
//    }()
    lazy var leftTopPadding: CGFloat = {
        let padding = self.bounds.width * 11.50 / 100
        return padding
    }()
    lazy var rightBottomPadding: CGFloat = {
        let padding = self.bounds.width - (leftTopPadding)
        return padding
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
        self.addGestureRecognizer(tapGesture)
//        self.addGestureRecognizer(panGesture)
    }
    @objc func screenTapped(sender: UITapGestureRecognizer) {
        let location = sender.location(in: self)
        if location.x > leftTopPadding && location.y > leftTopPadding && location.x < rightBottomPadding && location.y < rightBottomPadding {
//                        rotateShapeLayer(whiteIndicationLight, around: CGPoint(x: 10, y: 10), byAngle: .pi / 4)
            delegate?.tappedOnScreen()
//            rotateShapeLayer(whiteIndicationLight, around: CGPoint(x: 10, y: 10), byAngle: .pi / 4)
            let location = sender.location(in: self)
            let pointA = location
            let pointB = CGPoint(x: self.bounds.width / 2, y: self.bounds.width / 2)
            let pointC = CGPoint(x: self.bounds.width / 2, y: 0)
            let angle = angleBetweenPoints(pointA: pointA, pointB: pointB, pointC: pointC)
            print("Location: \(location), pointB: \(pointB), pointC: \(pointC)")
            print("Angle: \(angle) degrees")
            if angle.truncatingRemainder(dividingBy: 30) == 0 {
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
                print("IMPACT")
            }
            let animation = CABasicAnimation(keyPath: "transform")
            animation.duration = 0.1
            animation.fromValue = 0.0
            animation.toValue = angle
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            animation.isCumulative = true
            animation.repeatCount = .infinity
            rotationBaseShape.transform = CATransform3DRotate(CATransform3DIdentity, (angle), 0, 0, 1)
            //        rotationBaseShape.add(animation, forKey: UUID().description)
        }
            }
            func angleBetweenPoints(pointA: CGPoint, pointB: CGPoint, pointC: CGPoint) -> CGFloat {
                let vectorAB = CGPoint(x: pointA.x - pointB.x, y: pointA.y - pointB.y)
                let vectorBC = CGPoint(x: pointC.x - pointB.x, y: pointC.y - pointB.y)
                let dotProduct = vectorAB.x * vectorBC.x + vectorAB.y * vectorBC.y
                let magnitudeAB = sqrt(vectorAB.x * vectorAB.x + vectorAB.y * vectorAB.y)
                let magnitudeBC = sqrt(vectorBC.x * vectorBC.x + vectorBC.y * vectorBC.y)
                let cosAngle = dotProduct / (magnitudeAB * magnitudeBC)
                let angle = acos(cosAngle) * 180 / .pi
                return angle
            }
//    @objc func panDetected(sender: UIPanGestureRecognizer) {
//        let location = sender.location(in: self)
//        if location.x > leftTopPadding && location.y > leftTopPadding && location.x < rightBottomPadding && location.y < rightBottomPadding {
//            rotateShapeLayer(whiteIndicationLight, around: CGPoint(x: 10, y: 10), byAngle: .pi / 4)
//        }
//    }
//    func rotateShapeLayer(_ shapeLayer: CAShapeLayer, around pivot: CGPoint, byAngle angle: CGFloat) {
//        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
//        animation.fromValue = CGFloat.pi * 2
//        animation.toValue = 0
//        animation.duration = 8
//        animation.isCumulative = true
//        animation.repeatCount = Float.greatestFiniteMagnitude
//        whiteIndicationLight.add(animation, forKey: "rotationAnimation")
//    }
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
        self.layer.addSublayer(rotationBaseShape)
        rotationBaseShape.addSublayer(whiteIndicationLight)
        self.layer.addSublayer(screenShadow)
        self.layer.addSublayer(screenShape)
        
    }
}
