//
//  Setting.Session.swift
//  

import Foundation
import Alamofire


extension Setting {
    
    @propertyWrapper
    public struct Session<Value>
    where Value: Settable {
        
        public init(_ keyPath: WritableKeyPath<Store.Session, Value>) {
            self._keyPath = keyPath
        }
        
        public var wrappedValue: Value {
            get { return Store._session[keyPath: self._keyPath] }
            
            nonmutating set {
                guard Store._sessionFinalized == false else {
                    _Log.warning("can not mutating finalized session", location: newValue.location)
                    return
                }
                
                Store._session[keyPath: self._keyPath] = newValue
            }
        }
        
        let _keyPath: WritableKeyPath<Store.Session, Value>
    }
}
