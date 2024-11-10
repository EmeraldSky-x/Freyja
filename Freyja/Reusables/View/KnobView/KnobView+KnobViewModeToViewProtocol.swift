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
//MARK: - Change the display text
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
//MARK: - Setting the transform for the white light in the knob
    func setTransform(transform: CGAffineTransform) {
        rotationBaseShape.transform = transform
    }
//MARK: - Set animation to the rotating shape
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
//MARK: - Set the transform back to the starting position
    func setReverseAnimation(angleInRadian: CGFloat) {
        self.isUserInteractionEnabled = false
        CATransaction.begin()
        CATransaction.setCompletionBlock({ [weak self] in
            guard let unwrappedSelf = self else { return }
            unwrappedSelf.isUserInteractionEnabled = true
        })
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = angleInRadian
        rotationAnimation.toValue = 0
        rotationAnimation.duration = 0.2
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        rotationBaseShape.layer.add(rotationAnimation, forKey: "rotationAnimation")
        rotationBaseShape.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)
        CATransaction.commit()
    }
//MARK: - Cancel all currently running animation. Useful to cancel long running animations, like Slingshot
    func cancelAllAnimations() {
        rotationBaseShape.layer.removeAllAnimations()
        rotationBaseShape.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)
    }
}
