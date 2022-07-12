import XCTest
import Escape

final class EscapeTests: XCTestCase {
  func testPythonEscape() {
    XCTAssertEqual("123".pythonEscapedRaw(), "r'123'")
    XCTAssertEqual("1'2\\3".pythonEscapedRaw(), "r'1\\'2\\\\3'")
  }

  func testShellEscaped() {
    XCTAssertEqual("123".shellEscaped(alwaysQuote: true), "'123'")
    XCTAssertEqual("123".shellEscaped(alwaysQuote: false), "123")
  }
}
