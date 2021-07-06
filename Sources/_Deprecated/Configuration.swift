//
//  Configuration.swift
//

import Foundation
import Alamofire


/// 网络请求的相关设置
public enum Configuration {
    
    /// 网络事件监控
    ///
    /// ⚠️注意：必须在调用网络请求之前设置，并且调用网络请求开始后不能修改
    /// 可以使用内置的监控类`Alamofire.ClosureEventMonitor`，也可以自定义对`Alamofire.EventMonitor`的实现
    public static var eventMonitors: [Alamofire.EventMonitor] = []
    
    
    /// 每个请求都会即时的应用`Configuration`的设置
    /// 但`ConfigurationModifier`的配置会覆盖掉冲突的`Configuration`配置
    public enum DataRequest {
        
        /// 基地址，适用于所有请求都使用同一个的基地址的情况
        ///
        ///     let login = GET<Account, UserInfo>("v1/login")
        ///
        ///     // 等价于
        ///     let login = GET<Account, UserInfo>("v1/login", base: Configuration.DataRequest.base())
        ///
        ///     // 其中url为:
        ///     let url = base + api
        ///
        public static var base: Compute<String?> = { nil }
        
        /// 要添加的头信息，会和`DataRequestableConfiguration`中的`additionalHeaders`进行merge
        /// 但`ConfigurationModifier`中的`additionalHeaders`优先级更高，会覆盖掉冲突的key-value
        public static var headers: Compute<Alamofire.HTTPHeaders?> = { nil }
        
        /// 超时时长, 用于修改`URLRequest.timeoutInterval`
        /// `ConfigurationModifier`中的`timeoutInterval`优先级更高，会覆盖掉冲突的`timeoutInterval`
        public static var timeoutInterval: Compute<TimeInterval?> = { nil }
        
        /// add a `URLCredential` for each `Alamofire.Request`
        /// `ConfigurationModifier`中的`credential`优先级更高，会覆盖掉冲突的`credential`
        public static var credential: Compute<URLCredential?> = { nil }
        
        /// 重定向策略，可以使用内置的重定向策略`Alamofire.Redirector`，也可以自定义对`Alamofire.RedirectHandler`的实现
        /// `ConfigurationModifier`中的`redirectHandler`优先级更高，会覆盖掉冲突的`redirectHandler`
        public static var redirectHandler: Compute<Alamofire.RedirectHandler?> = { nil }
        
        /// `Alamofire.RequestInterceptor` to be used for all `Alamofire.Request`s created by this instance. `nil` by default.
        ///
        /// ⚠️注意：必须在调用网络请求之前设置，并且调用网络请求开始后不能修改
        public static var interceptor: Alamofire.RequestInterceptor? = nil
        
        /// `ServerTrustManager` to be used for all trust evaluations by this instance. `nil` by default.
        ///
        /// ⚠️注意：必须在调用网络请求之前设置，并且调用网络请求开始后不能修改
        public static var serverTrustManager: Alamofire.ServerTrustManager? = nil
        
        
        /// JSON
        public enum JSON {
            
            /// Default encoding
            enum Encoding {
                
                /// for `get` encoding. default: `Alamofire.URLEncoding.default`
                static var get: Compute<Alamofire.ParameterEncoding?> = { nil }
                
                /// for `delete` encoding. default:` Alamofire.URLEncoding.default`
                static var delete: Compute<Alamofire.ParameterEncoding?> = { nil }
                
                /// for `patch` encoding. default: `Alamofire.JSONEncoding.default`
                static var patch: Compute<Alamofire.ParameterEncoding?> = { nil }
                
                /// for `post` encoding. default: `Alamofire.JSONEncoding.default`
                static var post: Compute<Alamofire.ParameterEncoding?> = { nil }
                
                /// for `put` encoding. default: `Alamofire.JSONEncoding.default`
                static var put: Compute<Alamofire.ParameterEncoding?> = { nil }
            }
        }
        
        
        /// Encodable
        public enum Encodable {
            
            /// Default encoder
            enum Encoder {
                
                /// for `get` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
                static var get: Compute<Alamofire.ParameterEncoder?> = { nil }
                
                /// for `delete` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
                static var delete: Compute<Alamofire.ParameterEncoder?> = { nil }
                
                /// for `patch` encoder. default: `Alamofire.JSONParameterEncoder.default`
                static var patch: Compute<Alamofire.ParameterEncoder?> = { nil }
                
                /// for `post` encoder. default: `Alamofire.JSONParameterEncoder.default`
                static var post: Compute<Alamofire.ParameterEncoder?> = { nil }
                
                /// for `put` encoder. default: `Alamofire.JSONParameterEncoder.default`
                static var put: Compute<Alamofire.ParameterEncoder?> = { nil }
            }
        }
    }
    
    
    /// DataResponse
    public enum DataResponse {
        
        /// DataResponse on queue, default: `.main`
        public static var queue: Compute<DispatchQueue?> = { nil }
        
        /// DataResponse validation.
        /// default: validates that status codes are within the 200..<300 range,
        /// and that the Content-Type header of the response matches the Accept header of the request, if one is provided.
        public static var validation: Compute<Alamofire.DataRequest.Validation?> = { nil }
        
        /// 缓存策略，可以使用内置的缓存策略`Alamofire.ResponseCacher`，也可以自定义对`Alamofire.CachedResponseHandler`的实现
        /// `ConfigurationModifier`中的`cachedResponseHandler`优先级更高，会覆盖掉冲突的`cachedResponseHandler`
        public static var cachedResponseHandler: Compute<Alamofire.CachedResponseHandler?> = { nil }
        
        
        /// Data
        public enum Data {
            
            /// default: `Alamofire.DataResponseSerializer.defaultDataPreprocessor`
            public static var dataPreprocessor: Compute<Alamofire.DataPreprocessor?> = { nil }
            
            /// default: `Alamofire.DataResponseSerializer.defaultEmptyResponseCodes`
            public static var emptyResponseCodes: Compute<Set<Int>?> = { nil }

            /// default: `Alamofire.DataResponseSerializer.defaultEmptyRequestMethods`
            public static var emptyRequestMethods: Compute<Set<Alamofire.HTTPMethod>?> = { nil }
        }
        
        
        /// JSON
        public enum JSON {
            
            /// default: `.allowFragments`
            public static var options: Compute<JSONSerialization.ReadingOptions?> = { nil }
            
            /// default: `Alamofire.JSONResponseSerializer.defaultDataPreprocessor`
            public static var dataPreprocessor: Compute<Alamofire.DataPreprocessor?> = { nil }
            
            /// default: `Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes`
            public static var emptyResponseCodes: Compute<Set<Int>?> = { nil }

            /// default: `Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods`
            public static var emptyRequestMethods: Compute<Set<Alamofire.HTTPMethod>?> = { nil }
        }
        
        
        /// Decodable
        public enum Decodable {
            
            /// default: `JSONDecoder()`
            public static var decoder: Compute<Alamofire.DataDecoder?> = { nil }
            
            /// default: `Alamofire.DecodableResponseSerializer<T>.defaultDataPreprocessor`
            public static var dataPreprocessor: Compute<Alamofire.DataPreprocessor?> = { nil }
            
            /// default: `Alamofire.DecodableResponseSerializer<T>.defaultEmptyResponseCodes`
            public static var emptyResponseCodes: Compute<Set<Int>?> = { nil }

            /// default: `Alamofire.DecodableResponseSerializer<T>.defaultEmptyRequestMethods`
            public static var emptyRequestMethods: Compute<Set<Alamofire.HTTPMethod>?> = { nil }
        }
    }
}

