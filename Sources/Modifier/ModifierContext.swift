//
//  ModifierContext.swift
//

public final class ModifierContext<A: API> {
    
    /// api
    public let api: A
    
    /// setting
    public var setting: [String] = []
    
    // MARK: Internal
    /// init
    internal init(api: A) {
        self.api = api
    }
}
