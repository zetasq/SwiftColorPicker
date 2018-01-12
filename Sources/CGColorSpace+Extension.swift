//
//  CGColorSpace+Extension.swift
//  SwiftColorPicker-iOS
//
//  Created by Zhu Shengqi on 12/1/2018.
//

import UIKit
import CoreGraphics

extension CGColorSpace {
    static var p3OrDeviceRGB: CGColorSpace {
        if #available(iOS 10.0, *) {
            if UIScreen.main.traitCollection.displayGamut == .P3 {
                return CGColorSpace(name: CGColorSpace.displayP3) ?? CGColorSpaceCreateDeviceRGB()
            }
            
            return CGColorSpaceCreateDeviceRGB()
        } else {
            return CGColorSpaceCreateDeviceRGB()
        }
    }
}
