//
//  _Log.swift
//  


/// _Log
enum _Log {
    
    static func warning(_ item: @escaping @autoclosure () -> Any, location: Location) {
        Swift.assert({
            let str = "🟡 <\(Location.selfModule)>\(location): \(item())"
            print(str)
            return true
        }())
    }
    
    static func error(_ item: @escaping @autoclosure () -> Any, location: Location) {
        Swift.assert({
            let str = "🔴 <\(Location.selfModule)>\(location): \(item())"
            print(str)
            return true
        }())
    }
}

