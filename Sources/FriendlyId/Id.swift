//
//  Id.swift
//  
//
//  Created by Kevin Wooten on 8/31/20.
//

import Foundation

public struct Id: Equatable, Hashable, CustomStringConvertible {
  
  public static let null = Id(uuid: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
  
  public var uuid: UUID
  
  public init?(string: String) {
    guard let uuid = FriendlyId.decode(string: string) else {
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
    self.uuid = uuid
  }
  
  public init(uuid: uuid_t) {
    self.uuid = UUID(uuid: uuid)
  }
  
  public var description: String {
    return FriendlyId.encode(uuid: uuid)
  }
  
}


extension Id: Codable {
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    guard let uuid = try decode(string: container.decode(String.self)) else {
      throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid Friendly Id")
    }
    self.init(uuid: uuid)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(FriendlyId.encode(uuid: uuid))
  }
  
}
