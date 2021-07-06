//
//  ModifierContext.swift
//

public final class ModifierContext<A: API> {
    public let api: A
    public var setting: [String] = []
    
    internal init(api: A) {
        self.api = api
    }
}
