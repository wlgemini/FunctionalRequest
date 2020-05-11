//
//  Configuration.swift
//

import Foundation
import Alamofire

/// 网络请求的相关设置，每个请求都会及时的应用Configuration的设置
/// 同时，Configuration的配置优先级低于具体接口的单独配置
/// 比如 `foo`接口设置了单独的timeoutInterval，那么就会优先使用这个单独timeoutInterval
public enum Configuration {
    
    /// 基地址
    /// eg: base = "http://www.wlgemini.com/", api = "foo", url = base + api = "http://www.wlgemini.com/foo"
    public static var base: String?
    
    /// 要添加的头信息，会和具体接口中的additionalHeaders进行merge
    /// 但additionalHeaders优先级会更高，会覆盖冲突的key-value
    public static var headers = HTTPHeaders()
    
    /// 超时时长, 用于修改URLRequest.timeoutInterval
    public static var timeoutInterval: TimeInterval?
    
    /// 重定向策略，可以使用内置的重定向策略`Redirector`，也可以自定义对`RedirectHandler`的实现
    public static var redirectHandler: RedirectHandler?

    /// 缓存策略，可以使用内置的缓存策略`ResponseCacher`，也可以自定义对`CachedResponseHandler`的实现
    public static var cachedResponseHandler: CachedResponseHandler?
}
