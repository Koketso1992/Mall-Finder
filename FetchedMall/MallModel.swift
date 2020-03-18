//
//  MallModel.swift
//  FetchedMall
//
//  Created by Koketso Motsikwe (ZA) on 2020/03/12.
//  Copyright © 2020 Koketso Motsikwe (ZA). All rights reserved.
//

import UIKit



struct mall {
    var name: String?
    var types: [String]?
    var address: String?
    var imageRef: String?
    var image = UIImage()
}

struct MallListModel{
    var mallList = [mall]()
    
    init (with arrayOfMallsJson: [String:Any]) {
        if let results = arrayOfMallsJson["results"] as? [[String:Any]] {
            for mallJson in results  {
                var mallObject = mall()
                mallObject.name = mallJson["name"] as? String
                mallObject.types = mallJson["types"] as? [String]
                mallObject.address = mallJson["vicinity"] as? String
                if let photos = mallJson["photos"] as? [[String:Any]] {
                    for photo in photos {
                        if let photoref = photo["photo_reference"] as? String {
                            mallObject.imageRef = photoref
                
            }
        }
                     mallList.append(mallObject)
    }
}
}
}
}
