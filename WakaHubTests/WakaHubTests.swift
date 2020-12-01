//
//  WakaHubTests.swift
//  WakaHubTests
//
//  Created by Oskar Figiel on 19/11/2020.
//

import XCTest
@testable import WakaHub

class WakaHubTests: XCTestCase {

    func testDateFormatterValid() {
        let notFormattedDate = "2019-03-19T00:59:22Z"

        XCTAssertEqual(notFormattedDate.formatDateWithMonthName(), "Mar 19 2019")
    }

    func testDateFormatterInvalid() {
        let notFormattedDate = "2019-03-19T00:59:22Z"

        XCTAssertNotEqual(notFormattedDate.formatDateWithMonthName(), "19-03-2019")
    }

}
