//
//  FavoriteTableViewController.swift
//  Sports
//
//  Created by Fatma_Hassan on 20/05/2023.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

    var sports : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sports = ["Football", "Basketball", "Cricket", "Tennis"]

        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        navigationItem.title = "Favorite"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
        
        cell.cellImage.image = UIImage(named: sports?[indexPath.row] ?? "")
        cell.cellImage.layer.cornerRadius = 15
        
        
        cell.cellTitle.text = sports?[indexPath.row] ?? ""
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
   
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        cell.contentView.layer.cornerRadius = 15
        
        cell.contentView.layer.masksToBounds = true

        
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CheckNetwork.checkNetwork(compilitationHandler: { [weak self] network in
            if network! {
                let details = (self?.storyboard?.instantiateViewController(withIdentifier: "details")) as! DetailsViewController
                
                details.sportNumber = indexPath.row
               // details.leagueId = self?.sports![indexPath.row].league_key
                
                self?.present(details, animated: true)
                
            }else{
                let alert : UIAlertController = UIAlertController(title: "Attention", message: "Please, check your connection", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self?.present(alert, animated: true)
            }
        })
    }
}
