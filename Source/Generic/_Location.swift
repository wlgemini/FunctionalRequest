//
//  _Location.swift
//


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
