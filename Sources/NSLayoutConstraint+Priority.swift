//
//  NSLayoutConstraint+Priority.swift
//  SwiftColorPicker-iOS
//
//  Created by Zhu Shengqi on 21/1/2018.
//

import UIKit

extension NSLayoutConstraint {
    
    func priority(_ val: UILayoutPriority) -> Self {
        self.priority = val
        return self
    }
    
}
