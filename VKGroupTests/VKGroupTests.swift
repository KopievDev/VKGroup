//
//  VKGroupTests.swift
//  VKGroupTests
//
//  Created by Ivan Kopiev on 16.07.2022.
//

import XCTest
@testable import VKGroup

class VKGroupTests: XCTestCase {

    var serviceNetwork: API!

    override func setUpWithError() throws {
        try super.setUpWithError()
        serviceNetwork = APIManager()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        serviceNetwork = nil
    }

    func testApiManagerWithRequestGetServices() throws {
        serviceNetwork.getServices { resp in
            XCTAssertNotNil(resp)
            XCTAssertTrue(resp?.isEmpty == false)
        }
    }
    
    func testApiManagerWithRequestGetServicesIsValidResp() throws {
        
        serviceNetwork.getServices { resp in
            XCTAssertEqual(ServiceCell.reuseId, resp?[0][s:.reuse])
            XCTAssertNotNil(resp?[0][d:.data])
        }
    }
}
