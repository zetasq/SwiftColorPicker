//
//  BrightnessPicker+Bar.swift
//  SwiftColorPicker-iOS
//
//  Created by Zhu Shengqi on 12/1/2018.
//

import UIKit

extension BrightnessPicker {
    
    final class Bar: UIView {
        
        public var color: HSBColor = UIColor.red.hsbColor {
            didSet {
                setNeedsDisplay()
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            layer.cornerRadius = 5
            clipsToBounds = true
        }
        
        // MARK: - UIView
        override func draw(_ rect: CGRect) {
            guard let context = UIGraphicsGetCurrentContext() else {
                return
            }
            
            let colorSpace = CGColorSpace.p3OrDeviceRGB
            
            let locations: [CGFloat] = [0.0, 1.0]
            
            let colors = [
                color.withBrightness(0).uiColor.cgColor,
                color.withBrightness(1).uiColor.cgColor
            ]
            
            if let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations) {
                context.drawLinearGradient(gradient, start: .zero, end: CGPoint(x: bounds.maxX, y: 0), options: [])
            }
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            setNeedsDisplay()
        }
        
        override var intrinsicContentSize: CGSize {
            return CGSize(width: UIViewNoIntrinsicMetric, height: 10)
        }
        
    }
    
}
