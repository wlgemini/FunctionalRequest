//
//  Setter.swift
//


/// for Setter type
public protocol Settable: Locatable {
    
    associatedtype V
    
    var value: V { mutating get }
}


/// Setter
public enum Setter {
    
    /// for copy value
    public enum Copy { }
    
    /// for compute value
    public enum Compute { }
    
    /// for lazy value
    public enum Lazy { }
}


extension Setter.Copy {
    
    /// Nillable
    public struct Nillable<T>: Settable {
        
        public typealias V = T?
        
        public private(set) var location: Location
        
        public var value: T? {
            self._value
        }
        
        public mutating func callAsFunction(_ value: T?, file: String = #fileID, line: UInt = #line) {
            self._value = value
            self.location = Location(file, line)
        }
        
        init() {
            self._value = nil
            self.location = Location(nil, nil)
        }
        
        var _value: T?
    }
    
    
    /// Nonnil
    public struct Nonnil<T>: Settable {
        
        public typealias V = T
        
        public private(set) var location: Location
        
        public var value: T {
            self._value
        }
        
        public mutating func callAsFunction(_ value: T, file: String = #fileID, line: UInt = #line) {
            self._value = value
            self.location = Location(file, line)
        }
        
        init(_ value: T) {
            self._value = value
            self.location = Location(nil, nil)
        }
        
        var _value: T
    }
}


extension Setter.Compute {
    
    /// Nillable
    public struct Nillable<T>: Settable {
        
        public typealias V = T?
        
        public private(set) var location: Location
        
        public var value: T? {
            self._value()
        }
        
        public mutating func callAsFunction(_ value: @escaping @autoclosure Compute<T?>, file: String = #fileID, line: UInt = #line) {
            self._value = value
            self.location = Location(file, line)
        }
        
        init() {
            self._value = { nil }
            self.location = Location(nil, nil)
        }
        
        var _value: Compute<T?>
    }
    
    
    /// Nonnil
    public struct Nonnil<T>: Settable {
        
        public typealias V = T
        
        public private(set) var location: Location
        
        public var value: T {
            self._value()
        }
        
        public mutating func callAsFunction(_ value: @escaping @autoclosure Compute<T>, file: String = #fileID, line: UInt = #line) {
            self._value = value
            self.location = Location(file, line)
        }
        
        init(_ value: @escaping @autoclosure Compute<T>) {
            self._value = value
            self.location = Location(nil, nil)
        }
        
        var _value: Compute<T>
    }
}


extension Setter.Lazy {
    
    /// Nillable
    public struct Nillable<T>: Settable {
        
        public typealias V = T?
        
        public private(set) var location: Location
        
        public var value: T? {
            mutating get { self._value.finalize() }
        }
        
        public mutating func callAsFunction(_ value: @escaping @autoclosure Compute<T?>, file: String = #fileID, line: UInt = #line) {
            self._value = .unset(initializer: value)
            self.location = Location(file, line)
        }
        
        init() {
            self._value = .unset(initializer: { nil })
            self.location = Location(nil, nil)
        }
        
        var _value: _Lazy<T?>
    }
    
    /// Nonnil
    public struct Nonnil<T>: Settable {
        
        public typealias V = T
        
        public private(set) var location: Location
        
        public var value: T {
            mutating get { self._value.finalize() }
        }
        
        public mutating func callAsFunction(_ value: @escaping @autoclosure Compute<T>, file: String = #fileID, line: UInt = #line) {
            self._value = .unset(initializer: value)
            self.location = Location(file, line)
        }
        
        init(_ value: @escaping @autoclosure Compute<T>) {
            self._value = .unset(initializer: value)
            self.location = Location(nil, nil)
        }
        
        var _value: _Lazy<T>
    }
}
