//
//  HuePicker.swift
//  SwiftColorPicker-iOS
//
//  Created by Zhu Shengqi on 12/1/2018.
//

import UIKit

public protocol HuePickerDelegate: class {
    func huePicker(_ picker: HuePicker, didPickHue hue: CGFloat)
}

public final class HuePicker: UIView {
    
    // MARK: - Properties
    public weak var delegate: HuePickerDelegate?
    
    private var _hue: CGFloat = 0

    private let bar = Bar()
    
    private let marker = Marker()
    
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(self.gestureRecognized(_:)))
        
        return recognizer
    }()
    
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.gestureRecognized(_:)))
        
        return recognizer
    }()
    
    private var markerCenterXConstraint: NSLayoutConstraint!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addGestureRecognizer(panGestureRecognizer)
        addGestureRecognizer(tapGestureRecognizer)
        
        updateMarkerBackground()
        
        addSubview(bar)
        bar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: marker.intrinsicContentSize.width / 2),
            bar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -marker.intrinsicContentSize.width / 2),
            bar.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        
        addSubview(marker)
        marker.translatesAutoresizingMaskIntoConstraints = false
        
        markerCenterXConstraint = marker.centerXAnchor.anchorWithOffset(to: bar.leftAnchor).constraint(equalTo: bar.widthAnchor, multiplier: -hue)
        NSLayoutConstraint.activate([
            marker.topAnchor.constraint(equalTo: self.topAnchor),
            marker.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            markerCenterXConstraint
            ])
    }

    public var hue: CGFloat {
        get {
            return _hue
        }
        set {
            _hue = newValue
            updateMarkerBackground()
            
            markerCenterXConstraint.isActive = false
            markerCenterXConstraint = marker.centerXAnchor.anchorWithOffset(to: bar.leftAnchor).constraint(equalTo: bar.widthAnchor, multiplier: -hue)
            markerCenterXConstraint.isActive = true
        }
    }
    
    private func updateMarkerBackground() {
        marker.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
    }

    @objc
    private func gestureRecognized(_ recognizer: UIGestureRecognizer) {
        let location = recognizer.location(in: self)
        hue = (min(bar.frame.maxX, max(bar.frame.minX, location.x)) - bar.frame.minX) / bar.frame.width
        delegate?.huePicker(self, didPickHue: hue)
    }
}
