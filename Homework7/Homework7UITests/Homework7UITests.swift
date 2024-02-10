//
//  Homework7UITests.swift
//  Homework7UITests
//
//  Created by Максим Бобков on 10.02.2024.
//

import XCTest

final class Homework7UITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testTabClick() {
        
    }
}
