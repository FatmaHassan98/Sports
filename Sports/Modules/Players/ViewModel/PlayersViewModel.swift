//
//  PlayersViewModel.swift
//  Sports
//
//  Created by Fatma_Hassan on 25/05/2023.
//

import Foundation

class PlayersViewModel {
    
    var bindResultToViewController : (() -> ()) = {}
    
    let sports = ["football", "basketball", "cricket", "tennis"]
        
    var result : [Team]?{
        didSet{
            bindResultToViewController()
        }
    }
    
        
    func getData(sportNumber : Int ,teamKey : Int){
        let url = "https://apiv2.allsportsapi.com/\(sports[sportNumber])/?&met=Teams&teamId=\(teamKey)&APIkey=2023-01-01&to=2024-01-01&APIkey=aa502a5e593da9a0ccea18734e2ece289b05d81e9cb6ed521d7d9306da9888ce"
                
        NetworkManage.loadDataFromURL(url: url) { [weak self] (result : ResponsePlayer?) in
            self?.result = result?.result
        }
    }
}

