//
//  CheckNetwork.swift
//  Sports
//
//  Created by Fatma_Hassan on 21/05/2023.
//

import Foundation
import Reachability

class CheckNetwork{
    
    
    static func checkNetwork(compilitationHandler : @escaping (Bool?) -> Void ){
        
        var reachability : Reachability
        
        do{
            reachability = try Reachability()
            
            if reachability.connection != .unavailable{
                compilitationHandler(true)
            }else{
                compilitationHandler(false)
            }
            
            reachability.whenReachable = { reachability in
                compilitationHandler(true)
            }
            
            reachability.whenUnreachable = { reachability in
                compilitationHandler(false)
            }
            
            do {
                try reachability.startNotifier()
            }catch{
                print("Unable to start notifier")
            }
            
            reachability.stopNotifier()
        }catch let error{
            print(error)
        }
    }
}
