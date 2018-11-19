//
//  BoomAppMobileTests.swift
//  BoomAppMobileTests
//
//  Created by Katelyn on 11/5/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import XCTest
@testable import BoomAppMobile

class BoomAppMobileTests: XCTestCase {

    func testAPI() {
        let expectation = self.expectation(description: "Getting Tournaments")
        let apiConnect = APIConnect()
        
        apiConnect.getTournaments { (dataString) in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

}
