//
//  Modifiers.swift
//

// MARK: - URL Modifier
/*
 * http     :// www.example.com:80  /   path/to/file.html   ?   key1=value1&key2=value2 #   SomewhereInTheDocument
 *
 * scheme   :// authority           /   path                ?   parameters              #   anchor
 */


/// scheme
public struct SchemeModifier: Modifier {

    let scheme: String

    public func apply<A: API>(to context: ModifierContext<A>) {
        
    }
}

/// authority
public struct AuthorityModifier: Modifier {

    let domain: String
    let port: Int?

    public func apply<A: API>(to context: ModifierContext<A>) {
        
    }
}

/// path
public struct _PathModifier: Modifier {

    let path: String

    public func apply<A: API>(to context: ModifierContext<A>) {
        
    }
}

/// parameters
public struct ParametersModifier: Modifier {

    let parameters: [String: Any]

    public func apply<A: API>(to context: ModifierContext<A>) {
        
    }
}

/// anchor
public struct AnchorModifier: Modifier {

    let anchor: String

    public func apply<A: API>(to context: ModifierContext<A>) {
        
    }
}

// MARK: - HTTP Modifier
/// method
public struct MethodModifier: Modifier {

    let method: String

    public func apply<A: API>(to context: ModifierContext<A>) {
        
    }
}



