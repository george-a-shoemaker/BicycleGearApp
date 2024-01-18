//
//  ScratchVC.swift
//  BicycleGearApp
//
//  Created by George Shoemaker on 12/30/23.
//

import UIKit
import CoreGraphics
import CoreGraphics.CGAffineTransform
import CoreFoundation

class ScratchVC: UIViewController {
    
    var timer: Timer!
    var clockDrawer: ClockDrawer!
    
    var sHandLayer : CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        addBezierBoxLayers()
        
        print(view.bounds)
        
        clockDrawer = ClockDrawer(
            anchorPt: .init(x: view.bounds.midX - 150, y: 150),
            size: .init(width: 300, height: 300)
        )
        
        clockTick(date: Date())
        
        self.view.layer.addSublayer(clockDrawer.borderLayer)
        self.view.layer.addSublayer(clockDrawer.bigNotchLayer)
        self.view.layer.addSublayer(clockDrawer.hourLayer)
        self.view.layer.addSublayer(clockDrawer.minuteLayer)
        self.view.layer.addSublayer(clockDrawer.secondLayer)
        self.view.layer.addSublayer(clockDrawer.pivotLayer)
        self.view.layer.addSublayer(clockDrawer.dotLayer)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.clockTick(date: Date())
        }
    }
    
    func clockTick(date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        clockDrawer.apply(h: components.hour!, m: components.minute!, s: components.second!)
    }
    
    func addBezierBoxLayers() {
        let t = CGAffineTransform({
            var result = CGAffineTransformComponents()
            result.scale = CGSize(width: 50, height: 50)
            result.translation = CGVector(dx: 50, dy: 50)
            return result
        }())
        
        let bezierBox = BezierBox.unitBox.applyTransformation(t: t)
        
        let layer = CAShapeLayer()
        layer.strokeColor = CGColor.init(red: 1, green: 0, blue: 0, alpha: 1)
        layer.fillColor = CGColor(red: 1, green: 0.5, blue: 0.5, alpha: 1)
        layer.lineWidth = 2
        layer.path = bezierBox.toPath().cgPath
        
        self.view.layer.addSublayer(layer)
        
//        let bezierBox2 = BezierBox.unitBox.applyTransformation(t: CGAffineTransform(rotationAngle: 2*3.1415*0.1)
//        )
        
        let t2 = CGAffineTransform({
            var result = CGAffineTransformComponents()
            result.scale = CGSize(width: 50, height: 50)
            result.translation = CGVector(dx: 50, dy: 50)
            result.rotation = 2*Double.pi * 0.05
            return result
        }())
        
        let layer2 = CAShapeLayer()
        layer2.strokeColor = CGColor.init(red: 0, green: 0, blue: 1, alpha: 1)
        layer2.fillColor = CGColor(red: 0.5, green: 0.5, blue: 1, alpha: 1)
        layer2.lineWidth = 2
        layer2.path = BezierBox.unitBox.applyTransformation(t: t2).toPath().cgPath
        
        self.view.layer.addSublayer(layer2)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
