//
//  Injection.swift
//
//
//  Created by Jonathan Pacheco on 11/10/22.
//

public typealias FactoryClosure = (Container) -> Any

public protocol InjectKey: RawRepresentable where RawValue == String {}

public enum Key: String, InjectKey {
    case none
}

public protocol Registrable {
    
    func register(with container: Container)
}


@propertyWrapper
public final class Inject<T> {
    
    private let `default`: T?
    private var value: T?
    private let key: any InjectKey
    
    public init(key: any InjectKey = Key.none) {
        self.default = nil
        self.key = key
    }
    
    public init<Type>(wrappedValue: T?, keyPath: KeyPath<Type, T>, key: any InjectKey = Key.none) {
        self.default = wrappedValue
        self.key = key
        if let value = Container.default.resolve(type: Type.self, key: key) {
            self.value = value[keyPath: keyPath]
        }
    }
    
    public init(wrappedValue: T?, key: any InjectKey = Key.none) {
        self.default = wrappedValue
        self.key = key
    }
    
    public var wrappedValue: T? {
        get {
            if let value {
                return value
            }
            let value = Container.default.resolve(type: T.self, key: key) ?? `default`
            self.value = value
            return value
        }
        set {
            self.value = newValue
        }
    }
    
    public var projectedValue: Inject<T> { return self }
}


public final class Container {
    
    public static let `default` = Container()
    private var services: [String: FactoryClosure] = [:]
    
    private init() {}
    
    public func register<Service>(type: Service.Type, key: any InjectKey = Key.none, value: @escaping @autoclosure () -> Any) {
        services["\(type)\(key.rawValue)"] = { _ in value() }
    }
    
    public func register<Service>(type: Service.Type, key: any InjectKey = Key.none, factoryClosure: @escaping FactoryClosure) {
        services["\(type)\(key.rawValue)"] = factoryClosure
    }
    
    public func resolve<Service>(type: Service.Type, key: any InjectKey = Key.none) -> Service? {
        let type = normalize(key: "\(type)")
        return services["\(type)\(key.rawValue)"]?(self) as? Service
    }
    
    public func unregister<Service>(type: Service.Type, key: any InjectKey = Key.none) {
        services["\(type)\(key.rawValue)"] = nil
    }
    
    public static func register(registrables: Registrable...) {
        register(registrables: registrables)
    }
    
    public static func register(registrables: [Registrable]) {
        registrables.forEach { $0.register(with: `default`) }
    }
    
    private func normalize(key: String) -> String {
        if key.starts(with: "Optional<") {
            return String(key["Optional<".endIndex..<key.index(key.endIndex, offsetBy: -1)])
        }
        return key
    }
}
