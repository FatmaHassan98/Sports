//
//  ViewController.swift
//  Sports
//
//  Created by Fatma_Hassan on 20/05/2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var sports : [String]?
    
    var leaguesViewModel : LeaguesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sports = ["Football", "Basketball", "Cricket", "Tennis"]
        
        navigationItem.title = "Sports"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! SportsCollectionViewCell
        
        cell.sportsImage.image = UIImage(named: sports?[indexPath.row] ?? "")
        cell.sportsTitle.text = sports?[indexPath.row] ?? ""
        
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.size.width)/2  , height:200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 35, bottom: 20, right: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        CheckNetwork.checkNetwork(compilitationHandler: { [weak self] network in
            if network! {
                let leagues = (self?.storyboard?.instantiateViewController(withIdentifier: "leagues")) as! LeaguesTableViewController
                
                leagues.sportNumber = indexPath.row
                
                self?.navigationController?.pushViewController(leagues, animated: true)
            }else{
                let alert : UIAlertController = UIAlertController(title: "Attention", message: "Please, check your connection", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self?.present(alert, animated: true)
            }
        })
        
    }

}

