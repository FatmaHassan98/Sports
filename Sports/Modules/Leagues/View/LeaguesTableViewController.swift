//
//  LeaguesTableViewController.swift
//  Sports
//
//  Created by Fatma_Hassan on 21/05/2023.
//

import UIKit
import Kingfisher

class LeaguesTableViewController: UITableViewController {

    var sports : [League]!
    
    var sportNumber : Int = 0
    
    var leaguesViewModel : LeaguesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.center = self.view.center
        self.view.addSubview(indicatorView)
        indicatorView.startAnimating()
        
        leaguesViewModel = LeaguesViewModel()
        
        leaguesViewModel?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.sports = self!.leaguesViewModel?.result
                
                indicatorView.stopAnimating()
                
                self?.tableView.reloadData()
            }
        }
    
        leaguesViewModel?.getData(sportNumber: sportNumber)

        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")

        navigationItem.title = "Leagues"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
                
        
        cell.cellImage.kf.setImage(
            with: URL(string: sports[indexPath.row].league_logo ?? ""),
            placeholder: UIImage(named: "placeHolder"))
        
        cell.cellImage.layer.cornerRadius = 15
                
        cell.cellTitle.text = sports?[indexPath.row].league_name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
   
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        cell.contentView.layer.cornerRadius = 15
        
        cell.contentView.layer.masksToBounds = true

        
    }

}
