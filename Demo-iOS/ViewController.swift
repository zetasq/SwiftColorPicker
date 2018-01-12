//
//  ViewController.swift
//  Demo-iOS
//
//  Created by Zhu Shengqi on 12/1/2018.
//

import UIKit
import SwiftColorPicker

class ViewController: UIViewController {
    
    private var color: UIColor = .red
    
    private lazy var colorPicker: HSBColorPicker = {
        let picker = HSBColorPicker()
        
        picker.uiColor = self.color
        picker.delegate = self
        
        return picker
    }()
    
    private lazy var testView: UIView = {
        let testView = UIView()
        
        testView.backgroundColor = self.color
        
        return testView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(testView)
        testView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            testView.widthAnchor.constraint(equalToConstant: 100),
            testView.heightAnchor.constraint(equalToConstant: 100),
            testView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        view.addSubview(colorPicker)
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            colorPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            colorPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
            ])
        
    }

}

extension ViewController: HSBColorPickerDelegate {
    func hsbColorPicker(_ picker: HSBColorPicker, didPickColor color: UIColor) {
        testView.backgroundColor = color
    }
}

