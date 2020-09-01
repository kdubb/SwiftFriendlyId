//
//  BigUInts.swift
//  
//
//  Created by Kevin Wooten on 8/31/20.
//

import Foundation
import BigInt


private let half = BigUInt(1) << 64

extension BigUInt {

  internal init(uuid: UUID) {
    self = withUnsafeBytes(of: uuid) { BigUInt($0) }
  }
  
  internal static let zeros = Data(repeating: 0, count: 0)
  
  internal var uuid: UUID {
    // serialize data
    var data = serialize()
    // padded to 128 bits
    while data.count < 16 {
      data.insert(0, at: 0)
    }
    var uuid: uuid_t = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    withUnsafeMutableBytes(of: &uuid) { uuidPtr in
      data.withUnsafeBytes { uuidPtr.copyMemory(from: $0) }
    }
    return UUID(uuid: uuid)
  }

}
