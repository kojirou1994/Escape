import XCTest
import Escape

final class EscapeTests: XCTestCase {
  func testPythonEscape() {
    XCTAssertEqual("123".pythonEscaped(), "'123'")
    XCTAssertEqual("1'2\\3".pythonEscaped(), "'1\\'2\\\\3'")
  }

  func testShellEscaped() {
    XCTAssertEqual("hello".simpleShellEscaped(), "hello")
    XCTAssertEqual("hello$world".simpleShellEscaped(), "'hello$world'")
    XCTAssertEqual("hello world".simpleShellEscaped(), "'hello world'")
  }
}
