//
//  KnobMotorViewModel.swift
//  Freyja
//
//  Created by Swathy Sudarsanan on 27/10/24.
//
import UIKit
class KnobMotorViewModel: KnobViewViewToViewModelProtocol {
    private weak var view: KnobViewModelToViewProtocol?
    private var currentAngleStep: Int = 0
    private var rotationStartedAngle: CGFloat = 0
    private var rotationEndedAtAngle: CGFloat = 0
    init(view: KnobViewModelToViewProtocol) {
        self.view = view
    }
    private func angleBetweenPoints(pointA: CGPoint, pointB: CGPoint, pointC: CGPoint) -> CGFloat {
        let vectorAB = CGPoint(x: pointA.x - pointB.x, y: pointA.y - pointB.y)
        let vectorBC = CGPoint(x: pointC.x - pointB.x, y: pointC.y - pointB.y)
        let dotProduct = vectorAB.x * vectorBC.x + vectorAB.y * vectorBC.y
        let magnitudeAB = sqrt(vectorAB.x * vectorAB.x + vectorAB.y * vectorAB.y)
        let magnitudeBC = sqrt(vectorBC.x * vectorBC.x + vectorBC.y * vectorBC.y)
        let cosAngle = dotProduct / (magnitudeAB * magnitudeBC)
        let angle = acos(cosAngle) * 180 / .pi
        return angle
    }
}
extension KnobMotorViewModel {
    func tappedOnScreen() {
    }
    func rotatedToAngle(_ location: CGPoint) {
        guard let parentView = view?.parentView, let dummyView = view?.dummyView else { return }
        let pointA = location
        let pointB = CGPoint(x: parentView.bounds.width / 2, y: parentView.bounds.width / 2)
        let pointC = CGPoint(x: parentView.bounds.width / 2, y: 0)
        var angle = angleBetweenPoints(pointA: pointA, pointB: pointB, pointC: pointC)
        if dummyView.frame.contains(location) {
            angle = 360 - angle
        }
        let newAngle = angle - rotationStartedAngle + rotationEndedAtAngle
        let angleStep = Int(angle / 30)
        if angleStep != currentAngleStep {
            currentAngleStep = angleStep
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
        let rotate = CGAffineTransform(rotationAngle: newAngle / 180 * .pi)
        view?.setTransform(transform: rotate)
    }
    func rotationStartedAtLocation(_ location: CGPoint) {
        guard let parentView = view?.parentView, let dummyView = view?.dummyView else { return }
        let pointA = location
        let pointB = CGPoint(x: parentView.bounds.width / 2, y: parentView.bounds.width / 2)
        let pointC = CGPoint(x: parentView.bounds.width / 2, y: 0)
        var angle = angleBetweenPoints(pointA: pointA, pointB: pointB, pointC: pointC)
        if dummyView.frame.contains(location) {
            angle = 360 - angle
        }
        rotationStartedAngle = angle
    }
    func rotationEndedAtAngle(_ location: CGPoint) {
        guard let parentView = view?.parentView, let dummyView = view?.dummyView else { return }
        let pointA = location
        let pointB = CGPoint(x: parentView.bounds.width / 2, y: parentView.bounds.width / 2)
        let pointC = CGPoint(x: parentView.bounds.width / 2, y: 0)
        var angle = angleBetweenPoints(pointA: pointA, pointB: pointB, pointC: pointC)
        if dummyView.frame.contains(location) {
            angle = 360 - angle
        }
        rotationEndedAtAngle = angle - rotationStartedAngle + rotationEndedAtAngle
    }
}
