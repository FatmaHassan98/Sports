//
//  FavoriteTableViewController.swift
//  Sports
//
//  Created by Fatma_Hassan on 20/05/2023.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

    var sports : [FavoriteSport]?
    
    var viewModel : FavoriteViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = FavoriteViewModel()
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        navigationItem.title = "Favorite"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sports = viewModel?.getFavorite()
        self.tableView.reloadData()
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
            with: URL(string: sports?[indexPath.row].image ?? ""),
            placeholder: UIImage(named: "placeHolder"))
        
        cell.cellImage.layer.cornerRadius = 15
        
        
        cell.cellTitle.text = sports?[indexPath.row].name ?? ""
        
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
                
                details.sportNumber = self?.sports?[indexPath.row].sportNumber ?? 0
                details.leagueId = self?.sports?[indexPath.row].leaguesId ?? 0
                details.name = self?.sports?[indexPath.row].name ?? ""
                details.image = self?.sports?[indexPath.row].image ?? ""
                
                details.modalPresentationStyle = .fullScreen
                
                self?.present(details, animated: true)
                
            }else{
                let alert : UIAlertController = UIAlertController(title: "Attention", message: "Please, check your connection", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self?.present(alert, animated: true)
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert : UIAlertController = UIAlertController(title: "Attention", message: "Do you went to delete this item?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "No", style: .default,handler: nil))
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default , handler: { action in
                
                self.viewModel?.deleteFavorite(id: indexPath.row)
                self.sports = []
                self.sports = self.viewModel?.getFavorite()
                tableView.reloadData()
                
            }))
            self.present(alert, animated: true)
            
        }
        
    }
      
}
