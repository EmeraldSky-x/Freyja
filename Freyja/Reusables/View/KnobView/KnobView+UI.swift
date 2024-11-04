//
//  KnobView+UI.swift
//  Freyja
//
//  Created by Vijay Lal on 04/11/24.
//

import Foundation

//MARK: - Initiate Views
extension KnobView {
    func initViews() {
        self.backgroundColor = .clear
        self.layer.addSublayer(outerRimLightShadow)
        self.layer.addSublayer(outerRimDarkShadow)
        self.layer.addSublayer(outerRimShape)
        self.layer.addSublayer(outerRimInnerReflection)
        self.layer.addSublayer(grooveShape)
        self.layer.addSublayer(grooveGradient)
        self.layer.addSublayer(grooveLightAura)
        self.layer.addSublayer(grooveLight)
        self.layer.addSublayer(knobOuterReflection)
        self.layer.addSublayer(knobBaseShape)
        self.addSubview(rotationBaseShape)
        rotationBaseShape.translatesAutoresizingMaskIntoConstraints = false
        let padding = self.bounds.width * 11.50 / 100
        [rotationBaseShape.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
         rotationBaseShape.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
         rotationBaseShape.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -1 * (padding * 2)),
         rotationBaseShape.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -1 * (padding * 2))
        ].forEach({ $0.isActive = true })
        rotationBaseShape.layer.addSublayer(whiteIndicationLight)
        self.layer.addSublayer(screenShadow)
        self.layer.addSublayer(screenShape)
        self.addSubview(dummyView)
        dummyView.translatesAutoresizingMaskIntoConstraints = false
        [dummyView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         dummyView.topAnchor.constraint(equalTo: self.topAnchor),
         dummyView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         dummyView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ].forEach({ $0.isActive = true })
        self.addSubview(screenView)
        let screenPadding = self.bounds.width * 26.01 / 100
        screenView.translatesAutoresizingMaskIntoConstraints = false
        [screenView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
         screenView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
         screenView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -1 * (screenPadding * 2 )),
         screenView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -1 * (screenPadding * 2))
        ].forEach({ $0.isActive = true })
        self.addSubview(screenText)
        screenText.translatesAutoresizingMaskIntoConstraints = false
        [screenText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
         screenText.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ].forEach({ $0.isActive = true })
    }
}
