//
//  HSBColorPicker.swift
//  SwiftColorPicker-iOS
//
//  Created by Zhu Shengqi on 12/1/2018.
//

import UIKit


@objc
public protocol HSBColorPickerDelegate: class {
    func hsbColorPicker(_ picker: HSBColorPicker, didPickColor color: UIColor)
}

@objc
public final class HSBColorPicker: UIView {
    
    @objc
    public weak var delegate: HSBColorPickerDelegate?
    
    private lazy var huePicker: HuePicker = {
        let picker = HuePicker()
        
        picker.hue = self.color.hue
        picker.delegate = self
        
        return picker
    }()
    
    private lazy var saturationPicker: SaturationPicker = {
        let picker = SaturationPicker()
        
        picker.color = self.color
        picker.delegate = self
        
        return picker
    }()
    
    private lazy var brightnessPicker: BrightnessPicker = {
       let picker = BrightnessPicker()
        
        picker.color = self.color
        picker.delegate = self
        
        return picker
    }()
    
    private var _color: HSBColor = UIColor.red.hsbColor

    @objc
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(huePicker)
        huePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            huePicker.topAnchor.constraint(equalTo: self.topAnchor),
            huePicker.leftAnchor.constraint(equalTo: self.leftAnchor),
            huePicker.rightAnchor.constraint(equalTo: self.rightAnchor)
            ])
        
        addSubview(saturationPicker)
        saturationPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saturationPicker.topAnchor.constraint(equalTo: huePicker.bottomAnchor, constant: 15),
            saturationPicker.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            saturationPicker.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        
        addSubview(brightnessPicker)
        brightnessPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            brightnessPicker.centerYAnchor.constraint(equalTo: saturationPicker.centerYAnchor),
            brightnessPicker.leftAnchor.constraint(equalTo: saturationPicker.rightAnchor, constant: 10),
            brightnessPicker.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            brightnessPicker.widthAnchor.constraint(equalTo: saturationPicker.widthAnchor)
            ])
    }
    
    public var color: HSBColor {
        get {
            return _color
        }
        set {
            _color = newValue
            huePicker.hue = newValue.hue
            saturationPicker.color = _color
            brightnessPicker.color = _color
        }
    }
    
    @objc
    public var uiColor: UIColor {
        get {
            return color.uiColor
        }
        set {
            color = newValue.hsbColor
        }
    }
    
}

extension HSBColorPicker: HuePickerDelegate {
    public func huePicker(_ picker: HuePicker, didPickHue hue: CGFloat) {
        _color = _color.withHue(hue)
        
        saturationPicker.color = _color
        brightnessPicker.color = _color
        
        delegate?.hsbColorPicker(self, didPickColor: _color.uiColor)
    }
}

extension HSBColorPicker: SaturationPickerDelegate {
    public func saturationPicker(_ picker: SaturationPicker, didPickSaturation saturation: CGFloat) {
        _color = _color.withSaturation(saturation)
        
        brightnessPicker.color = _color

        delegate?.hsbColorPicker(self, didPickColor: _color.uiColor)
    }
}

extension HSBColorPicker: BrightnessPickerDelegate {
    public func brightnessPicker(_ picker: BrightnessPicker, didPickBrightness brightness: CGFloat) {
        _color = _color.withBrightness(brightness)
        
        saturationPicker.color = _color

        delegate?.hsbColorPicker(self, didPickColor: _color.uiColor)
    }
}

