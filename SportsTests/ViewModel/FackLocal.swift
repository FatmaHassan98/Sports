//
//  FackLocal.swift
//  SportsTests
//
//  Created by Fatma_Hassan on 31/05/2023.
//

import Foundation
@testable import Sports

class FackLocal : FavoriteProtocol{
    
    var favoriteArray : NSMutableArray?
    
    init(){
        favoriteArray = NSMutableArray()
    }
    
    func insert(favorite : FavoriteSport) {
        if favorite == nil{
        }else{
            favoriteArray?.add(favorite)
        }
    }
    
    func getFavorite()-> [FavoriteSport]{
        return favoriteArray as! [FavoriteSport]
    }
    
    func deleteFavorite(id : Int){
        if favoriteArray == nil{
            
        }else{
            favoriteArray?.removeObject(at: id)
        }
    }
    
}

