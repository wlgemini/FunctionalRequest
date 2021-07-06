//
//  Modifiers.swift
//


public struct BaseModifier: Modifier {

    let base: String

    public func apply<A: API>(to context: ModifierContext<A>) {
        context.setting.append(self.base.description)
    }
}


public struct HeadersModifier: Modifier {

    let headers: [String: Any]

    public func apply<A: API>(to context: ModifierContext<A>) {
        context.setting.append(self.headers.description)
    }
}


