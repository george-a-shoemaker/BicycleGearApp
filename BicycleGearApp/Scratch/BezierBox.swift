//
//  BezierBox.swift
//  BicycleGearApp
//
//  Created by George Shoemaker on 12/30/23.
//

import Foundation
import CoreGraphics
import UIKit

struct BezierQ {
    let ptA : CGPoint
    let ptB : CGPoint
    let ptControl : CGPoint
}

struct BezierBox {
    static var unitBox : BezierBox {
        get {
            BezierBox(
                pts : [
                    CGPoint(x: -0.5, y: -0.5),
                    CGPoint(x:  0.5, y: -0.5),
                    CGPoint(x:  0.5, y:  0.5),
                    CGPoint(x: -0.5, y:  0.5),
                    
                ],
                qControlPts : [
                    CGPoint(x: 0, y: 0),
                    CGPoint(x: 0, y: 0),
                    CGPoint(x: 0, y: 0),
                    CGPoint(x: 0, y: 0),
                ]
            )
        }
    }
    
    let pts : [CGPoint]
    let qControlPts : [CGPoint]
    
    lazy var bezierQs : [BezierQ] = {
        var result = [BezierQ]()
        for i in 0..<3 {
            result.append( BezierQ(
                ptA: pts[i],
                ptB: pts[i+1],
                ptControl: qControlPts[i]
            ))
        }
        result.append( BezierQ(
            ptA: pts[3],
            ptB: pts[0],
            ptControl: qControlPts[3]
        ))
        return result
    }()
    
    func applyTransformation(t: CGAffineTransform) -> BezierBox {
        return BezierBox(
            pts: self.pts.map { $0.applying(t) },
            qControlPts: self.qControlPts.map { $0.applying(t) }
        )
    }
    
    func toPath() -> UIBezierPath {
        let bp = UIBezierPath()
        bp.move(to: pts[0])
        bp.addQuadCurve(to: pts[1], controlPoint: qControlPts[0])
        bp.addQuadCurve(to: pts[2], controlPoint: qControlPts[1])
        bp.addQuadCurve(to: pts[3], controlPoint: qControlPts[2])
        bp.addQuadCurve(to: pts[0], controlPoint: qControlPts[3])
        bp.close()
        return bp
    }
}
