//
//  FriendlyId.swift
//  
//
//  Created by Kevin Wooten on 8/31/20.
//

import Foundation
import BigInt

public enum GenerationAlgorithm {
  case time
  case random
}

public func generate(algorithm: GenerationAlgorithm = .random) -> String {
  var uuid: uuid_t = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  switch algorithm {
  case .random:
    withUnsafeMutableBytes(of: &uuid) {
      uuid_generate_random($0.baseAddress?.assumingMemoryBound(to: UInt8.self))
    }
  case .time:
    withUnsafeMutableBytes(of: &uuid) {
      uuid_generate_time($0.baseAddress?.assumingMemoryBound(to: UInt8.self))
    }
  }
  return encode(uuid: uuid)
}

public func encode(uuid: UUID) -> String {
  return encode(uuid: uuid.uuid)
}

public func encode(uuid: uuid_t) -> String {
  return Base62.encode(integer: BigUInt(uuid: uuid))
}

public func decode(string: String) -> uuid_t? {
  return decode(idOrUUIDString: string)?.0
}

public func decode(idOrUUIDString string: String) -> (uuid_t, Bool)? {
  guard !string.isEmpty else {
    return nil
  }
  
  if string.count > 32 {
    guard let uuid = UUID(uuidString: string)?.uuid else {
      return nil
    }
    return (uuid, true)
  }
  
  guard
    let integer = Base62.decode(string: string),
    integer.bitWidth <= 128
  else {
    return nil
  }
  
  return (integer.uuid, false)
}
