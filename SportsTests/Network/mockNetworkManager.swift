//
//  mockNetworkManager.swift
//  SportsTests
//
//  Created by Fatma_Hassan on 31/05/2023.
//

import XCTest
@testable import Sports

final class mockNetworkManager: XCTestCase {

    var fackNetwork : FackNetwork?
    
    override func setUpWithError() throws {
        fackNetwork = FackNetwork(shouldReturnError: false)
    }

    override func tearDownWithError() throws {
        fackNetwork = nil
    }
    
    func testFakeNetwork(){
        fackNetwork?.loadDataFromURL(url: "", complitionHandler: { (leagues : Response!) in
        
            if leagues == nil {
                XCTFail()
            }else{
                XCTAssertNotNil(leagues)
            }
        })
    }
    

}
