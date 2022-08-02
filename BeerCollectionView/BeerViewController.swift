//
//  BeerViewController.swift
//  MyBeerProject
//
//  Created by 권민서 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class BeerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var beerList: [BeerInfo] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        cellDesign()
        requestApi()
      
    }
    
    func cellDesign() {
        
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 10
        let width = UIScreen.main.bounds.width / 2 - (spacing * 3)
        layout.itemSize = CGSize(width: width , height: (width * 1.2))
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
    func requestApi() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for beer in json.arrayValue {
                    let beerName = beer["name"].stringValue
                    let beerImage = beer["image_url"].stringValue
                    let beerInfo = beer["description"].stringValue
                    
                    let info = BeerInfo(beerNameInfo: beerName, beerImageInfo: beerImage, beerDescriptionInfo: beerInfo)
                    self.beerList.append(info)
                }
                
                self.collectionView.reloadData()
                
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCell.identifier, for: indexPath) as? BeerCollectionViewCell else {
            return UICollectionViewCell()}
        
        cell.beerName.text = beerList[indexPath.item].beerNameInfo
        
        let url = URL(string: beerList[indexPath.item].beerImageInfo)
        cell.beerImage.kf.setImage(with: url)
        
        cell.beerDescription.text = beerList[indexPath.item].beerDescriptionInfo
        
        return cell
    }
    
    
    
    
   

}
