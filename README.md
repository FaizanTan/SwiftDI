# SwiftDI

A lightweight dependency injection framework inspired by Java Spring Boot.

## Features

- ✅ Singleton
- ✅ Transient
- ✅ Property Injection
- ✅ Qualifiers
- ✅ Type-safe registration
- ✅ Zero dependencies

## Installation

Swift Package Manager...

## Example

```swift
container.register(Database.self) {
    SQLiteDatabase()
}

@Inject
private var database: Database
