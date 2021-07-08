//
//  API+Request.swift
//


extension API {
    
    func request() {
        let ctx = Context()
        self.body.apply(to: ctx)
    }
}
