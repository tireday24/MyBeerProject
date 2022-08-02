//
//  BeerTableViewController.swift
//  MyBeerProject
//
//  Created by 권민서 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class BeerTableViewController: UITableViewController {

    var beerList: [BeerInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestApi()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier) as? BeerTableViewCell else { return UITableViewCell()}
        
        let randomImage = URL(string: beerList[indexPath.row].beerImageInfo)
        cell.beerName.text = beerList[indexPath.row].beerNameInfo
        cell.beerImage.kf.setImage(with: randomImage)
        cell.beerDescription.text = beerList[indexPath.row].beerDescriptionInfo
        
        return cell
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
                
                self.tableView.reloadData()
               

            case .failure(let error):
                print(error)
            }

}
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}
