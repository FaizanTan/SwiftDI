//
//  DependencyRegisterer.swift
//  SwiftDI
//
//  Created by Faizan Tanveer on 18/07/2026.
//

import Foundation

public protocol Registrar {
    func register(in container: DIContainer)
}
