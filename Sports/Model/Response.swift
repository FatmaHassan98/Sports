//
//  Response.swift
//  Sports
//
//  Created by Fatma_Hassan on 21/05/2023.
//

import Foundation

class Response : Decodable {
    var success : Int?
    var result : [League]?
}

class ResponseEvent : Decodable{
    var success : Int?
    var result : [Event]?
}

class ResponseTeam : Decodable {
    var success : Int?
    var result : [Team]?
}

class ResponsePlayer : Decodable{
    var success : Int?
    var result : [Team]?
}


