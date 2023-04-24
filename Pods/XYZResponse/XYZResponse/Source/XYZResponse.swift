//
//  XYZResponse.swift
//  XYZResponse
//
//  Created by 张子豪 on 2019/1/11.
//  Copyright © 2019 张子豪. All rights reserved.
//

import UIKit

public class XYZResponse: NSObject {
    /// 创建枚举
    public enum FeedbackType: Int {case light,medium,heavy,success,warning,error,none}
    /// 创建类方法，随时调用
    public static func D点按马达震动反馈(style: FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        switch style {
            case .light:
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
            case .medium:
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
            case .heavy:
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            case .success: generator.notificationOccurred(.success)
            case .warning: generator.notificationOccurred(.warning)
            case .error  : generator.notificationOccurred(.error)
            default:break
        }
    }
}
