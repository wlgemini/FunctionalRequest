//
//  DataResponseModifier.swift
//  

import Foundation
import Alamofire


/// DataResponseModifier
public enum DataResponseModifier {
    
    // MARK: - Validation
    /// Validation
    public struct Validation: Modifier {
        
        public init(statusCode acceptableStatusCodes: Range<Int>) {
            self._type = .statusCode(acceptableStatusCodes)
        }
        
        public init(contentType acceptableContentTypes: @escaping Compute<[String]>) {
            self._type = .contentType(acceptableContentTypes)
        }
        
        public func modify(context: Context) {
            switch self._type {
            case .statusCode(let acceptableStatusCodes):
                context.dataResponse.acceptableStatusCodes = acceptableStatusCodes
                
            case .contentType(let acceptableContentTypes):
                context.dataResponse.acceptableContentTypes = acceptableContentTypes
            }
        }
        
        let _type: _Type
        
        enum _Type {
            
            case statusCode(Range<Int>)
            
            case contentType(Compute<[String]>)
        }
    }
    
    
    // MARK: - Queue
    public struct Queue: Modifier {
        
        public init(_ queue: DispatchQueue) {
            self._queue = queue
        }
        
        public func modify(context: Context) {
            context.dataResponse.queue = self._queue
        }
        
        let _queue: DispatchQueue
    }

    
    // MARK: - Serializer
    /// SerializeData
    public struct SerializeData: Modifier {
        
        public init(_ serializer: Alamofire.DataResponseSerializer) {
            self._serializer = serializer
        }
        
        public func modify(context: Context) {
            context.dataResponse.serializeData.dataPreprocessor = self._serializer.dataPreprocessor
            context.dataResponse.serializeData.emptyResponseCodes = self._serializer.emptyResponseCodes
            context.dataResponse.serializeData.emptyRequestMethods = self._serializer.emptyRequestMethods
        }
        
        let _serializer: Alamofire.DataResponseSerializer
    }
    
    /// SerializeString
    public struct SerializeString: Modifier {
        
        public init(_ serializer: Alamofire.StringResponseSerializer) {
            self._serializer = serializer
        }
        
        public func modify(context: Context) {
            context.dataResponse.serializeString.dataPreprocessor = self._serializer.dataPreprocessor
            context.dataResponse.serializeString.encoding = self._serializer.encoding
            context.dataResponse.serializeString.emptyResponseCodes = self._serializer.emptyResponseCodes
            context.dataResponse.serializeString.emptyRequestMethods = self._serializer.emptyRequestMethods
        }
        
        let _serializer: Alamofire.StringResponseSerializer
    }
    
    /// SerializeJSON
    public struct SerializeJSON: Modifier {
        
        public init(_ serializer: Alamofire.JSONResponseSerializer) {
            self._serializer = serializer
        }
        
        public func modify(context: Context) {
            context.dataResponse.serializeJSON.dataPreprocessor = self._serializer.dataPreprocessor
            context.dataResponse.serializeJSON.emptyResponseCodes = self._serializer.emptyResponseCodes
            context.dataResponse.serializeJSON.emptyRequestMethods = self._serializer.emptyRequestMethods
            context.dataResponse.serializeJSON.options = self._serializer.options
        }
        
        let _serializer: Alamofire.JSONResponseSerializer
    }
    
    /// SerializeDecodable
    public struct SerializeDecodable<T>: Modifier
    where T: Decodable {
        
        public init(_ serializer: Alamofire.DecodableResponseSerializer<T>) {
            self._serializer = serializer
        }
        
        public func modify(context: Context) {
            context.dataResponse.serializeDecodable.dataPreprocessor = self._serializer.dataPreprocessor
            context.dataResponse.serializeDecodable.decoder = self._serializer.decoder
            context.dataResponse.serializeDecodable.emptyResponseCodes = self._serializer.emptyResponseCodes
            context.dataResponse.serializeDecodable.emptyRequestMethods = self._serializer.emptyRequestMethods
        }
        
        let _serializer: Alamofire.DecodableResponseSerializer<T>
    }
    
    
    // MARK: - CacheResponse
    /// CacheResponse
    public struct CacheResponse: Modifier {
        
        public init(using handler: Alamofire.CachedResponseHandler) {
            self._handler = handler
        }
        
        public func modify(context: Context) {
            
        }
        
        let _handler: Alamofire.CachedResponseHandler
    }
}
