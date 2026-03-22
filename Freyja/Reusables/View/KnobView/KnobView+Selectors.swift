//
//  KnobView+Selectors.swift
//  Freyja
//
//  Created by Swathy Sudarsanan on 19/01/25.
//
import UIKit
extension KnobView {
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
