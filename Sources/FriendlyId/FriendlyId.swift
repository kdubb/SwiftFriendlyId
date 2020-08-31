//
//  FriendlyId.swift
//  
//
//  Created by Kevin Wooten on 8/31/20.
//

import Foundation
import BigInt


public func generate() -> String {
  return encode(uuid: UUID())
}

public func encode(uuid: UUID) -> String {
  return Base62.encode(integer: BigUInt(uuid: uuid))
}

public func decode(string: String) -> UUID? {
  return decode(idOrUUIDString: string)?.0
}

public func decode(idOrUUIDString string: String) -> (UUID, Bool)? {
  guard !string.isEmpty else {
    return nil
  }
  
  if string.count > 32 {
    guard let id = UUID(uuidString: string) else {
      return nil
    }
    return (id, true)
  }
  
  guard
    let integer = Base62.decode(string: string),
    integer.bitWidth <= 128
  else {
    return nil
  }
  
  return (integer.uuid, false)
}
