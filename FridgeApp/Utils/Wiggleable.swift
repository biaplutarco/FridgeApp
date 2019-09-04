//
//  Wiggleable.swift
//  FridgeApp
//
//  Created by Bia on 03/09/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

protocol Wiggleable {
    var isWiggling: Bool { get set }
}

extension Wiggleable where Self: UIView {
    func uptadeWiggling() {
        if isWiggling == true {
            startWiggle()
        } else {
            stopWiggle()
        }
    }
    
    private func stopWiggle() {
        layer.removeAllAnimations()
    }
    
    private func startWiggle() {
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        layer.add(rotationAnimation(), forKey: "rotation")
        layer.add(bounceAnimation(), forKey: "bounce")
        CATransaction.commit()
    }
    
    private func rotationAnimation() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        let angle = CGFloat(0.04)
        let duration = TimeInterval(0.1)
        let variance = Double(0.025)
        animation.values = [angle, -angle]
        animation.autoreverses = true
        animation.duration = self.randomizeInterval(interval: duration, withVariance: variance)
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func bounceAnimation() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        let bounce = CGFloat(3.0)
        let duration = TimeInterval(0.12)
        let variance = Double(0.025)
        animation.values = [bounce, -bounce]
        animation.autoreverses = true
        animation.duration = self.randomizeInterval(interval: duration, withVariance: variance)
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func randomizeInterval(interval: TimeInterval, withVariance variance: Double) -> TimeInterval {
        let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
        return interval + variance * random
    }
}
