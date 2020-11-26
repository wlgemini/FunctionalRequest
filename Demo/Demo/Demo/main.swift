//
//  main.swift
//  Demo
//
//  Created by wangluguang on 2020/6/8.
//  Copyright © 2020 com.wlgemini. All rights reserved.
//

import Foundation
import FunctionalRequest


// Config
Config.DataRequest.base = "https://www.mock.com/"


// APIs
let foo = GET<None, None>("login")

// req
foo.request()


