//
//  Setting.API.swift
//  

import Foundation
import Alamofire


extension Setting {
    
    @propertyWrapper
    public struct API<Value> {
        
        public init(_ keyPath: WritableKeyPath<Store.API, Value>, file: String = #fileID, line: UInt = #line) {
            self._keyPath = keyPath
            self._location = _Location(file, line)
        }
        
        public var wrappedValue: Value {
            get {
                Store._api[keyPath: self._keyPath]
            }
            
            nonmutating set {
                guard Value.self != Store.API.self else {
                    _Log.error("can not mutating `Store.API` itself", location: self._location)
                    return
                }
                
                Store._api[keyPath: self._keyPath] = newValue
            }
        }
        
        let _keyPath: WritableKeyPath<Store.API, Value>
        let _location: _Location
    }
}
