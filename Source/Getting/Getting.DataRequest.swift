//
//  Accessing.DataRequest.swift
//

import Foundation
import Alamofire


/// typealias `Accessing.DataRequest`
public typealias DataRequest<A: API> = Accessing.DataRequest<A>


extension Accessing {
    
    /// Accessing `Alamofire.DataRequest`
    @propertyWrapper
    public final class DataRequest<A: API> {
        
        /// Determine whether or not cancel to the underlaying request when self deinit
        public var isCancelRequestWhenDeinit: Bool = true
        
        /// The underlaying request of current API
        public internal(set) weak var request: Alamofire.DataRequest?
        
        /// Init
        /// - Parameters:
        ///   - api: some API
        public init(_ api: A, file: String = #fileID, line: UInt = #line) {
            self._api = api
            self._location = Location(file, line)
        }
        
        public var wrappedValue: A {
            self._modifiedAPI
        }
        
        public var projectedValue: Accessing.DataRequest<A> {
            self
        }
        
        let _api: A
        let _location: Location
        lazy var _modifiedAPI = self._api._modifier(_InternalModifier.AccessingRequest(onRequestAvailable: { [weak self] request in
            self?.request = request as? Alamofire.DataRequest
        }))
        
        deinit {
            if self.isCancelRequestWhenDeinit {
                _Log.trace("Auto cancelling request when deinit", location: self._location)
                self.request?.cancel()
            }
        }
    }   
}
