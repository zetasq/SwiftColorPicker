//
//  HSBColor.swift
//  SwiftColorPicker-iOS
//
//  Created by Zhu Shengqi on 12/1/2018.
//

import UIKit

public struct HSBColor {
    
    var hue: CGFloat
    
    var saturation: CGFloat
    
    var brightness: CGFloat
    
    var alpha: CGFloat

    public var uiColor: UIColor {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    public func withHue(_ hue: CGFloat) -> HSBColor {
        var result = self
        result.hue = hue
        return result
    }
    
    public func withSaturation(_ saturation: CGFloat) -> HSBColor {
        var result = self
        result.saturation = saturation
        return result
    }
    
    public func withBrightness(_ brightness: CGFloat) -> HSBColor {
        var result = self
        result.brightness = brightness
        return result
    }
    
    public func withAlpha(_ alpha: CGFloat) -> HSBColor {
        var result = self
        result.alpha = alpha
        return result
    }
    
}

extension UIColor {
    
    public var hsbColor: HSBColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return HSBColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
}
