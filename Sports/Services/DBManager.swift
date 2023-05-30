//
//  DBManager.swift
//  Sports
//
//  Created by Fatma_Hassan on 22/05/2023.
//

import Foundation
import CoreData
import UIKit

class DBManager{

    static let shared = DBManager()

    var appDelegate : AppDelegate

    var managedContext : NSManagedObjectContext

    var favorite : [NSManagedObject] = []

    var favoriteArray : [FavoriteSport] = []

    private init(){
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }

    func insertFavorite(favorite : FavoriteSport){

        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!

        let favoriteTable = NSManagedObject(entity: entity, insertInto: managedContext)
        
        favoriteTable.setValue(favorite.name, forKey: "name")
        
        favoriteTable.setValue(favorite.image, forKey: "image")
        
        favoriteTable.setValue(favorite.sportNumber, forKey: "sportNumber")

        favoriteTable.setValue(favorite.leaguesId, forKey: "leaguesId")

        do{
            try managedContext.save()
            
            print("saved")

        }catch let error as NSError{

            print(error)

        }

    }
    
    func fetchFavorite()-> [FavoriteSport]{

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")

        do{
            favoriteArray = []
            
            favorite = try managedContext.fetch(fetchRequest)

            for item in favorite {

                let favorite : FavoriteSport = FavoriteSport()
                
                favorite.name =  (item.value(forKey: "name") as? String)

                favorite.image =  (item.value(forKey: "image") as? String)

                favorite.sportNumber = (item.value(forKey: "sportNumber") as? Int)

                favorite.leaguesId = (item.value(forKey: "leaguesId") as? Int)

                print("tttttt \(String(describing: favorite.name))")
                
                favoriteArray.append(favorite)

            }

            print("Fetched")

        }catch let error as NSError{

            print(error)

        }
        return favoriteArray

    }

    func deleteFavorite(id : Int){
        
        managedContext.delete(favorite[id])
        
        print("deleted")
        
        do{
            try managedContext.save()
            
        }catch let error as NSError{
            print(error)
            
        }
    }

}
