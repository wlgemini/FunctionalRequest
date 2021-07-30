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
                    _Debug.only {
                        if let locatable = newValue as? _Locatable {
                            _Log.warning("can not mutating finalized session", location: locatable._location)
                        } else {
                            _Log.warning("can not mutating finalized session", location: .nowhere)
                        }
                    }
                    return
                }
                
                _Debug.only {
                    if let locatable = newValue as? _Locatable {
                        let old = Store._session[keyPath: self._keyPath].value
                        let new = newValue.value
                        _Log.trace("mutating `\(S.G.self)` from `\(old)` to `\(new)`", location: locatable._location)
                    }
                }
                
                Store._session[keyPath: self._keyPath] = newValue
            }
        }
        
        let _keyPath: WritableKeyPath<Store.Session, S>
    }
}
