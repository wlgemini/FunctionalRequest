//
//  Locatable.swift
//


/// Locatable
public protocol Locatable {
    
    /// file & line
    var location: Location { get }
}


/// Location
public struct Location: CustomStringConvertible {
    
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
    public var description: String {
        let fileName = self.file.split(separator: "/").last?.split(separator: ".").first ?? ""
        return "@\(String(fileName))#\(self.line)"
    }
}
