//
//  CropView.swift
//  CropFilter
//
//  Created by C4Q on 3/28/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CropView: UIView {

    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var cropButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 0.6
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Crop", for: .normal)
        let font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        button.titleLabel?.font = font
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 0.6
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Cancel", for: .normal)
        let font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        button.titleLabel?.font = font
        
        return button
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
        setupCropButton()
        setupCancelButton()
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
    
    private func setupCropButton() {
        self.addSubview(cropButton)
        cropButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(25)
            make.width.equalTo(imageView.snp.width).multipliedBy(0.4)
            make.height.equalTo(imageView.snp.height).multipliedBy(0.11)
        }
    }
    
    private func setupCancelButton() {
        self.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(cropButton.snp.bottom).offset(15)
            make.centerX.equalTo(cropButton.snp.centerX)
            make.height.equalTo(cropButton.snp.height)
            make.width.equalTo(cropButton.snp.width)
            
        }
    }
    
    
    

}
