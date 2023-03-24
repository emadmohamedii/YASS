//
//  UIImageView+SDWebImage.swift
//  MovieApp
//
//  Created by Emad Habib on 11/13/20.
//  Copyright © 2018 Emad Habib. All rights reserved.
//

import Foundation
import Kingfisher


extension UIImageView {
    
    public func downloadImageWithCaching(with url: String,placeholderImage: UIImage? = nil){
        if url == ""{
            self.image = placeholderImage
            return
        }
        guard let imageURL = URL.init(string: url) else{
            self.image = placeholderImage
            return
        }
        self.kf.setImage(with: imageURL, placeholder: placeholderImage, options: [.transition(.fade(0.1))], progressBlock: nil, completionHandler: { (image, error, cacheType, _url) in
            //self.image = image
        })
    }
    
}
extension UIImage {
    func resizeImage( targetSize: CGSize) -> UIImage {
          let size = self.size

          let widthRatio  = targetSize.width  / size.width
          let heightRatio = targetSize.height / size.height

          // Figure out what our orientation is, and use that to form the rectangle
          var newSize: CGSize
          if(widthRatio > heightRatio) {
              newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
          } else {
              newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
          }

          // This is the rect that we've calculated out and this is what is actually used below
          let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

          // Actually do the resizing to the rect using the ImageContext stuff
          UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
          self.draw(in: rect)
          let newImage = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()

          return newImage!
      }
}

