//
//  KnobView+KnobViewModeToViewProtocol.swift
//  Freyja
//
//  Created by Vijay Lal on 04/11/24.
//

import Foundation
import UIKit

//MARK: - KnobViewModelToViewProtocol confirmation
extension KnobView: KnobViewModelToViewProtocol {
    func setScreenText(string: String) {
        self.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let unwrappedSelf = self else { return }
            unwrappedSelf.screenText.alpha = 0
        }) { [weak self] _ in
            guard let unwrappedSelf = self else { return }
            unwrappedSelf.screenText.text = string
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let unwrappedSelf = self else { return }
                unwrappedSelf.screenText.alpha = 1
                unwrappedSelf.isUserInteractionEnabled = true
            }
        }
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 0
        opacity.toValue = 1
        opacity.duration = 0.3
        opacity.autoreverses = true
        grooveLight.add(opacity, forKey: nil)
    }
    func setTransform(transform: CGAffineTransform) {
        rotationBaseShape.transform = transform
    }
    func setAnimation(angleInRadian: CGFloat) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = angleInRadian
        rotationAnimation.toValue = CGFloat.pi * (2.0 * 10)
        rotationAnimation.duration = 10.0
        rotationAnimation.isCumulative = true
        rotationAnimation.isRemovedOnCompletion = true
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        rotationBaseShape.layer.add(rotationAnimation, forKey: "rotationAnimation")
        rotationBaseShape.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)
    }
    func setReverceAnimation(angleInRadian: CGFloat) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = angleInRadian
        rotationAnimation.toValue = CGFloat.pi
        rotationAnimation.duration = 1.0
        rotationAnimation.isCumulative = true
        rotationAnimation.isRemovedOnCompletion = true
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        rotationBaseShape.layer.add(rotationAnimation, forKey: "rotationAnimation")
        rotationBaseShape.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)
    }
    func endPanGestureCapture() {}
    func cancelAllAnimations() {
        rotationBaseShape.layer.removeAllAnimations()
        rotationBaseShape.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)
    }
}
