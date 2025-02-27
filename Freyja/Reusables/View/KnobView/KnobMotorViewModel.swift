//
//  KnobMotorViewModel.swift
//  Freyja
//
//  Created by Swathy Sudarsanan on 27/10/24.
//
import UIKit
import Combine
class KnobMotorViewModel {
    private weak var view: KnobViewModelToViewProtocol?
    private var currentAngleStep: Int = 0
    private var rotationStartedAngle: CGFloat = 0
    private var rotationEndedAtAngle: CGFloat = 0
    private var mode: KnobMode = .knob
    private var timer: Timer?
    var conversationManager: ConversationManagerProtocol?
    init(view: KnobViewModelToViewProtocol, conversationManager: ConversationManagerProtocol?) {
        self.view = view
        self.conversationManager = conversationManager
        self.conversationManager?.appOpened()
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
        case .timeMachine:
            break
        }
    }
}
extension KnobMotorViewModel: KnobViewToViewModelProtocol {
//MARK: - Detetced a tap on Screen
    func tappedOnScreen() {
        invalidateClock()
        switchModeToNext()
        view?.setScreenText(string: mode.rawValue)
        conversationManager?.appActive()
        let messageAttributedString = NSMutableAttributedString(string: mode.rawValue, attributes: [.font: UIFont(name: "EspionRounded-Regular", size: 14)!])
        conversationManager?.currentMessagePublisher.send(messageAttributedString)
        view?.setScreenText(string: mode.rawValue)
        guard let view = view?.rotationBaseShape else { return }
        let radians = atan2(view.transform.b, view.transform.a)
        self.view?.setReverseAnimation(angleInRadian: radians)
        self.rotationEndedAtAngle = 0
        if mode == .timeMachine {
            startClock()
            startTimeMachineAnimation()
            conversationManager?.pauseConversation()
        }
    }
    private func invalidateClock() {
        timer?.invalidate()
        timer = nil
    }
    private func startClock() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    private func startTimeMachineAnimation() {
        view?.startClockAnimation()
    }
    @objc private func updateTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        formatter.timeZone = .current
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: Date())
        let messageAttributedString = NSMutableAttributedString()
        messageAttributedString.append(NSMutableAttributedString(string: timeString, attributes: [.font: UIFont(name: "EspionRounded-Regular", size: 18)!]))
        formatter.dateFormat = " a"
        let amPMValue = formatter.string(from: Date())
        messageAttributedString.append(NSMutableAttributedString(string: amPMValue, attributes: [.font: UIFont(name: "EspionRounded-Regular", size: 18)!]))
        formatter.dateFormat = " ss"
        let secondsString = formatter.string(from: Date())
        messageAttributedString.append(NSMutableAttributedString(string: secondsString, attributes: [.font: UIFont.systemFont(ofSize: 8, weight: .light)]))
        self.conversationManager?.currentMessagePublisher.send(messageAttributedString)
        
    }
    private func switchModeToNext() {
        let allCases = KnobMode.allCases
        if let index = allCases.firstIndex(of: mode) {
            mode = allCases[(index + 1) % allCases.count]
        }
    }
//MARK: - This method will be called when the user pans to a new location
    func rotatedToAngle(_ location: CGPoint) {
        guard let angle = getAngle(from: location) else { return }
        conversationManager?.appActive()
        switch mode {
        case .knob:
            
            let messageAttributedString = NSMutableAttributedString(string: mode.rawValue, attributes: [.font: UIFont(name: "EspionRounded-Regular", size: 14)!])
            self.conversationManager?.currentMessagePublisher.send(messageAttributedString)
            let newAngle = angle - rotationStartedAngle + rotationEndedAtAngle
            addImpactFeedback(angle: newAngle)
            let rotate = CGAffineTransform(rotationAngle: newAngle / 180 * .pi)
            view?.setTransform(transform: rotate)
            break
        case .slingShot:
            let messageAttributedString = NSMutableAttributedString(string: mode.rawValue, attributes: [.font: UIFont(name: "EspionRounded-Regular", size: 14)!])
            self.conversationManager?.currentMessagePublisher.send(messageAttributedString)
            let newAngle = angle - rotationStartedAngle
            let rotate = CGAffineTransform(rotationAngle: newAngle / 180 * .pi)
            view?.setTransform(transform: rotate)
            break
        case .timeMachine:
            conversationManager?.pauseConversation()
            break
        }
    }
//MARK: - This method is triggered when a pan gesture starts. Use this to track where the rotation started from
    func rotationStartedAtLocation(_ location: CGPoint) {
        guard let angle = getAngle(from: location) else { return }
        rotationStartedAngle = angle
        switch mode {
        case .knob: 
            break
        case .slingShot:
            view?.cancelAllAnimations()
            break
        case .timeMachine:
            conversationManager?.pauseConversation()
            break
        }
    }
//MARK: - This method is triggered when the pan gesture ends. Use this method to start long running animation slike Slingshot.
    func rotationEndedAtAngle(_ location: CGPoint) {
        guard let angle = getAngle(from: location) else { return }
        rotationEndedAtAngle = angle - rotationStartedAngle + rotationEndedAtAngle
        switch mode {
        case .slingShot:
            let radians = rotationEndedAtAngle * .pi / 180
            view?.setAnimation(angleInRadian: radians)
            addImpactFeedback(angle: 0)
            break
        case .timeMachine:
            conversationManager?.pauseConversation()
            break
        default:
            break
        }
    }
}
