//
//  BindAPI.swift
//

import Foundation
import Alamofire


/// typealias `Accessing.Binding`
public typealias Binding<A: API> = Accessing.BindAPI<A>


extension Accessing {
    
    /// Accessing API/BindAPI
    @propertyWrapper
    public final class BindAPI<A: API> {
        
        public var isCancelRequestWhenDeinit: Bool = true
        public internal(set) weak var request: Alamofire.DataRequest?
        
        public init(_ api: A, file: String = #fileID, line: UInt = #line) {
            self._api = api
            self._location = Location(file, line)
        }
        
        public var wrappedValue: A {
            self._api._modifier(_InternalModifier.AccessingObject<Alamofire.DataRequest>(onAvailable: { [weak self] req in
                self?.request = req
            }))
        }
        
        public var projectedValue: BindAPI<A> {
            self
        }
        
        deinit {
            if self.isCancelRequestWhenDeinit { self.request?.cancel() }
        }
        
        let _api: A
        let _location: Location
    }   
}
