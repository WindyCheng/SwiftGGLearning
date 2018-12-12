import UIKit

// 创建一个简单的元组
let tp1 = (2, 3)
let tp2 = (2, 3, 4)

//创建一个命名元组
let tp3 = (x: 5, y: 3)

// 不同的类型
let tp4 = (name: "Carl", age: 78, pets: ["Bonny", "Houdon", "Miki"])

// 访问元组元素
let tp5 = (13, 21)
tp5.0 // 13
tp5.1 // 21

let tp6 = (x: 21, y: 33)
tp6.x // 21
tp6.y // 33


// 特意造出来的例子
// 这些是多个方法的返回值
let age = 23
let job: String? = "Operator"
let payload: AnyObject = NSDictionary()

switch (age, job, payload) {
case (let age, _?, _ as NSDictionary) where age < 30:
    print(age)
default: ()
}


//把元组做为返回类型
func abc() -> (Int, Int, String) {
    return (3, 5, "Carl")
}

let (a, b, c) = abc()
print(a)

//let (a, b, c) = (a(), b(), c())


//简单的交换两个值：
var A = 5
var B = 4
(B, A) = (A, B)
