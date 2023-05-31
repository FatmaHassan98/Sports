//
//  FavoriteViewModel.swift
//  Sports
//
//  Created by Fatma_Hassan on 21/05/2023.
//

import Foundation

protocol FavoriteProtocol{
    
    func getFavorite()-> [FavoriteSport]
    
    func deleteFavorite(id : Int)
    
}

class FavoriteViewModel : FavoriteProtocol{
    
    func getFavorite()-> [FavoriteSport]{
        return DBManager.shared.fetchFavorite()
    }
    
    func deleteFavorite(id : Int){
        DBManager.shared.deleteFavorite(id: id)
    }
    
}
