//
//  YBFloatingPanelBehavior.swift
//  YiBanProject
//
//  Created by Sun on 2020/5/27.
//  Copyright © 2020 Qing Class. All rights reserved.
//

import UIKit

public class YBFloatingPanelDefaultBehavior: NSObject, FloatingPanelBehavior {
    
    public override init() { super.init() }

    public func interactionAnimator(_ fpc: FloatingPanelController, to targetPosition: FloatingPanelPosition, with velocity: CGVector) -> UIViewPropertyAnimator {
        let timing = timeingCurve(with: velocity)
        let animator = UIViewPropertyAnimator(duration: 0, timingParameters: timing)
        animator.isInterruptible = false // Prevent a propagation of the animation(spring etc) to a content view
        return animator
    }

    private func timeingCurve(with velocity: CGVector) -> UITimingCurveProvider {
        log.debug("velocity", velocity)
        let damping = self.getDamping(with: velocity)
        return UISpringTimingParameters(dampingRatio: damping,
                                        frequencyResponse: 0.3,
                                        initialVelocity: velocity)
    }

    private let velocityThreshold: CGFloat = 8.0
    private func getDamping(with velocity: CGVector) -> CGFloat {
        let dy = abs(velocity.dy)
        if dy > velocityThreshold {
            return 0.7
        } else {
            return 1.0
        }
    }
    
    public func shouldProjectMomentum(_ fpc: FloatingPanelController, for proposedTargetPosition: FloatingPanelPosition) -> Bool {
        return false
    }

    public func momentumProjectionRate(_ fpc: FloatingPanelController) -> CGFloat {
        #if swift(>=4.2)
        return UIScrollView.DecelerationRate.normal.rawValue
        #else
        return UIScrollViewDecelerationRateNormal
        #endif
    }

    public func redirectionalProgress(_ fpc: FloatingPanelController, from: FloatingPanelPosition, to: FloatingPanelPosition) -> CGFloat {
        return 0.5
    }

    public func addAnimator(_ fpc: FloatingPanelController, to: FloatingPanelPosition) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut)
    }

    public func removeAnimator(_ fpc: FloatingPanelController, from: FloatingPanelPosition) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut)
    }

    public func moveAnimator(_ fpc: FloatingPanelController, from: FloatingPanelPosition, to: FloatingPanelPosition) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut)
    }

    public var removalVelocity: CGFloat {
        return 10.0
    }

    public var removalProgress: CGFloat {
        return 0.4
    }

    public func removalInteractionAnimator(_ fpc: FloatingPanelController, with velocity: CGVector) -> UIViewPropertyAnimator {
        log.debug("velocity", velocity)
        let timing = UISpringTimingParameters(dampingRatio: 1.0,
                                        frequencyResponse: 0.3,
                                        initialVelocity: velocity)
        return UIViewPropertyAnimator(duration: 0, timingParameters: timing)
    }

    public func allowsRubberBanding(for edge: UIRectEdge) -> Bool {
        return false
    }
}
