//
//  KnobViewDelegate.swift
//  Freyja
//
//  Created by Vijay Lal on 24/10/24.
//

import Foundation

protocol KnobViewDelegate: AnyObject {
    func tappedOnScreen()
    func rotatedToAngle(_ angle: Double)
}
