//
//  API+Request.swift
//


extension API {
    
    func request(file: String, line: UInt = #line) {
        let ctx = Context(requestLocation: _Location(file, line))
        self.body.apply(to: ctx)
    }
}
