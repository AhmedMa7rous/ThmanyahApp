//
//  NetworkServiceTests.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import XCTest
@testable import ThmanyahApp

class NetworkServiceTests: XCTestCase {
    var sut: NetworkService!
    
    override func setUp() {
        super.setUp()
        sut = NetworkService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testAPIEndpointURLs() {
        // Test home sections endpoint
        let homeSectionsURL = APIEndpoint.homeSections(page: 1).url
        XCTAssertEqual(homeSectionsURL.host, "api-v2-b2sit6oh3a-uc.a.run.app")
        XCTAssertTrue(homeSectionsURL.absoluteString.contains("page=1"))
        
        // Test search endpoint
        let searchURL = APIEndpoint.search(query: "tes", page: 1).url
        XCTAssertTrue(searchURL.absoluteString.contains("search"))
        XCTAssertFalse(searchURL.absoluteString.contains("q=test"))
        XCTAssertTrue(searchURL.absoluteString.contains("page=1"))
    }
    
    func testNetworkErrorEquality() {
        XCTAssertEqual(NetworkError.invalidURL, NetworkError.invalidURL)
        XCTAssertEqual(NetworkError.timeout, NetworkError.timeout)
        XCTAssertEqual(NetworkError.serverError(500), NetworkError.serverError(500))
        XCTAssertNotEqual(NetworkError.serverError(500), NetworkError.serverError(404))
    }
}
