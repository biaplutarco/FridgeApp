//
//  ProductCollectionView.swift
//  FridgeApp
//
//  Created by Bia on 02/09/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class ProductCollectionView: UICollectionView {
    let WigglingCollectionViewStartedMovingNotification = "WigglingCollectionView.StartedMoving"
    let WigglingCollectionViewFinishedMovingNotification = "WigglingCollectionView.FinishedMoving"
    
    convenience init<T: UICollectionViewCell>(registerCellOfType: T.Type) {
        self.init()
        registerCell(of: registerCellOfType)
    }
    
    private init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 24
        super.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        configCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configCollectionView() {
        backgroundColor = .clear
        alwaysBounceVertical = true
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    var isWiggling: Bool { return _isWiggling }
//    tirar isso
    private var _isWiggling = false
    
    override func beginInteractiveMovementForItem(at indexPath: IndexPath) -> Bool {
        startWiggle(at: indexPath)
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WigglingCollectionViewStartedMovingNotification), object: self)
        return false
//        return super.beginInteractiveMovementForItem(at: indexPath)
    }
    
    override func cancelInteractiveMovement() {
        super.endInteractiveMovement()
        stopWiggle()
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WigglingCollectionViewFinishedMovingNotification), object: self)
    }
    
    private func startWiggle(at indexPath: IndexPath) {
        guard let cell = cellForItem(at: indexPath) else {
            return
        }
        addWiggleAnimationToCell(cell: cell)
//        for cell in self.visibleCells {
//            addWiggleAnimationToCell(cell: cell as UICollectionViewCell)
//        }
        _isWiggling = true
    }
    
    private func stopWiggle() {
        
        for cell in self.visibleCells {
            cell.layer.removeAllAnimations()
        }
        _isWiggling = false
    }
    
    private func addWiggleAnimationToCell(cell: UICollectionViewCell) {
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        cell.layer.add(rotationAnimation(), forKey: "rotation")
        cell.layer.add(bounceAnimation(), forKey: "bounce")
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
