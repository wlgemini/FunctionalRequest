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
                Store._api[keyPath: self._keyPath] = newValue
            }
        }
        
        let _keyPath: WritableKeyPath<Store.API, S>
    }
}
