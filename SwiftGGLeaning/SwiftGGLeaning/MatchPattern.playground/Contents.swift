import UIKit


print("Hello", "Swift", 4.2, separator:" ", terminator:".")

// 历史上最坏的一个例子：二进制->十进制的转换
let bool1 = 1
let bool2 = 0
switch (bool1, bool2) {
case (0, 0): print("0")
case (0, 1): print("1")
case (1, 0): print("2")
case (1, 1): print("3")
case (_, _): break
    
}

//1. 通配符模式
//通配符模式会忽略需要匹配的值，这种 case 下任何值都是有可能的。这和 let _ = fn() 一样的模式，在这个模式下， _ 表示你将不再使用这个值。有意思的是这个模式可以匹配包括 nil 1在内的所有值 。如果增加一个 ?，它甚至可以匹配可选值：

let p: String? = nil
switch p {
case _?: print ("Has String")
case nil: print ("No String")
}


//2. 标示模式
//匹配一个具体的值。这个和 Objective-C 的 switch 实现是一样的：
switch 5 {
case 5: print("5")
default: break
}

//3. 值绑定模式
//这种模式和通过 let 或者 var 绑定值到变量一样，但是只能用在 switch 中。因为你之前已经见到过，所以我只给出一个非常简单的例子：

switch (4, 5) {
case let (x, y): print("\(x) \(y)")
}


//4. 元组模式
//关于元组我已经写了一整篇博文，这篇博文所提供的信息远远比这里多，但是我还是在这里给出一个简短的例子：

let age = 23
let job: String? = "Operator"
let payload: AnyObject = NSDictionary()

switch (age, job, payload) {
case (let age, _?, _ as NSDictionary):
    print(age)
default: ()
}
//在这里，我们把 3 个值结合放到一个元组中（假想它们是通过调用不同的 API 得到的），然后一口气匹配它们，注意这个模式完成了三件事情：
//
//1.提取 age
//2.确保存在一个 job，就算我们不需要它
//3.确保 payload 的类型是 NSDictionary，尽管我们同样不需要访问它的具体值。




//5. 枚举 Case 模式（Enumeration Case Pattern）
//就如你在交易例子中所见，模式匹配对 Swift 的 enum 支持相当棒。这是因为 enum cases 就像密封、不可变且可解构的结构体。这非常像 tuples，你可以打开正好匹配上的某个单独 case 的内容然后只抽取出你需要的信息2。
//
//假想你正在用函数式的风格写一个游戏，然后你需要定义一些实体。你可以使用 structs 但是你的实体的状态很少，你觉得这样有点矫枉过正。

//enum Entities {
//    case Soldier(x: Int, y: Int)
//    case Tank(x: Int, y: Int)
//    case Player(x: Int, y: Int)
//}
//现在你需要实现绘图循环。这里我们只需要 X 和 Y 坐标：

//let entitys = Entities()
//
//for e in entitys() {
//    switch e {
//    case let .Soldier(x, y):
//        drawImage("soldier.png", x, y)
//    case let .Tank(x, y):
//        drawImage("tank.png", x, y)
//    case let .Player(x, y):
//        drawImage("player.png", x, y)
//    }
//}


//6. 类型转换模式
//就像名字所表示的一样，这种模式转换或者匹配类型。它有两种不同的关键词：
//
//    is 类型：匹配右手边内容的运行时类型（或者类型的子类）。它会做类型转换但是不关注返回值。所以你的 case 块不知道所匹配的类型是什么。
//模式 as 类型：和 is 模式做同样的匹配操作，但是如果成功的话会把类型转换到左侧指定的模式中。
//下面是这两种关键词的例子：

let a: Any = 5
switch a {
    // 这会失败因为它的类型仍然是 `Any`
// 错误: binary operator '+' cannot be applied to operands of type 'Any' and 'Int'
case is Int: print (a as! Int + 1)
// 有效并返回 '6'
case let n as Int: print (n + 1)
default: ()
}
//注意 is 前没有 pattern。它直接和 a 做匹配。




//7.表达模式非常强大。它可以把 switch 的值和实现了 ~= 操作符的表达式进行匹配。而且对于这个操作符有默认的实现，比如对于范围匹配，你可以这样做：
switch 5 {
case 0..<10: print("In range 0-10")
default: break
}



//在这篇博文之前的版本中我写过 ~= 不适用于协议，但是我错了。我记得我在一个 Playground 中试过。而这个例子（由 reddit 上的 latrodectus 友情提供）是完全可用的：

protocol Entity {
    var value: Int {get}
}

struct Tank: Entity {
    var value: Int
    init(_ value: Int) { self.value = value }
}

struct Peasant: Entity {
    var value: Int
    init(_ value: Int) { self.value = value }
}

func ~=(pattern: Entity, x: Entity) -> Bool {
    return pattern.value == x.value
}

switch Tank(42) {
case Peasant(42): print("Matched") // 匹配成功
default: ()
}




//fallthrough，break 和标签
//下面的内容和模式匹配没有直接关系，仅仅是和 switch 关键词有关，所以我就简单说了。和 C/C++/Objective-C 不一样的是：switch cases 不会自动进入下一个 case，这也是为什么 Swift 不需要给每个 case 都写上 break。你可以选择使用 fallthrough 关键词来实现传统的自动进入下一个 case 的行为。

switch 5 {
case 5:
    print("Is 5")
    fallthrough
default:
    print("Is a number")
}
// 会在命令行输出: "Is 5" "Is a number"
//另外，你可以使用 break 来提前跳出 switch 语句。既然不会默认进入下一个 case，为什么还需要这么做呢？比如你知道在一个 case 中有一个必须的要求是不满足的，这样你就不能继续执行这个 case 了：

//let userType = "system"
//let userID = 10
//switch (userType, userID)  {
//case ("system", _):
//    guard let userData = getSystemUser(userID) else { break }
//    print("user info: \(userData)")
//    insertIntoRemoteDB(userData)
//default: ()
//}
//... 其他你需要执行的代码
//在这段代码中，当 getSystemUser 返回的结果是 nil 时你不想再继续调用 insertIntoRemoteData。当然，你可以在这里使用 if let，但是如果多个这样的情况结合到一起的时候，很快你就会得到一堆可怕丑陋的 if lets 嵌套代码。
//
//但是如果你是在一个 while 循环中执行你的 switch 语句，然后你想跳出循环，而不是 switch 的时候，你需要怎么做呢？对与这种情况， Swift 允许你定义一个 labels ，然后 break 或者 continue 到这个 labels：

//gameLoop: while true {
//    switch state() {
//    case .Waiting: continue gameLoop
//    case .Done: calculateNextState()
//    case .GameOver: break gameLoop
//    }
//}
//我们已经讨论过 switch 和模式匹配的语法和实现细节。现在，让我们来看一些（多少有点）有趣的真实案例。

//var result: String? = secretMethod()
//switch result {
//case nil:
//    print("is nothing")
//case let a?:
//    print("\(a) is a value")
//}



//类型匹配例子
//数组：
let u = NSArray(array: [NSString(string: "String1"), NSNumber(value: 20), NSNumber(value: 40)])
//当你遍历这个 NSArray 时，你永远不知道得到的是什么类型。然而， switch 语句可以让你很简单的检查这些类型：

for x in u {
    switch x {
    case _ as NSString:
        print("string")
    case _ as NSNumber:
        print("number")
    default:
        print("Unknown types")
    }
}


//按范围做分级
//现在你正在给你当地的高校写分级的 iOS 应用。老师想要输入一个 0 到 100 的数值，然后得到一个相应的等级字符（A-F）。模式匹配现在要来拯救你了：

let aGrade = 84

switch aGrade {
case 90...100: print("A")
case 80...90: print("B")
case 70...80: print("C")
case 60...70: print("D")
case 0...60: print("F")
default:
    print("Incorrect Grade")
}


//字频率统计
//有一系列的数据对，每个数据对代表一个字和它在某段文字中出现的频率。我们的目标就是把那些低于或者高于某个固定阈值的数据对过滤掉，然后只返回剩下的不包含其频率的所有字。
//
//这是我们的字集：

let wordFreqs = [("k", 5), ("a", 7), ("b", 3)]

let res = wordFreqs.compactMap { (e) -> String? in
    switch e {
    case let (s, t) where t > 3: return s
    default: return nil
    }
}
print(res)


//遍历目录
//假想你需要遍历一个文件树然后查找以下内容：
//
//所有 customer1 和 customer2 创建的 “psd“文件
//所有 customer2 创建的 “blend“文件
//所有用户创建的 “jpeg“文件
//guard let enumerator = FileManager.default.enumerator(atPath: "/customers/2014/")
//    else { return }
//
//for url in enumerator {
//    switch ((url as AnyObject).pathComponents, (url as AnyObject).pathExtension) {
//
//    // customer1 和 customer2 创建的 “psd“文件
//    case (let f, "psd")
//        where f.contains("customer1")
//            || f.contains("customer2"): print(url)
//
//    // customer2 创建的 “blend“文件
//    case (let f, "blend") where f.contains("customer2"): print(url)
//
//    // 所有的 “jpeg“文件
//    case (_, "jpg"): print(url)
//
//    default: ()
//    }
//}

//Fibonacci
//同样，来看一下使用模式匹配实现的 fibonacci 算法有多优美3
func fibonacci(i: Int) -> Int {
    switch(i) {
    case let n where n <= 0: return 0
    case 0, 1: return 1
    case let n: return fibonacci(i: n - 1) + fibonacci(i: n - 2)
    }
}

print(fibonacci(i: 8))
//当然，如果是大数的话，程序栈会爆掉。



//模式和其他关键词
// 到吗编译后只是一个关键词的集合。其本身没有任何意义
func valueTupleType(a: (Int, Any)) -> Bool {
    // guard case 的例子
    guard case let (x, _ as String) = a else { return false}
    print(x)
    
    // for case 的例子
    for case let (a, _ as String) in [a] {
        print(a)
    }
    
    // if case 的例子
    if case let (x, _ as String) = a {
        print("if", x)
    }
    
    // switch case example
    switch a {
    case let (a, _ as String):
        print(a)
        return true
    default: return false
    }
}
let x: Any = "a"
let b: Any = 5
print(valueTupleType(a: (5, x)))
print(valueTupleType(a: (5, b)))
// 5, 5, "if 5", 5, true, false





//使用 for case
//    到了 Swift 2.0 后，模式匹配变得更加重要，因为它被扩展到不仅可以支持 switch ，还可以支持其他的关键词。比如，让我们写一个简单的只返回非空元素的数组函数：

func nonnil<T>(array: [T?]) -> [T] {
    var result: [T] = []
    for case let x? in array {
        result.append(x)
    }
    return result
}

print(nonnil(array: ["a", nil, "b", "c", nil]))



//enum Entity1 {
//    enum EntityType {
//        case Soldier
//        case Player
//    }
//    case Entry(type: EntityType, x: Int, y: Int, hp: Int)
//}
