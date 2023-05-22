//
//  LeaguesViewModel.swift
//  Sports
//
//  Created by Fatma_Hassan on 21/05/2023.
//

import Foundation

class LeaguesViewModel {
    
    var bindResultToViewController : (() -> ()) = {}
    
    var result : [League]?{
        didSet{
            bindResultToViewController()
        }
    }
    
    var sports = ["https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=aa502a5e593da9a0ccea18734e2ece289b05d81e9cb6ed521d7d9306da9888ce", "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=aa502a5e593da9a0ccea18734e2ece289b05d81e9cb6ed521d7d9306da9888ce", "https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=aa502a5e593da9a0ccea18734e2ece289b05d81e9cb6ed521d7d9306da9888ce", "https://apiv2.allsportsapi.com/tennis/?met=Leagues&APIkey=aa502a5e593da9a0ccea18734e2ece289b05d81e9cb6ed521d7d9306da9888ce"]
    
    func getData(sportNumber : Int){
        NetworkManage.loadDataFromURL(url: sports[sportNumber]) { [weak self] (result : Response?) in
            self?.result = result?.result
        }
    }
}
