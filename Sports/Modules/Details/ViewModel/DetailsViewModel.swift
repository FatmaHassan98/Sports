//
//  DetailsViewModel.swift
//  Sports
//
//  Created by Fatma_Hassan on 21/05/2023.
//

import Foundation

class DetailsViewModel{
    
    let sports = ["football", "basketball", "cricket", "tennis"]
    
    var bindResultUpComingToViewController : (() -> ()) = {}
    
    var resultUpComing : [Event]?{
        didSet{
            bindResultUpComingToViewController()
        }
    }
    
    var bindResultLatestToViewController : (() -> ()) = {}
    
    var resultLatest : [Event]?{
        didSet{
            bindResultLatestToViewController()
        }
    }
    
    var bindResultTeamToViewController : (() -> ()) = {}
    
    var resultTeam : [Team]?{
        didSet{
            bindResultTeamToViewController()
        }
    }
    
    func getUpComingData(sportNumber : Int, leaguesId : Int){
        
        let url = "https://apiv2.allsportsapi.com/\(sports[sportNumber])?met=Fixtures&leagueId=\(leaguesId)&from=2023-01-18&to=2024-01-18&APIkey=aa502a5e593da9a0ccea18734e2ece289b05d81e9cb6ed521d7d9306da9888ce"
        
        NetworkManage.loadDataFromURL(url: url) { [weak self] (result : ResponseEvent?) in
            self?.resultUpComing = result?.result
        }
    }
    
    func getLatestData(sportNumber : Int, leaguesId : Int){
        
        let url = "https://apiv2.allsportsapi.com/\(sports[sportNumber])?met=Fixtures&leagueId=\(leaguesId)&from=2022-01-18&to=2023-01-18&APIkey=aa502a5e593da9a0ccea18734e2ece289b05d81e9cb6ed521d7d9306da9888ce"
        
        NetworkManage.loadDataFromURL(url: url) { [weak self] (result : ResponseEvent?) in
            self?.resultLatest = result?.result
        }
    }
    
    func getTeamData(sportNumber : Int, leaguesId : Int){
        
        let url = "https://apiv2.allsportsapi.com/\(sports[sportNumber])?met=Teams&?met=Leagues&leagueId=\(leaguesId)&APIkey=aa502a5e593da9a0ccea18734e2ece289b05d81e9cb6ed521d7d9306da9888ce"
        
        NetworkManage.loadDataFromURL(url: url) { [weak self] (result : ResponseTeam?) in
            self?.resultTeam = result?.result
        }
    }
}
