//
//  PlayersViewController.swift
//  Sports
//
//  Created by Fatma_Hassan on 25/05/2023.
//

import UIKit

class PlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var playerTable: UITableView!
    
    var imageTeam : String?
    
    var teamKey : Int?
    
    var players : [Player]!
    
    var sportNumber : Int?
        
    var playerViewModel : PlayersViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        playerViewModel = PlayersViewModel()
        
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.center = self.view.center
        self.view.addSubview(indicatorView)
        indicatorView.startAnimating()
        
        playerViewModel?.getData(sportNumber:  sportNumber ?? 0, teamKey: teamKey ?? 0)
        
        playerViewModel?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.players = self?.playerViewModel?.result?[0].players
                
                self?.teamImage.layer.cornerRadius = (self?.teamImage.frame.height ?? 0)/2
                
                self?.teamImage.kf.setImage(with: URL(string: self?.playerViewModel?.result?[0].team_logo ?? ""), placeholder: UIImage(named: "placeHolder"))
                
                self?.playerTable.reloadData()
                indicatorView.stopAnimating()
            }
        }
        
        playerTable.register(UINib(nibName: "PlayersTableViewCell", bundle: nil), forCellReuseIdentifier: "playersCell")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
                cell.contentView.layer.cornerRadius = 30
        
                cell.contentView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playersCell", for: indexPath) as! PlayersTableViewCell
    
        cell.playerImage.layer.cornerRadius = cell.playerImage.frame.height/2

        cell.playerImage.kf.setImage(with: URL(string: players[indexPath.row].player_image ?? ""), placeholder: UIImage(named: "placeHolder"))
        
        cell.playerName.text = players[indexPath.row].player_name ?? ""
        
        cell.playerType.text = players[indexPath.row].player_type ?? ""
        
        cell.playerNumber.text = players[indexPath.row].player_number ?? ""
        
        return cell
    }

}
