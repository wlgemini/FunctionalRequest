//
//  Log.swift
//


/// _Log
enum _Log {
    
    static func warning(_ item: Any, location: _Location) {
        Swift.assert({
            let str = "🟡 \(_Location.selfModule).\(location): \(item)"
            print(str)
            return true
        }())
    }
    
    static func error(_ item: Any, location: _Location) {
        Swift.assert({
            let str = "🔴 \(_Location.selfModule).\(location): \(item)"
            print(str)
            return true
        }())
    }
}


/// _Location
struct _Location: CustomStringConvertible {
    
    /// self module name
    static let selfModule: String = String(#fileID.split(separator: "/").first ?? "")
    
    /// file
    let file: String
    
    /// line
    let line: UInt
    
    /// init
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
