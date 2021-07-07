//
//  API+Request.swift
//


extension API {
    
    func request() {
        let ctx = ModifierContext(api: self)
        self.modifiers.apply(to: ctx)
    }
}
