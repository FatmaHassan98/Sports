//
//  TestFavoriteViewModel.swift
//  SportsTests
//
//  Created by Fatma_Hassan on 31/05/2023.
//

import XCTest
@testable import Sports

final class TestFavoriteViewModel: XCTestCase {

    var fackLocal : FackLocal?
    
    override func setUpWithError() throws {
        fackLocal = FackLocal()
    }

    override func tearDownWithError() throws {
        fackLocal = nil
    }

    func testGetFavoerite(){
        var favorite = FavoriteSport(name: "football", image: "football", leaguesId: 1, sportNumber: 0)
        
        fackLocal?.insert(favorite: favorite)
        
        let array = fackLocal?.getFavorite()
        
        XCTAssertNotNil(array)
    }
    
    func testDeleteFavorite(){
        let favorite = FavoriteSport(name: "football", image: "football", leaguesId: 1, sportNumber: 0)
        
        fackLocal?.insert(favorite: favorite)
        
        let favorite2 = FavoriteSport(name: "football", image: "football", leaguesId: 1, sportNumber: 0)
        
        fackLocal?.insert(favorite: favorite2)

        fackLocal?.deleteFavorite(id: 1)
        
        let array = fackLocal?.getFavorite()
        
        XCTAssert(array?.count == 1)
    }

}
