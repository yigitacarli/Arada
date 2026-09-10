import XCTest
@testable import Arada

final class ProtectionStateTests: XCTestCase {
    func testActiveStateReportsActive() {
        XCTAssertTrue(ProtectionState.active(until: Date()).isActive)
    }

    func testNonActiveStatesReportInactive() {
        XCTAssertFalse(ProtectionState.inactive.isActive)
        XCTAssertFalse(ProtectionState.starting.isActive)
        XCTAssertFalse(ProtectionState.stopping.isActive)
        XCTAssertFalse(ProtectionState.failed(message: "test").isActive)
    }
}
