//
//  Resolver.swift
//  SwiftDI
//
//  Created by Faizan Tanveer on 18/07/2026.
//

import Foundation

public protocol Resolver {
    func resolve<T>(_ type: T.Type) -> T
}
