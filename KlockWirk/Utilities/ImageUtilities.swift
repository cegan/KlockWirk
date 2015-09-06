//
//  ImageUtilities.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/4/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class ImageUtilities{
    
    
    func blurImage(image: UIImage) -> UIImage{
        
        var imageToBlur = CIImage(image: image)
        var blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter!.setValue(imageToBlur, forKey: "inputImage")
        var resultImage = blurfilter!.valueForKey("outputImage") as! CIImage
        var blurredImage = UIImage(CIImage: resultImage)
        
        
        return blurredImage
    }
    
    
    
}