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


//下面是一个示范如何将map和flatMap的调用级联起来去做多次转换的例子。我们从一个字符串开始，把它按单词分开，然后依次做如下转换：
//
//统计每个单词的字符个数，做计数
//把每个计数转换成一个相对应的单词
//给每个结果加个后缀
//对每个字符串结果做%转义
//把每个字符串结果转换成一个NSURL
let formatter = NumberFormatter()
formatter.numberStyle = .spellOut
//let formatter = NSNumberFormatter()
//formatter.numberStyle = .SpellOutStyle
//let string = "This is Functional Programming"
//let translateURLs = string
//    // Split the characters into words
//    .characters.split(" ")
//    // Count the number of characters on each word
//    .map { $0.count }
//    // Spell out this number of chars (`stringFromNumber` can return nil)
//    .flatMap { (n: Int) -> String? in formatter.stringFromNumber(n) }
//    // add " letters" suffix
//    .map { "\($0) letters" }
//    // encode the string so it can be used in an NSURL framgment after the # (the stringByAdding… method can return nil)
//    .flatMap { $0.stringByAddingPercentEncodingWithAllowedCharacters(.URLFragmentAllowedCharacterSet()) }
//    // Build an NSURL using that string (`NSURL(string: …)` is failable: it can return nil)
//    .flatMap { NSURL(string: "https://translate.google.com/#auto/fr/\($0)") }
//
//print(translateURLs)
//// [https://translate.google.com/#auto/fr/four%20letters, https://translate.google.com/#auto/fr/two%20letters, https://translate.google.com/#auto/fr/ten%20letters, https://translate.google.com/#auto/fr/eleven%20letters]


