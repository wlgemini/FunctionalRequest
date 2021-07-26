//
//  Binding.swift
//

import Foundation
import Alamofire


/// Binding
@propertyWrapper
public final class Binding<A: API> {
    
    public var isAutoCancelRequest: Bool = true
    public internal(set) weak var request: Alamofire.DataRequest?
    
    public init(_ api: A, file: String = #fileID, line: UInt = #line) {
        self._api = api
        self._location = _Location(file, line)
    }
    
    public var wrappedValue: A {
        self._api._modifier(_InternalModifier.AccessingObject<Alamofire.DataRequest>(onAvailable: { [weak self] req in
            self?.request = req
        }))
    }
    
    public var projectedValue: Binding<A> {
        self
    }
    
    deinit {
        if self.isAutoCancelRequest { self.request?.cancel() }
    }
    
    let _api: A
    let _location: _Location
}
