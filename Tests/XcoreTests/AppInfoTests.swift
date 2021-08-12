//
// Xcore
// Copyright © 2019 Xcore
// MIT license, see LICENSE file for details
//

import XCTest
@testable import Xcore

final class AppInfoTests: TestCase {
    func testTraits() {
        let actual = AppInfo.traits

        let expected = [
            "app_version": Bundle.main.versionNumber,
            "app_build_number": Bundle.main.buildNumber,
            "app_bundle_id": Bundle.main.identifier,
            "device_name": Device.current.model.description,
            "device_model": Device.current.model.identifier,
            "device_family": Device.current.model.family,
            "os": Bundle.main.osVersion,
            "locale": Locale.current.identifier
        ]

        XCTAssertEqual(actual, expected)
    }

    func testUserAgent() {
        let osNameVersion = Bundle.main.osVersion
        let deviceModel = Device.current.model.identifier
        XCTAssertEqual(
            AppInfo.userAgent,
            "xctest/13.0 (com.apple.dt.xctest.tool; build:19166.2; \(deviceModel); \(osNameVersion)) en_US"
        )
    }
}