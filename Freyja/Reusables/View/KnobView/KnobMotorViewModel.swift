//
//  KnobMotorViewModel.swift
//  Freyja
//
//  Created by Swathy Sudarsanan on 27/10/24.
//
import UIKit
class KnobMotorViewModel {
    private weak var view: KnobViewModelToViewProtocol?
    private var currentAngleStep: Int = 0
    private var rotationStartedAngle: CGFloat = 0
    private var rotationEndedAtAngle: CGFloat = 0
    private var mode: KnobMode = .knob
    init(view: KnobViewModelToViewProtocol) {
        self.view = view
    }
    //MARK: - Calculate angle between three given points
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
    //MARK: - Helper function to create the points and calculate the angle
    private func getAngle(from location: CGPoint) -> CGFloat? {
        guard let parentView = view?.parentView, let dummyView = view?.dummyView else { return nil }
        let pointA = location
        let pointB = CGPoint(x: parentView.bounds.width / 2, y: parentView.bounds.width / 2)
        let pointC = CGPoint(x: parentView.bounds.width / 2, y: 0)
        var angle = angleBetweenPoints(pointA: pointA, pointB: pointB, pointC: pointC)
        if dummyView.frame.contains(location) {
            angle = 360 - angle
        }
        return angle
    }
    //MARK: - Calculate the transform to be applied on the view
    private func calculateTransform(angle: CGFloat) -> CGAffineTransform {
        let newAngle = angle - rotationStartedAngle + rotationEndedAtAngle
        return CGAffineTransform(rotationAngle: newAngle / 180 * .pi)
    }
    //MARK: - UIImpactFeedback generator
    private func addImpactFeedback(angle: CGFloat) {
        switch mode {
        case .knob:
            let angleStep = Int(angle / 30)
            if angleStep != currentAngleStep {
                currentAngleStep = angleStep
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            }
            break
        case .slingShot:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            break
        }
    }
}
extension KnobMotorViewModel: KnobViewToViewModelProtocol {
    func tappedOnScreen() {
        mode = mode == .knob ? .slingShot : .knob
        view?.setScreenText(string: mode.rawValue)
    }
    func rotatedToAngle(_ location: CGPoint) {
        guard let angle = getAngle(from: location) else { return }
        switch mode {
        case .knob:
            let newAngle = angle - rotationStartedAngle + rotationEndedAtAngle
            addImpactFeedback(angle: newAngle)
            let rotate = CGAffineTransform(rotationAngle: newAngle / 180 * .pi)
            view?.setTransform(transform: rotate)
            break
        case .slingShot:
            let newAngle = angle - rotationStartedAngle
            print(newAngle)
            let rotate = CGAffineTransform(rotationAngle: newAngle / 180 * .pi)
            view?.setTransform(transform: rotate)
            break
        }
    }
    func rotationStartedAtLocation(_ location: CGPoint) {
        guard let angle = getAngle(from: location) else { return }
        rotationStartedAngle = angle
        switch mode {
        case .knob:
//            view?.cancelAllAnimations()
            break
        case .slingShot:
            view?.cancelAllAnimations()
            break
        }
    }
    func rotationEndedAtAngle(_ location: CGPoint) {
        guard let angle = getAngle(from: location) else { return }
        rotationEndedAtAngle = angle - rotationStartedAngle + rotationEndedAtAngle
        switch mode {
        case .slingShot:
            let radians = rotationEndedAtAngle * .pi / 180
            view?.setAnimation(angleInRadian: radians)
            addImpactFeedback(angle: 0)
            break
        default:
            break
        }
    }
}
