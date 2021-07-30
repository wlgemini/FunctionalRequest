//
//  Setting.API.swift
//  

import Foundation
import Alamofire


extension Setting {
    
    @propertyWrapper
    public struct API<S>
    where S: Settable {
        
        public init(_ keyPath: WritableKeyPath<Store.API, S>) {
            self._keyPath = keyPath
        }
        
        public var wrappedValue: S {
            get {
                Store._api[keyPath: self._keyPath]
            }
            
            nonmutating set {
                _Debug.only {
                    if let locatable = newValue as? _Locatable {
                        let old = Store._api[keyPath: self._keyPath].value
                        let new = newValue.value
                        _Log.trace("mutating `\(S.G.self)` from `\(old)` to `\(new)`", location: locatable._location)
                    }
                }
                
                Store._api[keyPath: self._keyPath] = newValue
            }
        }
        
        let _keyPath: WritableKeyPath<Store.API, S>
    }
}
