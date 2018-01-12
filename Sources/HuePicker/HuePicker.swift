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
        let topInset = max(0, marker.intrinsicContentSize.height - bar.intrinsicContentSize.height) / 2
        
        NSLayoutConstraint.activate([
            bar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: marker.intrinsicContentSize.width / 2),
            bar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -marker.intrinsicContentSize.width / 2),
            bar.topAnchor.constraint(equalTo: self.topAnchor, constant: topInset),
            bar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -topInset)
            ])
        
        addSubview(marker)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateMarkerLocation()
    }

    public var hue: CGFloat {
        get {
            return _hue
        }
        set {
            _hue = newValue
            updateMarkerBackground()
            updateMarkerLocation()
        }
    }
    
    private func updateMarkerLocation() {
        marker.center.x = bar.frame.minX + bar.frame.width * hue
    }
    
    private func updateMarkerBackground() {
        marker.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
    }

    @objc
    private func gestureRecognized(_ recognizer: UIGestureRecognizer) {
        let location = recognizer.location(in: self)
        hue = min(bar.frame.width, max(0, location.x - bar.frame.minX)) / bar.frame.width
        delegate?.huePicker(self, didPickHue: hue)
    }
}
