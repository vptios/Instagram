//
//  ViewController.swift
//  Insta
//
//  Created by Ameya Vichare on 05/06/17.
//  Copyright © 2017 vit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var images = [#imageLiteral(resourceName: "insta1"),#imageLiteral(resourceName: "insta2"),#imageLiteral(resourceName: "insta3"),#imageLiteral(resourceName: "insta4"),#imageLiteral(resourceName: "insta5")]
    
    var images = [UIImage]()

    @IBOutlet weak var instaTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instaTable.separatorStyle = .none
        
        callApi()
    }
    
    func callApi() {
        
        Alamofire.request("http://api.petoye.com/feeds/1/followedfeeds").responseJSON { (response) in
            
            print(response.result.value!)
            
            let json = JSON(response.result.value!)
            
            for item in json["feeds"].arrayValue {
                
                print(item["imageurl"].stringValue)
                
                if item["imageurl"].stringValue.isEmpty == false {
                    
                    let url = URL(string: item["imageurl"].stringValue)
                    
                    let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        
                        if error != nil
                        {
                            
                            // no image found
                            
                            print("here2")
                            
                            self.images.append(#imageLiteral(resourceName: "insta1"))

                        }
                        else
                        {
                            if let image = UIImage(data: data!) {
                                
                                self.images.append(image)

                            }
                            
                        }
                        
                        DispatchQueue.main.async {
                            
                            self.instaTable.reloadData()
                        }
                        
                        
                        
                        
                    })
                    task.resume()
                }
                else {
                    
                    self.images.append(#imageLiteral(resourceName: "insta1"))
                    
//                    DispatchQueue.main.async {
                    
                        self.instaTable.reloadData()
//                    }

                    
                }
                
                

            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "instaCell", for: indexPath) as! instaCellTableViewCell

        cell.photo.image = #imageLiteral(resourceName: "insta1")
        
        
        
        return cell
    }



}

