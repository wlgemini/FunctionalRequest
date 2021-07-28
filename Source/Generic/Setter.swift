//
//  Setter.swift
//


/// for Setter type
public protocol Settable: Locatable { }


/// Setter
public enum Setter {
    
    /// for value copy
    public enum Copy { }
    
    /// for @autoclosure
    public enum AutoClosure { }
}


extension Setter.Copy {
    
    /// Nillable
    public struct Nillable<T>: Settable {
        
        public private(set) var location: Location
        
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
        
        public private(set) var location: Location
        
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


extension Setter.AutoClosure {
    
    /// Nillable
    public struct Nillable<T>: Settable {
        
        public private(set) var location: Location
        
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
        
        public private(set) var location: Location
        
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
