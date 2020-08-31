//
//  Base62.swift
//  
//
//  Created by Kevin Wooten on 8/31/20.
//

import Foundation
import BigInt


public enum Base62 {
    
  static let base = BigUInt(62)
  static let digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"


  public static func decode(string: String) -> BigUInt? {
    guard string.allSatisfy({ digits.contains($0) }) else {
      return nil
    }
    
    var result = BigUInt.zero
    
    for digitIndex in 0 ..< string.count {
      let digitChar = string[digits.index(digits.startIndex, offsetBy: string.count - digitIndex - 1)]
      let digit = digits.distance(from: digits.startIndex, to: digits.firstIndex(of: digitChar)!)
      result = result + (BigUInt(digit) * base.power(digitIndex))
    }
    
    return result;
  }


  public static func encode(integer: BigUInt) -> String {
    var integer = integer
    var result = ""
    while (integer > 0) {
      let (quotient, remainder) = integer.quotientAndRemainder(dividingBy: base)
      integer = quotient
      result = String(digits[digits.index(digits.startIndex, offsetBy: Int(remainder))]) + result
    }
    return result.isEmpty ? String(digits[digits.startIndex]) : result
  }
  
}
