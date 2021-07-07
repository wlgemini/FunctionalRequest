//
//  ModifierContext.swift
//

public final class ModifierContext {
    
    /// method
    public let method: String
    
    /// path
    public let path: String
    
    /// setting
    public var setting: [String] = []
    
    // MARK: Internal
    /// init
    internal init<A: API>(api: A) {
        self.method = api.method
        self.path = api.path
    }
}
