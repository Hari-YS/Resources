
import XCTest
@testable import NetworkingKit

final class NetworkingKitTests: XCTestCase {
    func testInvalidURL() async {
        let service = NetworkingService()
        await XCTAssertThrowsErrorAsync(try await service.request(url: "not a url", method: .get, body: nil, headers: nil) as String) { error in
            XCTAssertEqual(error as? NetworkingError, .invalidURL)
        }
    }
}

// Helper for async throws test
func XCTAssertThrowsErrorAsync<T>(
    _ expression: @autoclosure @escaping () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line,
    _ errorHandler: (Error) -> Void = { _ in }) async {
    do {
        _ = try await expression()
        XCTFail("Expected error", file: file, line: line)
    } catch {
        errorHandler(error)
    }
}
