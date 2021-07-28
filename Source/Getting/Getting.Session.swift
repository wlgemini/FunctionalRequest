//
//  Accessing.Session.swift
//

import Foundation
import Alamofire


/// typealias `Accessing.Session`
public typealias Session = Accessing.Session


extension Accessing {
    
    /// Accessing `Alamofire.Session`
    @propertyWrapper
    public final class Session {
        
        /// the `Alamofire.Session` value
        public var session: Alamofire.Session? {
            if Store._sessionFinalized {
                return Store._sessionRaw
            } else {
                _Log.warning("Accessing session, but session hasn't finalized", location: self._location)
                return nil
            }
        }
        
        public init(file: String = #fileID, line: UInt = #line) {
            self._location = Location(file, line)
        }
        
        /// Finalizes the `Setting.Session` state and returns the underlaying session.
        @discardableResult
        public func finalize() -> Alamofire.Session {
            Store._sessionRaw
        }
        
        public var wrappedValue: Store.Session {
            Store._session
        }
        
        public var projectedValue: Accessing.Session {
            self
        }
        
        let _location: Location
    }
}
