//
//  MoviesApiClientTests.swift
//  OMDBUITests
//
//  Created by Mahesh Sherkar on 19/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import XCTest
@testable import OMDB;

class MoviesApiClientTests: XCTestCase {
    
    var client: MoviesApiClient!


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
                client = MoviesApiClient(session: URLSession.shared)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMoviesApi() {
        let exp = expectation(description: "Movies Api")
           client.executeFetchMoviesListRequest(search: "cyber", completion: { (result) in
               exp.fulfill()
               switch result {
               case .success(let userResponse):
                XCTAssertEqual(userResponse.response , "True")
               case .failure(let error):
                   XCTFail("Error while Fetching movies test: \(error)")
               }
           });
           waitForExpectations(timeout: 100.0, handler: nil)
    }
    
    
    func testMoviesApiFailedCase() {
        let exp = expectation(description: "Movies Api")
           client.executeFetchMoviesListRequest(search: "m", completion: { (result) in
               exp.fulfill()
               switch result {
               case .success(let userResponse):
                XCTAssertEqual(userResponse.response , "False")
               case .failure(let error):
                   XCTFail("Error while Fetching movies test: \(error)")
               }
           });
           waitForExpectations(timeout: 100.0, handler: nil)
    }

}
