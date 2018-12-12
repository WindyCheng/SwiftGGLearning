import UIKit

struct Cube {
    var side: Double
    
    // 译者注: 结构体中，定义的方法修改内部定义变量值时，该方法必须添加mutating关键字
    mutating func add(newCube: Cube) {
        self.side += newCube.side
    }
}

var myCube = Cube(side: 10.0)
let foundCube1 = Cube(side: 5.0)

myCube.add(newCube: foundCube1)
//print(myCube.side, separator: true)



//通过重载已存在的运算符(例如+ - * /)的方式，Swift允许我们对类或结构体进行运算操作。重载已存在的运算符，言外之意即支持新的数据类型的运算操作。两个魔方(Cube)之间的相加函数定义如下:
func + (lhsCube: Cube, rhsCube: Cube) -> Cube {
    var resultCube = Cube(side: 0.0)
    resultCube.side = lhsCube.side + rhsCube.side
    return resultCube
}

let existingCube = Cube(side: 10.0)
let foundCube2 = Cube(side: 20.0)
let newCube = existingCube + foundCube2
//print(newCube.side, separator: true)


//自定义运算符
//前文”Cube Collection”游戏不妨再加入一个“宝箱”玩法，每一次玩家收集到一个宝箱，他/她所拥有的魔方尺寸就放大三倍(边长side * 3)。为了实现这个游戏机制，我们创建一个自定义运算符。通常，我们需要为这个自定义运算符命名,指定类型，指定优先级以及结合性。想要知道更多这四个方面的知识，请参阅苹果官方文档。既然宝箱的作用是使得魔方尺寸放大三倍，不妨我们将这个自定义运算符命名为***，结合性采用后缀方式(译者注:等价于a++中的++作用)。其中将传入运算符操作函数的变量类型用inout关键字修饰声明。代码如下:

postfix operator ***
postfix func *** ( myCube: inout Cube){
    myCube.side = myCube.side * 3
}

var myCube1 = Cube(side: 10.0)
myCube***
print(myCube1.side, separator: "")//swift2.0新特性 Xcode7下支持



//如何在 Swift 中实现从非零下标遍历数组

let  array = [1,2,3,4,5,6, 7, 8, 9, 10]

for index in 5..<array.count {
    // do something with array[index]
    print("\(index)")
}

(8..<array.count).forEach {
    print($0)
}

for (index, value) in array[5..<array.count].enumerated() {
    // do something with (index + 5) and/or value
    
    print("-----\(index)------\(value)")
}

let range = 5..<array.count
for (index, value) in zip(range, array[range]) {
    print("-----\(index)**********\(value)")
}

let range2 = 5..<array.count
zip(range2, array[range2]).forEach {
    index, value in
    print("-----\(index)￥￥￥￥￥￥￥￥￥￥\(value)")
}

//let results = array[range2].map({
//    // transform $0 and return new value
//})


for value in array.dropFirst(5) {
    // use value here
    
     print("^^^^^^^^^^^^^^^^\(value)")
}


var slice = array.dropFirst(5)
while !slice.isEmpty {
    let value = slice.removeFirst()
    // use value here
    
     print(">>>>>>>>>>>>>>>>>\(value)")
}


