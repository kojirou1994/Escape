public extension StringProtocol {

  func shellEscaped(prefix: String = "", alwaysQuote: Bool = false) -> String {
    let needQuote: Bool
    if alwaysQuote {
      needQuote = true
    } else {
      needQuote = !utf8.allSatisfy(\.isShellAllowedCodeUnit)
    }

    var result = prefix
    func quote() {
      if needQuote {
        result += "'"
      }
    }

    quote()

    forEach { char in
      switch char {
      case "'", "\\":
        result += "\\"
      default: break
      }
      result.append(char)
    }

    quote()

    return result
  }

  func pythonEscapedRaw() -> String {
    shellEscaped(prefix: "r", alwaysQuote: true)
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
