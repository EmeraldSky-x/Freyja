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

class KnobView: BaseKnob {
    lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
        return tap
    }()
    lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panDetected(sender:)))
        return gesture
    }()
    var setupViewsFlag = false
    //MARK: - Initiation
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        guard !setupViewsFlag, bounds.size != .zero else { return }
        initViews()
        for family in UIFont.familyNames {
            print(family)
            for name in UIFont.fontNames(forFamilyName: family) {
                print("  \(name)")
            }
        }
        
        self.addGestureRecognizer(panGesture)
        screenView.addGestureRecognizer(tapGesture)
        motor?.conversationManager?.currentMessagePublisher.sink { [weak self] message in
            self?.screenText.attributedText = message
        }.store(in: &cancellableSet)
        setupViewsFlag = true
    }
}
