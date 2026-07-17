//
//  Inject.swift
//  SwiftDI
//
//  Created by Faizan Tanveer on 18/07/2026.
//

import Foundation

@propertyWrapper
struct Inject<T> {

    private let resolver: () -> T

    public init() {
        resolver = {
            DIContainer.shared.resolve()
        }
    }

    public init<Q: Qualifier>(_ qualifier: Q) {
        resolver = {
            DIContainer.shared.resolve(
                qualifier: qualifier
            )
        }
    }

    public var wrappedValue: T {
        resolver()
    }
}
