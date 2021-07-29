//
//  Setting.Session.swift
//  

import Foundation
import Alamofire


extension Setting {
    
    @propertyWrapper
    public struct Session<S>
    where S: Settable {
        
        public init(_ keyPath: WritableKeyPath<Store.Session, S>) {
            self._keyPath = keyPath
        }
        
        public var wrappedValue: S {
            get {
                Store._session[keyPath: self._keyPath]
            }
            
            nonmutating set {
                guard Store._sessionFinalized == false else {
                    if let locatable = newValue as? _Locatable {
                        _Log.warning("can not mutating finalized session", location: locatable._location)
                    } else {
                        _Log.warning("can not mutating finalized session", location: .nowhere)
                    }
                    return
                }
                
                Store._session[keyPath: self._keyPath] = newValue
            }
        }
        
        let _keyPath: WritableKeyPath<Store.Session, S>
    }
}
