//
//  BeerTableViewCell.swift
//  MyBeerProject
//
//  Created by 권민서 on 2022/08/03.
//

import UIKit

class BeerTableViewCell: UITableViewCell {

   static let identifier = "BeerTableViewCell"

    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    
}
