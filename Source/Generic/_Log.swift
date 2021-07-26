//
//  _Log.swift
//  


/// _Log
enum _Log {
    
    static func warning(_ item: @escaping @autoclosure () -> Any, location: @escaping @autoclosure () -> _Location) {
        Swift.assert({
            let str = "🟡 \(_Location.selfModule).\(location()): \(item())"
            print(str)
            return true
        }())
    }
    
    static func error(_ item: @escaping @autoclosure () -> Any, location: @escaping @autoclosure () -> _Location) {
        Swift.assert({
            let str = "🔴 \(_Location.selfModule)\(location()): \(item())"
            print(str)
            return true
        }())
    }
}

