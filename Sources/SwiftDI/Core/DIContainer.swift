//
//  DIContainer.swift
//  SwiftDI
//
//  Created by Faizan Tanveer.
//

import Foundation

public final class DIContainer: Resolver, @unchecked Sendable {

    // MARK: - Singleton

    public static let shared = DIContainer()

    // MARK: - Properties

    private let lock = NSLock()
    private var services: [ServiceKey: ServiceEntry] = [:]

    // MARK: - Initialization

    private init() {}

    // MARK: - Registration

    public func register<T>(
        _ type: T.Type,
        scope: Scope = .transient,
        factory: @escaping () -> T
    ) {
        register(
            type,
            qualifier: nil,
            scope: scope,
            factory: factory
        )
    }

    public func register<T, Q: Qualifier>(
        _ type: T.Type,
        qualifier: Q,
        scope: Scope = .transient,
        factory: @escaping () -> T
    ) {
        register(
            type,
            qualifier: qualifier.rawValue,
            scope: scope,
            factory: factory
        )
    }

    private func register<T>(
        _ type: T.Type,
        qualifier: String?,
        scope: Scope,
        factory: @escaping () -> T
    ) {

        let key = ServiceKey(
            type,
            qualifier: qualifier
        )

        lock.lock()
        defer { lock.unlock() }

        precondition(
            services[key] == nil,
            """
            Service already registered.

            Type: \(type)
            Qualifier: \(qualifier ?? "none")
            """
        )

        services[key] = ServiceEntry(
            scope: scope,
            factory: factory
        )
    }

    // MARK: - Resolution

    public func resolve<T>(
        _ type: T.Type = T.self
    ) -> T {

        resolveInternal(
            type,
            qualifier: nil
        )
    }

    public func resolve<T, Q: Qualifier>(
        _ type: T.Type = T.self,
        qualifier: Q
    ) -> T {

        resolveInternal(
            type,
            qualifier: qualifier.rawValue
        )
    }

    private func resolveInternal<T>(
        _ type: T.Type,
        qualifier: String?
    ) -> T {

        let key = ServiceKey(type, qualifier: qualifier)

        lock.lock()
        defer { lock.unlock() }

        guard let entry = services[key] else {
            fatalError("No registration found for \(type)")
        }

        switch entry.scope {

        case .singleton:
            if let instance = entry.instance as? T {
                return instance
            }

            let instance = entry.factory() as! T
            entry.instance = instance
            return instance

        case .transient:
            return entry.factory() as! T
        }
    }

    // MARK: - Utilities

    public func unregister<T>(
        _ type: T.Type,
        qualifier: String? = nil
    ) {

        lock.lock()
        defer { lock.unlock() }

        services.removeValue(
            forKey: ServiceKey(
                type,
                qualifier: qualifier
            )
        )
    }

    public func removeAll() {

        lock.lock()
        defer { lock.unlock() }

        services.removeAll()
    }

    public func isRegistered<T>(
        _ type: T.Type,
        qualifier: String? = nil
    ) -> Bool {

        lock.lock()
        defer { lock.unlock() }

        let key = ServiceKey(
            type,
            qualifier: qualifier
        )

        return services[key] != nil
    }
}
