//
//  Log.swift
//

enum Log {
    
    static func trace(_ item: Any, file: StaticString = #fileID, line: UInt = #line) {
        print("""
        🟢 @\(file)#\(line): \(item)
        """)
    }
    
    static func warning(_ item: Any, file: StaticString = #fileID, line: UInt = #line) {
        print("""
        🟡 @\(file)#\(line): \(item)
        """)
    }
    
    static func error(_ item: Any, file: StaticString = #fileID, line: UInt = #line) {
        print("""
        🔴 @\(file)#\(line): \(item)
        """)
    }
}
