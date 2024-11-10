//
//  KnobView.swift
//  Freyja
//
//  Created by Vijay Lal on 19/10/24.
//

import Foundation
import UIKit
import CoreGraphics
import Combine

class KnobView: UIView {
//MARK: - Decalrations: Logic drivers
    var parentView: UIView {
        get {
            self
        }
    }
    var motor: KnobViewToViewModelProtocol?
    var cancellableSet: Set<AnyCancellable> = .init()
//MARK: - Declarations subViews
    lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
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
    lazy var grooveLightAura: CAShapeLayer = {
        let shape = CAShapeLayer()
        let width = self.bounds.width * 83 / 100
        let padding = self.bounds.width * 8.50 / 100
        let path = UIBezierPath(ovalIn: CGRect(x: padding, y: padding, width: width, height: width))
        shape.path = path.cgPath
        shape.fillColor = UIColor.white.cgColor
        shape.shadowColor = UIColor(red: 0.27, green: 0.84, blue: 0.17, alpha: 1.00).cgColor
        shape.shadowRadius = 10
        shape.shadowOpacity = 1.0
        shape.shadowOffset = CGSize(width: 1, height: 1)
        shape.opacity = 0
        return shape
    }()
    lazy var grooveLight: CAGradientLayer = {
        let shape = CAShapeLayer()
        let width = self.bounds.width * 83 / 100
        let padding = self.bounds.width * 8.50 / 100
        let path = UIBezierPath(ovalIn: CGRect(x: padding, y: padding, width: width, height: width))
        shape.path = path.cgPath
        let gradient = CAGradientLayer.returnGradient(colors: [UIColor(red: 0.50, green: 1.00, blue: 0.83, alpha: 1.00).cgColor,
                                                               UIColor(red: 0.50, green: 1.00, blue: 0.83, alpha: 1.00).cgColor],
                                                      locations: [0.60, 1.0], maskLayer: shape)
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.opacity = 0
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
    lazy var rotationBaseShape: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    lazy var screenView: UIView = {
        let screen = UIView()
        screen.backgroundColor = .clear
        return screen
    }()
    lazy var whiteIndicationLight: CAShapeLayer = {
        let shape = CAShapeLayer()
        let width = self.bounds.width * 2.5 / 100
        let topDistance: CGFloat = 17.3 * self.bounds.width / 100
        let parentViewPadding = self.bounds.width * 11.50 / 100
        let parentViewSize = self.bounds.width - (2 * parentViewPadding)
        let topDistanceNew: CGFloat = 6.9 * parentViewSize / 100
        let path = UIBezierPath(ovalIn: CGRect(x: (parentViewSize / 2) - width / 2, y: topDistanceNew, width: width, height: width))
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
                                                               UIColor.screenShapeColorEnd.cgColor,
                                                               UIColor.white.cgColor],
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
    lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panDetected(sender:)))
        return gesture
    }()
    lazy var leftTopPadding: CGFloat = {
        let padding = self.bounds.width * 11.50 / 100
        return padding
    }()
    lazy var rightBottomPadding: CGFloat = {
        let padding = self.bounds.width - (leftTopPadding)
        return padding
    }()
    var dummyView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = .clear
        return view
    }()
    lazy var screenText: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(0.4)
        label.font = UIFont(name: "EspionRounded Regular", size: 10)
        label.numberOfLines = -1
        label.textAlignment = .center
        return label
    }()
    var shouldInitiateViews = true
//MARK: - Initiation
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if shouldInitiateViews {
            initViews()
            self.addGestureRecognizer(panGesture)
            screenView.addGestureRecognizer(tapGesture)
            motor?.conversationManager?.currentMessagePublisher.sink { [weak self] message in
                self?.screenText.text = message
            }.store(in: &cancellableSet)
        }
        shouldInitiateViews = false
    }
//MARK: - Selectors for Gestures
    @objc func screenTapped(sender: UITapGestureRecognizer) {
        motor?.tappedOnScreen()
        
    }
    @objc func panDetected(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            let location = sender.location(in: self)
            motor?.rotationStartedAtLocation(location)
        case .changed:
            let location = sender.location(in: self)
            if location.x > 0 && location.y > 0 && location.x < self.bounds.height && location.y < self.bounds.width {
                motor?.rotatedToAngle(location)
            } else {
                sender.state = .ended
            }
        case .ended:
            let location = sender.location(in: self)
            motor?.rotationEndedAtAngle(location)
        default:
            break
        }
    }
    @objc func enableUserInteraction() {
        self.isUserInteractionEnabled = true
    }
}


