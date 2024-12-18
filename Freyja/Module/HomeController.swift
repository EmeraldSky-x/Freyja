//
//  ViewController.swift
//  KnobRotatingApp
//
//  Created by Vijay Lal on 19/10/24.
//
import UIKit

class HomeController: UIViewController {
    lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 0.17, green: 0.18, blue: 0.21, alpha: 1.00).cgColor,
            UIColor(red: 0.12, green: 0.12, blue: 0.14, alpha: 1.00).cgColor
        ]
        gradient.locations = [0.0, 1.0]
        gradient.frame = view.bounds
        return gradient
    }()
    var conversationManager: ConversationManager?
    lazy var knobView : KnobView = {
        let view = KnobView()
        let viewModel = KnobMotorViewModel(view: view, conversationManager: conversationManager)
        view.motor = viewModel
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
}
extension HomeController {
    func initViews() {
        self.view.layer.insertSublayer(gradientLayer, at:0)
        self.view.addSubview(knobView)
        knobView.translatesAutoresizingMaskIntoConstraints = false
        [knobView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
         knobView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
         knobView.heightAnchor.constraint(equalToConstant: 346),
         knobView.widthAnchor.constraint(equalToConstant: 346)
        ].forEach({ $0.isActive = true })
    }
}
