public extension StringProtocol {

  func escaped(quoter: Character, escapeMap: [Character: String], alwaysQuote: Bool) -> String {
    assert(["'", "\""].contains(quoter))

    var result = ""

    forEach { char in
      if let string = escapeMap[char] {
        result.append(string)
        return
      }
      result.append(char)
    }

    let needQuote: Bool
    if alwaysQuote {
      needQuote = true
    } else {
      needQuote = result != self
    }

    if needQuote {
      result.insert(quoter, at: result.startIndex)
      result.append(quoter)
    }

    return result
  }

  func simpleShellEscaped() -> String {
    escaped(quoter: "'", escapeMap: [
      "'": "'\\''"
    ], alwaysQuote: utf8.contains{ !$0.isShellAllowedCodeUnit })
  }

  func pythonEscaped() -> String {
    escaped(quoter: "'", escapeMap: [
      // ref: https://www.w3schools.com/python/gloss_python_escape_characters.asp
      "'": "\\'",
      "\\": "\\\\",
      "\n": "\\n",
      "\r": "\\r",
      "\t": "\\t",
    ], alwaysQuote: true)
  }

}

extension UInt8 {
  fileprivate var isShellAllowedCodeUnit: Bool {
    switch self {
    case UInt8(ascii: "a")...UInt8(ascii: "z"),
      UInt8(ascii: "A")...UInt8(ascii: "Z"),
      UInt8(ascii: "0")...UInt8(ascii: "9"),
      UInt8(ascii: "-"),
      UInt8(ascii: "_"),
      UInt8(ascii: "/"),
      UInt8(ascii: ":"),
      UInt8(ascii: "@"),
      UInt8(ascii: "%"),
      UInt8(ascii: "+"),
      UInt8(ascii: "="),
      UInt8(ascii: "."),
      UInt8(ascii: ","):
      return true
    default:
      return false
    }
  }
}
