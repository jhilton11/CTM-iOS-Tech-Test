//
//  UIImageView+Extension.swift
//  ParentPay Technical Test
//
//  Created by student on 2024-05-04.
//

import Foundation
import UIKit

var imageCache: NSCache<NSString, NSObject> = NSCache()

extension UIImageView {
    
    func loadImage(urlString: String) {
        print("Trying to load image into imageview")
        if let url = URL(string: urlString) {
            //If image is already stored in cache, load image and exit function
            if let storedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
                print("Image found in cache")
                self.image = storedImage
                return
            }
            
            //Image is not in cache, load image from url and save in cache
            URLSession.shared.dataTask(with: url) { [weak self]
                data, response, error in
                
                guard error == nil, data != nil else {
                    print("Error is not nil or data is nil")
                    return
                }
                
                DispatchQueue.main.async {
                    print("Loading image into imageview")
                    let image = UIImage(data: data!)
                    imageCache.setObject(image!, forKey: urlString as NSString)
                    self?.image = image
                }
            }.resume()
        } else {
            print("Unable to load url")
        }
    }
    
}

extension UILabel {
    
    func makeRed() {
        textColor = .red
    }
    
}
