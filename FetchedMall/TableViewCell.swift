//
//  TableViewCell.swift
//  FetchedMall
//
//  Created by Koketso Motsikwe (ZA) on 2020/03/13.
//  Copyright © 2020 Koketso Motsikwe (ZA). All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var mallName: UILabel!
    @IBOutlet var mallImage: UIImageView!
    @IBOutlet var mallDescription: UILabel!
    
    func populate(city: mall){
        mallName.text = city.name ?? ""
        mallDescription.text = city.address ?? ""
        mallImage.image = city.image
    }
    
}
