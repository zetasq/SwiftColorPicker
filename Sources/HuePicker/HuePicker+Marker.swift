//
//  HuePicker+Marker.swift
//  SwiftColorPicker-iOS
//
//  Created by Zhu Shengqi on 12/1/2018.
//

import UIKit

extension HuePicker {
    
    final class Marker: UIView {
        
        static let sideLength: CGFloat = 30
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            layer.cornerRadius = Marker.sideLength / 2
            layer.borderWidth = 2
            layer.borderColor = UIColor.white.cgColor
            clipsToBounds = true
        }
        
        override var intrinsicContentSize: CGSize {
            return CGSize(width: Marker.sideLength, height: Marker.sideLength)
        }
    }
    
}
