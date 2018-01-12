//
//  BrightnessPicker.swift
//  SwiftColorPicker-iOS
//
//  Created by Zhu Shengqi on 12/1/2018.
//

import UIKit

public protocol BrightnessPickerDelegate: class {
    func brightnessPicker(_ picker: BrightnessPicker, didPickBrightness brightness: CGFloat)
}

public final class BrightnessPicker: UIView {
    
    public weak var delegate: BrightnessPickerDelegate?
    
    private var _color: HSBColor = UIColor.red.hsbColor
    
    private let bar = Bar()
    
    private let marker = BarMarker()
    
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
        
        bar.color = color
        
        addSubview(bar)
        bar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: marker.intrinsicContentSize.width / 2),
            bar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -marker.intrinsicContentSize.width / 2),
            bar.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        
        addSubview(marker)
        marker.translatesAutoresizingMaskIntoConstraints = false
        
        markerCenterXConstraint = marker.centerXAnchor.anchorWithOffset(to: bar.leftAnchor).constraint(equalTo: bar.widthAnchor, multiplier: -color.brightness)
        NSLayoutConstraint.activate([
            marker.topAnchor.constraint(equalTo: self.topAnchor),
            marker.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            markerCenterXConstraint
            ])
    }
    
    public var color: HSBColor {
        get {
            return _color
        }
        set {
            _color = newValue
            bar.color = newValue
            updateMarkerLocation()
        }
    }
    
    private func updateMarkerLocation() {
        markerCenterXConstraint.isActive = false
        markerCenterXConstraint = marker.centerXAnchor.anchorWithOffset(to: bar.leftAnchor).constraint(equalTo: bar.widthAnchor, multiplier: -color.brightness)
        markerCenterXConstraint.isActive = true
    }

    @objc
    private func gestureRecognized(_ recognizer: UIGestureRecognizer) {
        let location = recognizer.location(in: self)
        
        let brightness = (min(bar.frame.maxX, max(bar.frame.minX, location.x)) - bar.frame.minX) / bar.frame.width
        _color = _color.withBrightness(brightness)
        updateMarkerLocation()
        
        delegate?.brightnessPicker(self, didPickBrightness: brightness)
    }
}
