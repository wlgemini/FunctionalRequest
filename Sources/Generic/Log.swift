//
//  Log.swift
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


/// _Location
struct _Location: CustomStringConvertible {
    
    /// self module name
    static let selfModule: String = String(#fileID.split(separator: "/").first ?? "")
    
    /// file: #fileID
    let file: String
    
    /// line: #line
    let line: UInt
    
    
    /// init
    /// - Parameters:
    ///   - file: #fileID
    ///   - line: #line
    init(_ file: String, _ line: UInt) {
        self.file = file
        self.line = line
    }
    
    /// description
    ///
    ///     "@ViewController#23"
    ///
    var description: String {
        let fileName = self.file.split(separator: "/").last?.split(separator: ".").first ?? ""
        return "@\(String(fileName))#\(self.line)"
    }
}
