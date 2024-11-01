//
//  KnobViewContract.swift
//  Freyja
//
//  Created by Swathy Sudarsanan on 27/10/24.
//

import Foundation
import UIKit

protocol KnobViewToViewModelProtocol: AnyObject {
    func tappedOnScreen()
    func rotationStartedAtLocation(_ location: CGPoint)
    func rotatedToAngle(_ location: CGPoint)
    func rotationEndedAtAngle(_ location: CGPoint)
}
protocol KnobViewModelToViewProtocol: AnyObject {
    var dummyView: UIView { get }
    var parentView: UIView { get }
    func setTransform(transform: CGAffineTransform)
    func setAnimation()
}
