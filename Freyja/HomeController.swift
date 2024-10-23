//
//  ViewController.swift
//  KnobRotatingApp
//
//  Created by Vijay Lal on 19/10/24.
//
import UIKit

class HomeController: UIViewController {
//    lazy var shadowLayer: CAShapeLayer = {
//        let shape = CAShapeLayer()
//        shape.fillColor = UIColor.green.cgColor
//        let path = UIBezierPath(ovalIn: CGRect(x: (self.view.bounds.width / 2) - 100, y: (self.view.bounds.height / 2 ) - 100, width: 200, height: 200))
//        shape.path = path.cgPath
//        shape.shadowColor = UIColor.red.cgColor
//        shape.shadowRadius = 5
//        shape.shadowOffset = CGSize(width: 20, height: 20)
//        shape.shadowPath = path.cgPath
//        shape.opacity = 1.0
//        return shape
//    }()
    
//    lazy var backgroundLightShadowEllipse: CAShapeLayer = {
//            let shape = CAShapeLayer()
//        let path = UIBezierPath(ovalIn: CGRect(x: 3, y: 3, width: self.view.bounds.width - 6, height: self.view.bounds.height - 6)).cgPath
//            shape.path = path
//            shape.fillColor = UIColor(red: 0.17, green: 0.18, blue: 0.21, alpha: 1.00).cgColor
//            shape.shadowColor = UIColor.black.cgColor
//            shape.shadowOffset = CGSize(width: 0, height: 0)
//            shape.shadowRadius = 20
//            shape.shadowOpacity = 0.2
//            return shape
//        }()
    
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
    lazy var knobView : KnobView = {
        let view = KnobView()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
}
extension HomeController {
    func initViews() {
//        view.layer.addSublayer(backgroundLightShadowEllipse)
        
        
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
