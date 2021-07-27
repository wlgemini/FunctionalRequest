//
//  Session.swift
//

import Foundation
import Alamofire


/// typealias `Accessing.Session`
public typealias SharedSession = Accessing.Session


extension Accessing {
    
    /// Accessing Session/Alamofire.Session
    @propertyWrapper
    public final class Session {
        
        public init(file: String = #fileID, line: UInt = #line) {
            self._location = Location(file, line)
        }
        
        public var wrappedValue: Store.Session {
            Store._session
        }
        
        public var projectedValue: Alamofire.Session? {
            if Store._sessionFinalized {
                return Store._sessionRaw
            } else {
                _Log.warning("accessing session, but session hasn't finalized", location: self._location)
                return nil
            }
        }
        
        let _location: Location
    }
}
