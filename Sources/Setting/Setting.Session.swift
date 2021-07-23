//
//  Setting.Session.swift
//  

import Foundation
import Alamofire


extension Setting {
    
    @propertyWrapper
    public struct Session<Value> {
        
        public init(_ keyPath: WritableKeyPath<Store.Session, Value>, file: String = #fileID, line: UInt = #line) {
            self._keyPath = keyPath
            self._location = _Location(file, line)
        }
        
        public var wrappedValue: Value {
            get {
                if Value.self == Alamofire.Session.self, Store._sessionFinalized == false {
                    _Log.warning("accessing session, but session hasn't finalized", location: self._location)
                }
                
                return Store._session[keyPath: self._keyPath]
            }
            
            nonmutating set {
                guard Value.self != Store.Session.self else {
                    _Log.error("can not mutating `Store.Session` itself", location: self._location)
                    return
                }
                
                guard Store._sessionFinalized == false else {
                    _Log.warning("mutating `\(self._keyPath)`, but session has finalized", location: self._location)
                    return
                }
                
                Store._session[keyPath: self._keyPath] = newValue
            }
        }
        
        let _keyPath: WritableKeyPath<Store.Session, Value>
        let _location: _Location
    }
}
