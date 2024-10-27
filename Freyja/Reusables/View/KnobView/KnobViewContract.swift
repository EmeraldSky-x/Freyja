//
//  KnobViewContract.swift
//  Freyja
//
//  Created by Swathy Sudarsanan on 27/10/24.
//

import Foundation
import UIKit

protocol KnobViewViewToViewModelProtocol: AnyObject {
    func tappedOnScreen()
    func rotatedToAngle(_ location: CGPoint)
}
protocol KnobViewModelToViewProtocol: AnyObject {
    var dummyView: UIView { get }
    var parentView: UIView { get }
    func setTransform(transform: CGAffineTransform)
}
