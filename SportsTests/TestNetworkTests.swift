//
//  TestNetworkTests.swift
//  SportsTests
//
//  Created by Fatma_Hassan on 31/05/2023.
//

import XCTest
@testable import Sports

final class TestNetworkTests: XCTestCase {

    var network : NetworkManage?
    
    override func setUpWithError() throws {
        
        network = NetworkManage()
    }

    override func tearDownWithError() throws {
        network = nil
    }

    func testLoadDataFromURLwithURL(){
        
        let expectation = expectation(description: "Waiting for API")

        network?.loadDataFromURL(url: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=aa502a5e593da9a0ccea18734e2ece289b05d81e9cb6ed521d7d9306da9888ce", complitionHandler: { (leagues : Response!) in
            
            if leagues == nil {
                XCTFail()
            }else{
                XCTAssert(leagues?.success == 1)
                expectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 5)
        
    }

}
