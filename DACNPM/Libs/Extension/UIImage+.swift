//
//  UIImage+.swift
//  VideoBridges
//
//  Created by Nguyễn Phạm Thiên Bảo on 3/5/20.
//  Copyright © 2020 Nguyễn Phạm Thiên Bảo. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import Kingfisher

extension UIImage {
    func crop(to size: CGSize) -> UIImage {
        guard let cgimage = self.cgImage else { return self }
        
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        
        let contextSize: CGSize = contextImage.size
        
        //Set to square
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        let cropAspect: CGFloat = size.width / size.height
        
        var cropWidth: CGFloat = size.width
        var cropHeight: CGFloat = size.height
        
        if size.width > size.height { //Landscape
            cropWidth = contextSize.width
            cropHeight = contextSize.width / cropAspect
            posY = (contextSize.height - cropHeight) / 2
        } else if size.width < size.height { //Portrait
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        } else { //Square
            if contextSize.width >= contextSize.height { //Square on landscape (or square)
                cropHeight = contextSize.height
                cropWidth = contextSize.height * cropAspect
                posX = (contextSize.width - cropWidth) / 2
            }else{ //Square on portrait
                cropWidth = contextSize.width
                cropHeight = contextSize.width / cropAspect
                posY = (contextSize.height - cropHeight) / 2
            }
        }
        
        let rect: CGRect = CGRect(x : posX, y : posY, width : cropWidth, height : cropHeight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        cropped.draw(in: CGRect(x : 0, y : 0, width : size.width, height : size.height))
        
        return cropped
    }
    
    public func cropToBounds(size: CGSize) -> UIImage? {
        
        guard let cgImage = self.cgImage else {
            return nil
        }
        let contextImage = UIImage(cgImage: cgImage)
        let contextSize: CGSize = contextImage.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = size.width
        var cgheight: CGFloat = size.height
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        if let imageRef = cgImage.cropping(to: rect) {
            // Create a new image based on the imageRef and rotate back to the original orientation
            return UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        }
        return nil
    }
}


extension AVAsset {
    
    var videoURL: String {
        guard let urlAsset = self as? AVURLAsset else { return "" }
        return urlAsset.url.path
    }
    
    func generateThumbnail(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: 0.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
            })
        }
    }
}
