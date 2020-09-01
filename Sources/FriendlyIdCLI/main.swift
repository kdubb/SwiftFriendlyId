//
//  main.swift
//  
//
//  Created by Kevin Wooten on 8/30/20.
//

import Foundation
import BigInt
import ArgumentParser
import FriendlyId

struct FriendlyIdConvert: ParsableCommand {

  @Argument(help: "Id in Base62 or UUID format")
  var inputId: String = ""
  
  mutating func run() throws {
    guard !inputId.isEmpty else {
      print(FriendlyId.generate())
      return
    }
    
    guard let (parsedId, uuidFormatted) = FriendlyId.decode(idOrUUIDString: inputId) else {
      fatalError("Invalid id format (must be in Base62 or UUID format)")
    }
    
    if uuidFormatted {
      print(FriendlyId.encode(uuid: parsedId))
    }
    else {
      print(UUID(uuid: parsedId).uuidString)
    }
  }
}

FriendlyIdConvert.main()
