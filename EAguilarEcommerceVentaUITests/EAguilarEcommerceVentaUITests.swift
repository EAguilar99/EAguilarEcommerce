//
//  EAguilarEcommerceVentaUITests.swift
//  EAguilarEcommerceVentaUITests
//
//  Created by MacBookMBA17 on 30/05/23.
//

import XCTest

final class EAguilarEcommerceVentaUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let correo = app.textFields["correo"]
        correo.tap()
        correo.typeText("hola esto es una prueba")

        let contraseña = app.textFields["contraseña"]
        contraseña.tap()
        contraseña.typeText("hola esto es una prueba")
        
//        let btn = app.buttons["Login"]
//        XCTAssertTrue(btn.exists)
//        btn.tap()

//        let btnregistrar = app.buttons["Registrate"]
//        XCTAssert(btnregistrar.exists)
//        btnregistrar.tap()
//
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
