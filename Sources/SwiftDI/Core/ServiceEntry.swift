//
//  ServiceEntry.swift
//  SwiftDI
//
//  Created by Faizan Tanveer on 18/07/2026.
//

import Foundation

public final class ServiceEntry {

    let scope: Scope
    let factory: () -> Any

    var instance: Any?

    init(
        scope: Scope,
        factory: @escaping () -> Any
    ) {
        self.scope = scope
        self.factory = factory
    }
}
