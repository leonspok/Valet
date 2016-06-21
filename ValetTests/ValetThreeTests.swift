//
//  ValetThreeTests.swift
//  Valet
//
//  Created by Eric Muller on 6/20/16.
//  Copyright © 2016 Square, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Valet
import XCTest


class ValetShimTests: XCTestCase
{
    static let identifier = "valet_testing"
    let valet = Valet(available: .WhenUnlocked, withIdentifier: identifier)
    let key = "key"
    let passcode = "topsecret"

    // MARK: XCTestCase

    override func setUp()
    {
        super.setUp()
        valet.removeAll()
    }

    // MARK: Equality

    func test_valetsWithSameConfiguration_areEqual()
    {
        let otherValet = Valet(available: valet.accessibility, withIdentifier: valet.identifier)
        XCTAssertEqual(valet, otherValet)
    }

    func test_valetsWithDifferingIdentifier_areNotEqual()
    {
        let differingIdentifier = Valet(available: valet.accessibility, withIdentifier: "nope")
        XCTAssertNotEqual(valet, differingIdentifier)
    }

    func test_valetsWithDifferingAccessibility_areNotEqual()
    {
        let differingAccessibility = Valet(available: .Always, withIdentifier: valet.identifier)
        XCTAssertNotEqual(valet, differingAccessibility)
    }

    // MARK: canAccessKeychain

    func test_canAccessKeychain()
    {
        XCTAssertTrue(valet.canAccessKeychain())
    }

    func test_canAccessKeychain_performance()
    {
        measureBlock {
            self.valet.canAccessKeychain()
        }
    }
}