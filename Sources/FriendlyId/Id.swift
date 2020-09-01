//
//  Id.swift
//  
//
//  Created by Kevin Wooten on 8/31/20.
//

import Foundation

public struct Id: Equatable, Hashable, CustomStringConvertible {
  
  public static let null = Id(uuid: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
  
  public var uuid: uuid_t
  
  public init?(string: String) {
    guard let uuid = decode(string: string) else {
      return nil
    }
    self.uuid = uuid
  }
  
  public init(algorithm: GenerationAlgorithm = .random) {
    var uuid = Id.null.uuid
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
    self.uuid = uuid
  }

  public init(uuid: UUID) {
    self.uuid = uuid.uuid
  }
  
  public init(uuid: uuid_t) {
    self.uuid = uuid
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(uuid.0)
    hasher.combine(uuid.1)
    hasher.combine(uuid.2)
    hasher.combine(uuid.3)
    hasher.combine(uuid.4)
    hasher.combine(uuid.5)
    hasher.combine(uuid.6)
    hasher.combine(uuid.7)
    hasher.combine(uuid.8)
    hasher.combine(uuid.9)
    hasher.combine(uuid.10)
    hasher.combine(uuid.11)
    hasher.combine(uuid.12)
    hasher.combine(uuid.13)
    hasher.combine(uuid.14)
    hasher.combine(uuid.15)
  }
  
  public var description: String {
    return encode(uuid: uuid)
  }
  
  public static func == (lhs: Id, rhs: Id) -> Bool {
    return lhs.uuid == rhs.uuid
  }
  
}
