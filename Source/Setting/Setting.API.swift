//
//  Setting.API.swift
//  

import Foundation
import Alamofire


extension Setting {
    
    @propertyWrapper
    public struct API<Value>
    where Value: Settable {
        
        public init(_ keyPath: WritableKeyPath<Store.API, Value>) {
            self._keyPath = keyPath
        }
        
        public var wrappedValue: Value {
            get { Store._api[keyPath: self._keyPath] }
            
            nonmutating set {
                Store._api[keyPath: self._keyPath] = newValue
            }
        }
        
        let _keyPath: WritableKeyPath<Store.API, Value>
    }
}
