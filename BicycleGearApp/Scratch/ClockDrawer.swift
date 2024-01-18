//
//  ClockDrawer.swift
//  BicycleGearApp
//
//  Created by George Shoemaker on 12/30/23.
//

import Foundation
import CoreGraphics
import UIKit

struct ClockDrawer {
    
    let anchorPt : CGPoint
    let size : CGSize
    let borderLayer : CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        layer.fillColor = .none
        layer.lineWidth = 2
        return layer
    }()
    
    let bigNotchLayer : CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        layer.fillColor = .none
        layer.lineWidth = 8
        return layer
    }()
    
    let pivotLayer : CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = .none
        layer.fillColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        return layer
    }()
    
    let secondLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = CGColor.init(red: 1, green: 0, blue: 0, alpha: 1)
        layer.fillColor = layer.strokeColor
        layer.lineWidth = 2
        return layer
    }()
    
    let minuteLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = CGColor.init(red: 0, green: 0, blue: 1, alpha: 1)
        layer.fillColor = layer.strokeColor
        layer.lineWidth = 4
        return layer
    }()
    
    let hourLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = CGColor.init(red: 0.2, green: 1, blue: 0.2, alpha: 1)
        layer.fillColor = layer.strokeColor
        layer.lineWidth = 6
        return layer
    }()
    
    let dotLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = CGColor.init(red: 0.5, green: 0.5, blue: 0, alpha: 1)
        layer.fillColor = layer.strokeColor
        layer.lineWidth = 0
        return layer
    }()
    
    func apply(h: Int, m: Int, s: Int) {
        print("sec \(s)")
        
        let sTheta = 2 * CGFloat.pi * CGFloat(s) / 60.0
        let mTheta = 2 * CGFloat.pi * CGFloat(m) / 60.0 + sTheta / 60
        let hTheta = 2 * CGFloat.pi * CGFloat(h) / 12 + mTheta / 12
        
        updateSecondsPath(theta: sTheta - CGFloat.pi/2)
        updateMinutesPath(theta: mTheta - CGFloat.pi/2)
        updateHourPath(theta: hTheta - CGFloat.pi/2)
        
        updateDot(second: s)
    }
    
    init(anchorPt: CGPoint, size: CGSize) {
        self.anchorPt = anchorPt
        self.size = size
        
        borderLayer.setAffineTransform(
            .init(translationX: anchorPt.x + size.width/2, y: anchorPt.y + size.height/2)
        )
        
        borderLayer.path = {
            let bp = UIBezierPath()
            bp.addArc(withCenter: .zero, radius: size.width/2, startAngle: 0, endAngle: .pi*2, clockwise: true)
            
            let notchAnchorA = CGPoint(x: 0, y: size.height/2 * 0.96)
            let notchAnchorB = CGPoint(x: 0, y: size.height/2 * 0.93)
            
            let thetaIncrement = 2 * CGFloat.pi / 60
            for i in 0..<60 {
                let theta = thetaIncrement * CGFloat(i)
                let tRotate = CGAffineTransform(rotationAngle: theta)
                let a = notchAnchorA.applying(tRotate)
                let b = notchAnchorB.applying(tRotate)
                
                bp.move(to: .init(x: a.x, y: a.y))
                bp.addLine(to: .init(x: b.x, y: b.y))
            }
            
            return bp.cgPath
        }()
         
        bigNotchLayer.setAffineTransform(
            .init(translationX: anchorPt.x + size.width/2, y: anchorPt.y + size.height/2)
        )
        
        bigNotchLayer.path = {
            let bp = UIBezierPath()
            let notchAnchorA = CGPoint(x: 0, y: size.height/2 * 0.96)
            let notchAnchorB = CGPoint(x: 0, y: size.height/2 * 0.9)
            
            let thetaIncrement = 2 * CGFloat.pi / 12
            for i in 0..<12 {
                let theta = thetaIncrement * CGFloat(i)
                let tRotate = CGAffineTransform(rotationAngle: theta)
                let a = notchAnchorA.applying(tRotate)
                let b = notchAnchorB.applying(tRotate)
                
                bp.move(to: .init(x: a.x, y: a.y))
                bp.addLine(to: .init(x: b.x, y: b.y))
            }
            
            return bp.cgPath
        }()

        pivotLayer.path = {
            let bp = UIBezierPath()
            bp.addArc(withCenter: .zero, radius: 3, startAngle: 0, endAngle: .pi*2, clockwise: true)
            return bp.cgPath
        }()
        
        dotLayer.path = {
            let bp = UIBezierPath()
            bp.addArc(withCenter: .zero, radius: 5, startAngle: 0, endAngle: .pi*2, clockwise: true)
            return bp.cgPath
        }()
        
        dotLayer.position = .init(x: 0, y: 500)
    }
    
    let secondsPath : UIBezierPath = {
        let bp = UIBezierPath()
        bp.move(to: .init(x: -0.3, y: 0))
        bp.addLine(to: .init(x: 1, y: 0))
        bp.move(to: .init(x: -0.3, y: 0))
        bp.addArc(
            withCenter: .init(x: -0.3, y: 0),
            radius: 0.05,
            startAngle: 0, endAngle: 2*CGFloat.pi,
            clockwise: true
        )
        
        return bp
    }()
    
    func updateSecondsPath(theta: CGFloat) {
        let secondsLen = size.width * 0.48
        
//        var components = CGAffineTransformComponents()
//        components.rotation = theta
//        components.scale = .init(width: secondsLen, height: secondsLen)
//        components.translation = .init(
//            dx: anchorPt.x + size.width/2,
//            dy: anchorPt.y + size.height/2
//        )
//        secondsPath.apply(CGAffineTransform(components))
        
        // !!!!! This doesn't make sense because you translate every time
        
        let x1 = cos(theta - CGFloat.pi) * secondsLen * 0.3 + anchorPt.x + size.width/2
        let y1 = sin(theta - CGFloat.pi) * secondsLen * 0.3 + anchorPt.y + size.height/2
        
        let x2 = cos(theta) * secondsLen + anchorPt.x + size.width/2
        let y2 = sin(theta) * secondsLen + anchorPt.y + size.height/2
        
        let bp = UIBezierPath()
        bp.move(to: .init(x: x1, y: y1))
        bp.addLine(to: .init(x: x2, y: y2))
        bp.move(to: .init(x: x1, y: y1))
        bp.addArc(withCenter: .init(x: x1, y: y1), radius: 3, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        DispatchQueue.main.async {
            self.secondLayer.path = bp.cgPath
        }
    }
    
    func updateMinutesPath(theta: CGFloat) {
        let minutesLen = size.width * 0.43
        
        let x1 = cos(theta - CGFloat.pi) * minutesLen * 0.3 + anchorPt.x + size.width/2
        let y1 = sin(theta - CGFloat.pi) * minutesLen * 0.3 + anchorPt.y + size.height/2
        
        let x2 = cos(theta) * minutesLen + anchorPt.x + size.width/2
        let y2 = sin(theta) * minutesLen + anchorPt.y + size.height/2
        
        let bp = UIBezierPath()
        bp.move(to: .init(x: x1, y: y1))
        bp.addLine(to: .init(x: x2, y: y2))
        bp.move(to: .init(x: x1, y: y1))
        bp.addArc(withCenter: .init(x: x1, y: y1), radius: 3, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
    }
    
    func updateHourPath(theta: CGFloat) {
        let hourLen = size.width * 0.35
        
        let x1 = cos(theta - CGFloat.pi) * hourLen * 0.3 + anchorPt.x + size.width/2
        let y1 = sin(theta - CGFloat.pi) * hourLen * 0.3 + anchorPt.y + size.height/2
        
        let x2 = cos(theta) * hourLen + anchorPt.x + size.width/2
        let y2 = sin(theta) * hourLen + anchorPt.y + size.height/2
        
        let bp = UIBezierPath()
        bp.move(to: .init(x: x1, y: y1))
        bp.addLine(to: .init(x: x2, y: y2))
        bp.move(to: .init(x: x1, y: y1))
        bp.addArc(withCenter: .init(x: x1, y: y1), radius: 3, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        DispatchQueue.main.async {
            self.hourLayer.path = bp.cgPath
        }
    }
    
    func updateDot(second: Int) {
        let oldPosition = dotLayer.position
        let newPosition = CGPoint(x:CGFloat(second) * size.width/60, y: oldPosition.y)
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = NSValue(cgPoint: dotLayer.position)
        animation.toValue = NSValue(cgPoint: newPosition)
        animation.isRemovedOnCompletion = true
        animation.duration = 0.5
        
        DispatchQueue.main.async {
            self.dotLayer.position = newPosition
            self.dotLayer.add(animation, forKey: "positionAnim")
        }
    }
    
//    init(anchorPt: CGPoint, size: CGSize) {
//        self.anchorPt = anchorPt
//        self.size = size
//        self.borderLayer = {
//            let layer = CAShapeLayer()
//            layer.strokeColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
//            layer.fillColor = .none
//            layer.lineWidth = 2
//            layer.path = CGPath(
//                ellipseIn: .init(x: anchorPt.x, y: anchorPt.y, width: size.width, height: size.height), transform: nil
//            )
//            return layer
//        }()
//        
//        self.secondLayer = {
//            let layer = CAShapeLayer()
//            layer.strokeColor = CGColor.init(red: 1, green: 0, blue: 0, alpha: 1)
//            layer.fillColor = .none
//            layer.lineWidth = 2
//            
//            let bp = UIBezierPath()
//            bp.move(to: .init(x: anchorPt.x + size.width/2, y: anchorPt.y + size.height/2))
//            bp.addLine(to: .init(x: anchorPt.x + size.width/2, y: anchorPt.y + size.height/2*0.1))
//            layer.path = bp.cgPath
//            let bp2 = UIBezierPath()
//            bp2.move(to: .init(x: anchorPt.x + size.width/3, y: anchorPt.y + size.height/2))
//            bp2.addLine(to: .init(x: anchorPt.x + size.width/2, y: anchorPt.y + size.height/2*0.1))
//            layer.path = bp2.cgPath
//            
//            return layer
//        }()
//    }
}
