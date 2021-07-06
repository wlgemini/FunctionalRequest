//
//  ModifiedAPI+Request.swift
//


extension ModifiedAPI {
    
    func request() {
        let ctx = ModifierContext(api: self.api)
        self.modifier.apply(to: ctx)
        print(self.api.path)
        print(ctx.setting)
    }
}
