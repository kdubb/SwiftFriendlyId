//
//  Generator.swift
//  
//
//  Created by Kevin Wooten on 8/31/20.
//

import Foundation
import BigInt
import FriendlyId

enum Gen {

  public struct LongPairs<RNG: RandomNumberGenerator>: IteratorProtocol {
    
    public var random: RNG
    
    public mutating func next() -> (UInt64, UInt64)? {
      (UInt64.random(in: 0 ... UInt64.max, using: &random), UInt64.random(in: 0 ... UInt64.max, using: &random))
    }
    
  }

  public struct UUIDs<RNG: RandomNumberGenerator>: IteratorProtocol {
    
    public var pairs: LongPairs<RNG>
    
    init(random: RNG) {
      pairs = .init(random: random)
    }
    
    public mutating func next() -> uuid_t? {
      guard let (upper, lower) = pairs.next() else { return nil }
      var uuid: uuid_t = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
      withUnsafeMutableBytes(of: &uuid) { uuidPtr in
        uuidPtr.storeBytes(of: upper, toByteOffset: 0, as: UInt64.self)
        uuidPtr.storeBytes(of: lower, toByteOffset: 8, as: UInt64.self)
      }
      return uuid
    }
    
  }
  
  public static func uuids<RNG>(using random: inout RNG) -> IteratorSequence<UUIDs<RNG>> where RNG: RandomNumberGenerator {
    IteratorSequence(UUIDs(random: random))
  }
  
  public struct Ids<RNG: RandomNumberGenerator>: IteratorProtocol {
    
    public var uuids: UUIDs<RNG>
    
    init(random: RNG) {
      uuids = .init(random: random)
    }
    
    public mutating func next() -> String? {
      return uuids.next().flatMap { FriendlyId.encode(uuid: $0) }
    }
  }
  
  public static func ids<RNG>(using random: inout RNG) -> IteratorSequence<Ids<RNG>> where RNG: RandomNumberGenerator {
    IteratorSequence(Ids(random: random))
  }

}
