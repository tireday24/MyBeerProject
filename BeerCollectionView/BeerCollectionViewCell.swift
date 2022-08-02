//
//  BeerCollectionViewCell.swift
//  MyBeerProject
//
//  Created by 권민서 on 2022/08/03.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {
    static let identifier = "BeerCollectionViewCell"
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    
}
