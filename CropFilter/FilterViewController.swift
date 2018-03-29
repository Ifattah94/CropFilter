//
//  FilterViewController.swift
//  CropFilter
//
//  Created by C4Q on 3/28/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import CoreImage

class FilterViewController: UIViewController {

    var image: UIImage!
    let filterView = FilterView()
    
    var aCIImage = CIImage()
    var spotColorFilter: CIFilter!
    var context = CIContext()
    var outputImage = CIImage()
    var newUIImage = UIImage()
    var path: UIBezierPath!
    var shapeLayer = CAShapeLayer()
    var croppedImage = UIImage()
    
    init(image: UIImage, path: UIBezierPath) {
        super.init(nibName: nil, bundle: nil)
        self.image = image
        self.path = path
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubView()
       
        filterView.imageView.image = self.image
        applyFilter()
        //cropAgain()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        cropAgain()
    }
    
    private func setupSubView() {
        view.addSubview(filterView)
        filterView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        filterView.contrastSlider.addTarget(self, action: #selector(self.contrastSliderValueChanged(_:)), for: .valueChanged)
        filterView.closenessSlider.addTarget(self, action: #selector(self.closenessSliderValueChanged(_:)), for: .valueChanged)
        
    }
    private func applyFilter() {
        let myImage = filterView.imageView.image!
        let aCGImage = myImage.cgImage
        aCIImage = CIImage(cgImage: aCGImage!)
        context = CIContext(options: nil)
        spotColorFilter = CIFilter(name: "CISpotColor")
        spotColorFilter.setValue(aCIImage, forKey: "inputImage")
        spotColorFilter.setValuesForKeys(["inputCenterColor1": CIColor(color: .red), "inputCenterColor2" : CIColor(color: .clear), "inputCenterColor3": CIColor(color: .black), "inputReplacementColor1": CIColor(color: .black), "inputReplacementColor2": CIColor(color: .clear), "inputReplacementColor3": CIColor(color: .black)])
        outputImage = spotColorFilter.outputImage!
        let cgimg = context.createCGImage(outputImage, from: outputImage.extent)
        image = UIImage(cgImage: cgimg!)
        filterView.imageView.image = newUIImage
        
    }
    
    private func cropAgain() {
        //shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        filterView.imageView.layer.addSublayer(shapeLayer)
        filterView.imageView.layer.mask = shapeLayer
        UIGraphicsBeginImageContextWithOptions(filterView.imageView.bounds.size, false, 1)
        
        filterView.imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
//        if let context = UIGraphicsGetCurrentContext() {
//            filterView.imageView.layer.render(in: context)
//        } else {
//            UIGraphicsBeginImageContext(view.bounds.size)
//            filterView.imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
//
//            print("context is nil")
//        }
    
//         filterView.imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.croppedImage = newImage!
        self.filterView.imageView.image = croppedImage
    }
    
    private func setupNavBar() {
        
    }
    
    @objc func dismissView() {
        self.dismiss(animated: false) {
            
        }
    }
    
    @objc func contrastSliderValueChanged(_ sender: UISlider) {
        spotColorFilter.setValue(NSNumber(value: sender.value), forKey: "inputContrast1")
        spotColorFilter.setValue(NSNumber(value: sender.value), forKey: "inputContrast2")
        spotColorFilter.setValue(NSNumber(value: sender.value), forKey: "inputContrast3")
        outputImage = spotColorFilter.outputImage!
        let cgimg = context.createCGImage(outputImage, from: outputImage.extent)
        newUIImage = UIImage(cgImage: cgimg!)
        filterView.imageView.image = newUIImage
    }
    
    @objc func closenessSliderValueChanged(_ sender: UISlider) {
        spotColorFilter.setValue(NSNumber(value: sender.value), forKey: "inputCloseness1")
        spotColorFilter.setValue(NSNumber(value: sender.value), forKey: "inputCloseness2")
        spotColorFilter.setValue(NSNumber(value: sender.value), forKey: "inputCloseness3")
        outputImage = spotColorFilter.outputImage!
        let cgimg = context.createCGImage(outputImage, from: outputImage.extent)
        newUIImage = UIImage(cgImage: cgimg!)
        filterView.imageView.image = newUIImage
    }

 

}
