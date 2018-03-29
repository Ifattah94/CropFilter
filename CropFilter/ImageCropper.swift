//
//  ImageCropper.swift
//  CropFilter
//
//  Created by C4Q on 3/28/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit

public class ZImageCropper{
    public class func cropImage(ofImageView:UIImageView, withinPoints points:[CGPoint])->UIImage?{
        
        //Check if there is start and end points exists
        if points.count >= 2{
            let path = UIBezierPath()
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = UIColor.white.cgColor
            shapeLayer.lineWidth = 2
            var croppedImage:UIImage?
            
            for (index,point) in points.enumerated(){
                
                //Origin
                if index == 0{
                    path.move(to: point)
                    
                    //Endpoint
                }else if index == points.count-1{
                    path.addLine(to: point)
                    path.close()
                    shapeLayer.path = path.cgPath
                    
                    ofImageView.layer.addSublayer(shapeLayer)
                    shapeLayer.fillColor = UIColor.white.cgColor
                    ofImageView.layer.mask = shapeLayer
                    UIGraphicsBeginImageContextWithOptions(ofImageView.frame.size, false, 1)
                    
                    if let currentContext = UIGraphicsGetCurrentContext(){
                        ofImageView.layer.render(in: currentContext)
                    }
                    
                    
                    let newImage = UIGraphicsGetImageFromCurrentImageContext()
                    
                    UIGraphicsEndImageContext()
                    
                    croppedImage = newImage
                    
                    //Move points
                }else{
                    path.addLine(to: point)
                }
            }
            
            return croppedImage
        }else{
            return nil
        }
}
}
