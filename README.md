(Swift)FriendlyId
==
## Inspired and compatible with [FriendlyID](https://github.com/Devskiller/friendly-id)  


What is the FriendlyId library?
--
The FriendlyId library converts a given UUID (with 36 characters) to a URL-friendly ID (a "FriendlyId") which is based on Base62 (with a maximum of 22 characters), as in the example below:


    UUID                                        Friendly ID

    c3587ec5-0976-497f-8374-61e0c2ea3da5   ->   5wbwf6yUxVBcr48AMbz9cb
    |                                           |                              
    36 characters                               22 characters or less

In addition, this library allows to:


* convert from a FriendlyId back to the original UUID; and
* create a new, random FriendlyId

Why use a FriendlyId?
--
Universal Unique IDs (UUIDs) provide a non-sequential and unique identifier that can be generated separately from the source database. As a result, it is not possible to guess either the previous or next identifier. That's great, but, to achieve this level of security, a UUID is long (128 bits long) and looks ugly (36 alphanumeric characters including four hyphens which are added to make it easier to read the UUID), as in this example: `123e4567-e89b-12d3-a456-426655440000`.

Such a format is:

* difficult to read (especially if it is part of a URL)
* difficult to remember
* cannot be copied with just two mouse-clicks (you have to select manually the start and end positions)
* can easily become broken across lines when it is copied, pasted, edited, or sent.

(Swift)FriendlyId library solves these problems by converting a given UUID using Base62 with alphanumeric characters in the range [0-9A-Za-z] into a FriendlyId which consists of a maximum of 22 characters (but in fact often contains fewer characters).

Usage
---

Command Line
---
The Swift package contains a command line for generating and converting to & from UUID format.

Generate a new id (from a random v4 UUID)
```bash
$ friendly-id
```

Convert a UUID into a "FriendlyId"
```bash
$ friendly-id 921bcf08-1279-4e0a-9e0d-e5a1103c5def 
```

Convert a FriendlyId into a UUID
```bash
$ friendly-id 4RhaTeTKMOdHxagaj2XAcR 
```


Swift Package
----
FriendlyId can also be integrated into your Swift projects using Swift Package Manager.

Swift Package Manager dependency
```swift
.package(url: "https://github.com/kdubb/SwiftFriendlyId.git", .upToNextMinor(from: "1.0.0")),
```

Generate a FriendlyId
```swift
let id = Id(algorithm: .random)
```

Convert UUID to FriendlyId
```swift
let id = Id(uuid: UUID(uuidString: "921bcf08-1279-4e0a-9e0d-e5a1103c5def")!)
```

Convert FriendlyId (or UUID) formatted string to UUID
```swift
let id = Id(string: "4RhaTeTKMOdHxagaj2XAcR")!
let id = Id(string: "921bcf08-1279-4e0a-9e0d-e5a1103c5def")!
```
