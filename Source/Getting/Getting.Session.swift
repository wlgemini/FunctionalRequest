//
//  Getting.Session.swift
//

import Foundation
import Alamofire


extension Getting {
    
    @propertyWrapper
    public struct Session<G>
    where G: Gettable {
        
        public init(_ keyPath: KeyPath<Store.Session, G>, file: String = #fileID) {
            self._keyPath = keyPath
            self._location = _Location(file, nil)
        }
        
        public var wrappedValue: G.G {
            Store._session[keyPath: self._keyPath].value
        }
        
        public var projectedValue: Getting.Session<G> {
            self
        }
        
        let _keyPath: KeyPath<Store.Session, G>
        let _location: _Location
    }
}


extension Getting.Session {
    
    /// Is session finalized
    public var isFinalized: Bool {
        Store._sessionFinalized
    }
    
    /// The underlaying session value. nil when session hasn't finalized.
    public var session: Alamofire.Session? {
        if Store._sessionFinalized {
            return Store._sessionRaw
        } else {
            _Log.warning("Getting session, but session hasn't finalized", location: self._location)
            return nil
        }
    }
    
    /// Finalizes the `Setting.Session` state and returns the underlaying session.
    @discardableResult
    public func finalize() -> Alamofire.Session {
        Store._sessionRaw
    }
}


extension Getting.Session {
    
    public static var never: Getting.Session<Setter.Copy.Nillable<Never>> {
        .init(\.never)
    }
}
