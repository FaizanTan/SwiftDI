//
//  ServiceKey.swift
//  SwiftDI
//
//  Created by Faizan Tanveer on 18/07/2026.
//

import Foundation

public struct ServiceKey: Hashable {

    let type: ObjectIdentifier
    let qualifier: String?

    init<T>(
        _ type: T.Type,
        qualifier: String? = nil
    ) {
        self.type = ObjectIdentifier(type)
        self.qualifier = qualifier
    }
}
