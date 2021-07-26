//
//  InternalModifier.swift
//  

import Foundation
import Alamofire


/// _InternalModifier
enum _InternalModifier {
    
    // MARK: - Accessing
    /// AccessingValue
    struct AccessingValue<Value: Any>: Modifier {
        
        public func modify(context: Context) {
            
        }
        
        var _onAvailable: (Value) -> Void
        
        init(onAvailable: @escaping (Value) -> Void) {
            self._onAvailable = onAvailable
        }
    }
    
    /// AccessingObject
    struct AccessingObject<Object: AnyObject>: Modifier {
        
        public func modify(context: Context) { }
        
        public func modify(context: Context)
        where Object == Alamofire.DataRequest {
            context.accessing.onDataRequestAvailable = self._onAvailable
        }
        
        var _onAvailable: (Object) -> Void
        
        init(onAvailable: @escaping (Object) -> Void) {
            self._onAvailable = onAvailable
        }
    }
}
