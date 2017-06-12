//
//  uploadViewController.swift
//  Insta
//
//  Created by Ameya Vichare on 10/06/17.
//  Copyright © 2017 vit. All rights reserved.
//

import UIKit
import Alamofire
import ImagePicker

class uploadViewController: UIViewController, ImagePickerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        let url = try! URLRequest(url: "http://api.petoye.com/feeds/2/create", method: .post)
        
        Alamofire.upload(multipartFormData: { (data) in
            
            let imageData = UIImagePNGRepresentation(images[0])
            
            let param = ["Message":"hello"]
            
            data.append(imageData!, withName: "Image", fileName: "test.png", mimeType: "image/png")
            for (key,value) in param
            {
                data.append((value.data(using: String.Encoding.utf8)!), withName:key)
            }

            
            
        }, with: url) { (result) in
            
            switch result {
                
            case .success(let upload, _, _):
            
                print("success")
                
            default: break
            }
        }
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        
        
    }

}
