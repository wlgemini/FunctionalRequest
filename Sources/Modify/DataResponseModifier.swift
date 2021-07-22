//
//  DataResponseModifier.swift
//  

import Foundation
import Alamofire


/// DataResponseModifier
public enum DataResponseModifier {
    
    // MARK: - Validation
    /// Validation
    public struct Validation: Modify {
        
        public init(statusCode acceptableStatusCodes: Range<Int>) {
            self._type = .statusCode(acceptableStatusCodes)
        }
        
        public init(contentType acceptableContentTypes: @escaping Compute<[String]>) {
            self._type = .contentType(acceptableContentTypes)
        }
        
        public func modify(context: Context) {
            
        }
        
        let _type: _Type
        
        enum _Type {
            
            case statusCode(Range<Int>)
            
            case contentType(Compute<[String]>)
        }
    }

    
    // MARK: - Serializer
    public struct Serializer<S>: Modify
    where S: Alamofire.DataResponseSerializerProtocol {
        
        public init(_ serializer: S) {
            self._serializer = serializer
        }
        
        public func modify(context: Context) {
            
        }
        
        let _serializer: S
    }
    
    
    // MARK: - CacheResponse
    /// CacheResponse
    public struct CacheResponse: Modify {
        
        public init(using handler: Alamofire.CachedResponseHandler) {
            self._handler = handler
        }
        
        public func modify(context: Context) {
            
        }
        
        let _handler: Alamofire.CachedResponseHandler
    }
}
