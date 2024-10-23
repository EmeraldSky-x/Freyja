import UIKit

class ShadowView: UIView {
    
    lazy var shapeLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.path = UIBezierPath(ovalIn: self.bounds).cgPath
        shape.fillColor = UIColor.black.cgColor
        shape.shadowPath = shape.path
        shape.shadowColor = UIColor(red: 0.08, green: 0.08, blue: 0.10, alpha: 1.00).cgColor
        shape.shadowOpacity = 1.0
        shape.shadowRadius = 20
        shape.shadowOffset = CGSize(width: 20, height: 20)
        return shape
    }()
    lazy var secondShapeLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.path = UIBezierPath(ovalIn: self.bounds).cgPath
        shape.fillColor = UIColor.black.cgColor
        shape.shadowPath = shape.path
        shape.shadowColor = UIColor(red: 0.22, green: 0.23, blue: 0.26, alpha: 1.00).cgColor
        shape.shadowOpacity = 1.0
        shape.shadowRadius = 40
        shape.shadowOffset = CGSize(width: -20, height: -20)
        return shape
    }()
    lazy var thirdShapeLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.path = UIBezierPath(ovalIn: self.bounds).cgPath
        shape.fillColor = UIColor(red: 0.22, green: 0.23, blue: 0.26, alpha: 1.00).cgColor
        return shape
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.addSublayer(secondShapeLayer)
        self.layer.addSublayer(shapeLayer)
        self.layer.addSublayer(thirdShapeLayer)
    }
}

