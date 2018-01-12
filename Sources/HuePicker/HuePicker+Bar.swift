//
//  HuePicker+Bar.swift
//  SwiftColorPicker-iOS
//
//  Created by Zhu Shengqi on 12/1/2018.
//

import UIKit

extension HuePicker {
    
    final class Bar: UIView {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            layer.cornerRadius = 7
            clipsToBounds = true
        }
        
        // MARK: - UIView
        override func draw(_ rect: CGRect) {
            guard let context = UIGraphicsGetCurrentContext() else {
                return
            }

//            context.clip()
            
            let colorSpace = CGColorSpace.p3OrDeviceRGB
            let step = CGFloat(0.166666666666667)
            let locations: [CGFloat] = [0.0, step, step * 2, step * 3, step * 4, step * 5, 1.0]
            let colors = [
                UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0).cgColor,
                UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor,
                UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor,
                UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor,
                UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0).cgColor,
                UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0).cgColor,
                UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
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
            return CGSize(width: UIViewNoIntrinsicMetric, height: 15)
        }
        
    }
    
}
