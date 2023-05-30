//
//  FavoriteViewModel.swift
//  Sports
//
//  Created by Fatma_Hassan on 21/05/2023.
//

import Foundation

class FavoriteViewModel{
    
    
    func getFavorite()-> [FavoriteSport]{
        return DBManager.shared.fetchFavorite()
    }
    
    func deleteFavorite(id : Int){
        DBManager.shared.deleteFavorite(id: id)
    }
    
}
