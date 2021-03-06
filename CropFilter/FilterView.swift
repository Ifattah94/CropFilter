//
//  FilterView.swift
//  CropFilter
//
//  Created by C4Q on 3/28/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FilterView: UIView {

    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.isOpaque = true
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    lazy var contrastSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.1
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        return slider
    }()
    
    lazy var closenessSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.1
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupImageView()
        setupContrastSlider()
        setupClosenessSlider()
    }
    
    private func setupImageView() {
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(8)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-8)
            make.height.equalTo(imageView.snp.width).multipliedBy(0.8)
        }
    }
    
    private func setupContrastSlider() {
        self.addSubview(contrastSlider)
        contrastSlider.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(25)
            make.width.equalTo(imageView.snp.width).multipliedBy(0.7)
            make.height.equalTo(imageView.snp.height).multipliedBy(0.11)
        }
    }
    
    private func setupClosenessSlider() {
        self.addSubview(closenessSlider)
        closenessSlider.snp.makeConstraints { (make) in
            make.top.equalTo(contrastSlider.snp.bottom).offset(15)
            make.centerX.equalTo(contrastSlider.snp.centerX)
            make.height.equalTo(contrastSlider.snp.height)
            make.width.equalTo(contrastSlider.snp.width)
            
        }
    }
    

}
