//
//  Configuration.swift
//  Net
//
//  Created by wangluguang on 2020/4/8.
//  Copyright © 2020 com.wlgemini. All rights reserved.
//

import Alamofire
import Foundation

/// 网络请求的相关设置，每个请求都会及时的应用Configuration的设置
/// 同时，Configuration的配置优先级低于具体接口的单独配置
/// 比如 `foo`接口设置了单独的timeoutInterval，那么就会优先使用这个单独timeoutInterval
enum Configuration {
    
    /// 要添加的头信息，会和具体接口中的additionalHeaders进行merge
    /// 但additionalHeaders优先级会更高，会覆盖冲突的key-value
    static var headers = HTTPHeaders()
    
    /// 超时时长, 用于修改URLRequest.timeoutInterval
    static var timeoutInterval: TimeInterval?
}
