//
//  FakeNtwork.swift
//  SportsTests
//
//  Created by Fatma_Hassan on 31/05/2023.
//

import Foundation
@testable import Sports

class FackNetwork {
    
    var shouldReturnError : Bool
    
    init(shouldReturnError : Bool ) {
        self.shouldReturnError = shouldReturnError
    }
    
    let response : Response = Response(success: 1, result: [League(),League(),League()])
    
    
    enum ResponseWithError : Error{
        case responseError
    }
}

extension FackNetwork : NetworkManagerProtocol {
    func loadDataFromURL<T>(url: String?, complitionHandler: @escaping (T?) -> Void) where T : Decodable {
        if shouldReturnError{
            complitionHandler(nil)
        }else{
            complitionHandler(response as? T)
        }
    }

}
