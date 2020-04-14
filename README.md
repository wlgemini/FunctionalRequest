# FunctionalRequest

这是一个demo项目，用来尝试将网络请求表示成函数调用的形式

## 思路
理论上来说，任何一个确定的API（在返回结果正常的情况下）都应该是有：
- 确定结构的参数
- 确定结构的返回值

这其实就和函数的定义很像，任何一个确定功的函数有：
- 确定类型的入参（可能为Void）
- 确定类型的返回值（也可能为Void）

那么应该是可以定义一个函数来代表一个API的。
一个理想的API定义如下：
```swift
struct APIs {
    // 登录
    // login被定义为一个POST请求
    // 它的入参是一个类型为Account的model，用来表示用户名和密码
    // 它的返回值是一个类型为UserInfo的model，用来表示用户的一些信息
    // 它实际访问的地址为https://www.xxxyyy.com/api/v1/login
    //
    static let login = POST<Account, UserInfo>("https://www.xxxyyy.com/api/v1/login")

    // 获取好友
    // friends被定义为一个GET请求
    // 它的入参是一个类型为Page，用来表示分页
    // 它的返回值是一个类型为[Friend]，用来表示一个Friend数组
    // 它实际访问的地址为https://www.xxxyyy.com/api/v1/friends
    //
    static let friends = GET<Page, [Friend]>("https://www.xxxyyy.com/api/v1/friends")
}
```

其使用如下：
```swift
// login
let account = Account(email: "xxxyyy@xy.com", password: "123456")
let userInfo = await APIs.login(account)

// get friends
let page = Page(index: 0, total: 10)
let friends = await APIs.friends(page)
```

以上是Swift 6.0在支持`async`/`await`后才能用的
目前还写不出这种形式，不过这应该是以后的发展方向。

## 在Swift 5.2版本的尝试

在Swift 5.2中新增了`callAsFunction`函数，可以让一个实例作为函数被调用。比如：
```swift
struct Add {
    let adder: Int
  
    init(_ adder: Int) {
        self.adder = adder
    }
  
    func callAsFunction(_ other: Int) -> Int {
        return other + self.adder
    }
}

let addTwo = Add(2)
let a = addTwo(0) // 2
let b = addTwo(1) // 3
let c = addTwo(5) // 7
```

可以看出来，这
