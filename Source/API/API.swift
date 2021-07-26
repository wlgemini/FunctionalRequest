//
//  API.swift
//


// MARK: - API
public protocol API {
    
    /// Parameters
    associatedtype P
    
    /// Returns
    associatedtype R
    
    /// Modifier
    associatedtype M: Modifier
    
    /// modifier
    var modifier: Self.M { get }
    
    /// init
    init(modifier: AnyModifier)
}


extension API {
    
    func _modifier<NM>(_ nm: NM) -> Self
    where NM: Modifier {
        Self(modifier: AnyModifier(self.modifier, nm))
    }
}
