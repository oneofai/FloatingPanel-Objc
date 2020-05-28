//
//  YBFloatingPanelChapterLayout.swift
//  YiBanProject
//
//  Created by Sun on 2020/5/27.
//  Copyright © 2020 Qing Class. All rights reserved.
//

import UIKit

public class YBFloatingPanelChapterLayout: NSObject, FloatingPanelLayout {

    
    public override init() { super.init() }

    public var initialPosition: FloatingPanelPosition {
        return .half
    }

    public func insetFor(position: FloatingPanelPosition) -> CGFloat {
        switch position {
        case .full: return YBFloatingPanelChapterLayout.heightForFull()
        case .half: return YBFloatingPanelLayoutConfig.deviceHeight * 0.5
        default: return 0
        }
    }
    
    private static func heightForFull() -> CGFloat {
        let statusBarHeight = (UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height)
        return statusBarHeight + YBFloatingPanelLayoutConfig.navigationBarHeight + 16
    }
    
    public var topInteractionBuffer: CGFloat { return 6.0 }
    public var bottomInteractionBuffer: CGFloat { return 6.0 }

    public var supportedPositions: Set<Int> {
        return Set([FloatingPanelPosition.full.rawValue, FloatingPanelPosition.half.rawValue])
    }

    public func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
        return [
            surfaceView.leftAnchor.constraint(equalTo: view.sideLayoutGuide.leftAnchor, constant: 0.0),
            surfaceView.rightAnchor.constraint(equalTo: view.sideLayoutGuide.rightAnchor, constant: 0.0),
        ]
    }

    public func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        // return position == .full ? 0.3 : 0.0
        return 0.6
    }

    public var positionReference: FloatingPanelLayoutReference {
        return .fromSuperview
    }
}


public class YBFloatingPanelKnowledgeLayout: NSObject, FloatingPanelLayout {

    
    public override init() { super.init() }

    public var initialPosition: FloatingPanelPosition {
        return .half
    }

    public func insetFor(position: FloatingPanelPosition) -> CGFloat {
        switch position {
        case .full: return YBFloatingPanelKnowledgeLayout.heightForFull()
        case .half: return YBFloatingPanelLayoutConfig.deviceHeight * 0.5
        default: return 0
        }
    }
    
    private static func heightForFull() -> CGFloat {
        let statusBarHeight = (UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height)
        return statusBarHeight + YBFloatingPanelLayoutConfig.navigationBarHeight + 16
    }
    
    public var topInteractionBuffer: CGFloat { return 6.0 }
    public var bottomInteractionBuffer: CGFloat { return 6.0 }

    public var supportedPositions: Set<Int> {
        return Set([FloatingPanelPosition.full.rawValue, FloatingPanelPosition.half.rawValue])
    }

    public func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
        return [
            surfaceView.leftAnchor.constraint(equalTo: view.sideLayoutGuide.leftAnchor, constant: 0.0),
            surfaceView.rightAnchor.constraint(equalTo: view.sideLayoutGuide.rightAnchor, constant: 0.0),
        ]
    }

    public func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        // return position == .full ? 0.3 : 0.0
        return 0.6
    }

    public var positionReference: FloatingPanelLayoutReference {
        return .fromSuperview
    }
}


public class YBFloatingPanelNoteListLayout: NSObject, FloatingPanelLayout {

    
    public override init() { super.init() }

    public var initialPosition: FloatingPanelPosition {
        return .full
    }

    public func insetFor(position: FloatingPanelPosition) -> CGFloat {
        switch position {
        case .full: return YBFloatingPanelNoteListLayout.heightForFull()
        default: return 0
        }
    }
    
    private static func heightForFull() -> CGFloat {
        let statusBarHeight = (UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height)
        return statusBarHeight + YBFloatingPanelLayoutConfig.navigationBarHeight + 16
    }
    
    public var topInteractionBuffer: CGFloat { return 6.0 }
    public var bottomInteractionBuffer: CGFloat { return 6.0 }

    public var supportedPositions: Set<Int> {
        return Set([FloatingPanelPosition.full.rawValue])
    }

    public func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
        return [
            surfaceView.leftAnchor.constraint(equalTo: view.sideLayoutGuide.leftAnchor, constant: 0.0),
            surfaceView.rightAnchor.constraint(equalTo: view.sideLayoutGuide.rightAnchor, constant: 0.0),
        ]
    }

    public func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        // return position == .full ? 0.3 : 0.0
        return 0.6
    }

    public var positionReference: FloatingPanelLayoutReference {
        return .fromSuperview
    }
}



class YBFloatingPanelLayoutConfig: NSObject {
    
    static var navigationBarHeight: CGFloat {
        let ipadNavBarHeight: CGFloat = CGFloat(Float(UIDevice.current.systemVersion)!) >= 12.0 ? 50.0 : 44.0
        let isLandscape = UIApplication.shared.statusBarOrientation.isLandscape
        let iphoneNaviBarHeight = isLandscape ? preferredValueForVisualDevice(regular: 44.0, compact: 32.0) : 44.0
        
        return isiPad ? ipadNavBarHeight : iphoneNaviBarHeight
    }
    
    static func preferredValueForVisualDevice(regular: CGFloat, compact: CGFloat) -> CGFloat {
        return isRegularScreen ? regular : compact
    }
    
    static var isRegularScreen: Bool {
        return isiPad || (!isZoomedMode && (is65InchScreen || is61InchScreen || is55InchScreen));
    }
    
    
    static var is65InchScreen: Bool {
        
        let is65Inch = (deviceWidth == 414.0 && deviceHeight == 896.0 && (deviceModel == "iPhone11,4" || deviceModel == "iPhone11,6" || deviceModel == "iPhone12,5"))
        
        return is65Inch;
    }
    
    static var is61InchScreen: Bool {
        let is61Inch = (deviceWidth == 414.0 && deviceHeight == 896.0 && (deviceModel == "iPhone11,8" || deviceModel == "iPhone12,1"))
        return is61Inch
    }
    
    static var is55InchScreen: Bool {
        let is55Inch = (deviceWidth == 414.0 && deviceHeight == 736.0)
        return is55Inch
    }
    

    static var deviceModel: String {
        if isSimulator {
            return String(cString: getenv("SIMULATOR_MODEL_IDENTIFIER"), encoding: .utf8)!
        }
        
        var systemInfo = utsname()
        uname(&systemInfo)
        var model = ""
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        _ = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            model = identifier + String(UnicodeScalar(UInt8(value)))
            return model
        }
        return model
    }
    
    static var isSimulator: Bool {
        let simu = UIDevice.current.model.range(of: "Simulator")
        return simu != nil;
    }
    
    static var deviceWidth: CGFloat {
        return min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    }
    
    static var deviceHeight: CGFloat {
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    }
    
    
    static var isiPad: Bool {
        return UI_USER_INTERFACE_IDIOM() == .pad
    }
    
    static var isZoomedMode: Bool {
        if (!isiPhone) {
            return false
        }
        
        let nativeScale = UIScreen.main.nativeScale
        var scale = UIScreen.main.scale
        
        let shouldBeDownsampledDevice = UIScreen.main.nativeBounds.size == CGSize(width: 1080.0, height: 1920.0)
        if (shouldBeDownsampledDevice) {
            scale = scale / 1.15
        }
        return nativeScale > scale
    }
    
    static var isiPhone: Bool {
        let isiPhone = UIDevice.current.model.range(of: "iPhone")
        guard let _ = isiPhone else { return false }
        return true
    }
}
