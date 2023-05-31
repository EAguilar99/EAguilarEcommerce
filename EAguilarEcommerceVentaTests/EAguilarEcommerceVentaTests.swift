//
//  EAguilarEcommerceVentaTests.swift
//  EAguilarEcommerceVentaTests
//
//  Created by MacBookMBA17 on 30/05/23.
//

import XCTest
@testable import EAguilarEcommerceVenta

final class EAguilarEcommerceVentaTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        let carritoViewModel =  CarritoViewModel()
        
        let result = carritoViewModel.Delete(7)
        
        XCTAssertTrue(result.Correct!)
        //XCTAssertFalse(result.Correct!)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
