//
//  Team.swift
//  Sports
//
//  Created by Fatma_Hassan on 23/05/2023.
//

import Foundation

class Team : Decodable{
    var team_key : Int?
    var team_name : String?
    var team_logo : String?
    var players : [Player]?
}
