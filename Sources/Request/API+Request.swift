//
//  API+Request.swift
//


extension API {
    
    func request() {
        let ctx = ModifierContext()
        self.body.apply(to: ctx)
    }
}
