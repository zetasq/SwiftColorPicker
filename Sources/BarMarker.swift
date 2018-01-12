//
//  BarMarker.swift
//  SwiftColorPicker-iOS
//
//  Created by Zhu Shengqi on 12/1/2018.
//

import UIKit

final class BarMarker: UIView {
    
    private lazy var innerView: UIView = {
        let innerView = UIView()
        
        innerView.backgroundColor = .white
        innerView.layer.cornerRadius = 5
        innerView.clipsToBounds = true
        
        return innerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    init() {
        super.init(frame: .zero)
        
        frame.size = intrinsicContentSize
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
        
        addSubview(innerView)
        innerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            innerView.topAnchor.constraint(equalTo: self.topAnchor),
            innerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            innerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            innerView.rightAnchor.constraint(equalTo: self.rightAnchor)
            ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 10, height: 25)
    }
    
}
