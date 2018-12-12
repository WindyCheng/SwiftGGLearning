import UIKit

func isPositive(value: Int) -> Bool {
    return value > 0
}

[-4,-2,0,4,7,-8,3].filter(isPositive)




func isMultiple(multiplier: Int) -> ((Int) -> Bool) {
    return { (value: Int) -> Bool in
        value % multiplier == 0
    }
}


func isMultiple0(multiplier: Int, value: Int) -> Bool {
    return value % multiplier == 0
}

func isMultiple1(multiplier: Int) -> (_ value: Int) -> Bool {
    return { value in value % multiplier == 0 }
}

[-4,-2,0,4,7,-8,3].filter { value in isPositive(value: value) || isMultiple(multiplier: 2)(value) }


//函数组合
//    && 和 || 运算符已经存在了，我们只需要对他们进行重载，好让它们能够接收 Int -> Bool 类型作为参数：
func || (lhs: @escaping (Int)->Bool, rhs: @escaping (Int)->Bool) -> ((Int)->Bool) {
    return { (value: Int) -> Bool in
        return lhs(value) || rhs(value)
    }
}

//我们也可以对 && 运算符进行同样的操作。这次我们将使用 $0 隐式参数，这样可以使代码更紧凑：

func && (lhs: @escaping (Int)->Bool, rhs: @escaping (Int)->Bool) -> ((Int)->Bool) {
    return { lhs($0) && rhs($0) }
}

//重写 ! 运行符好让我们可以对一个函数进行取反，如何？
prefix func ! (f: @escaping (Int)->Bool) -> ((Int)->Bool) {
    return { value in !f(value) }
}

[-4,-2,0,4,7,-8,3].filter( !isPositive || isMultiple(multiplier: 3) )
// return [-4,-2,0,-8,3] (non-positive numbers + multiples of 3)
// 非负数 + 3 的倍数



let isZero = { value in value == 0 }
let isPositiveOrZero = isPositive || isZero
let isNegative = !isPositive && !isZero
let isNegativeOrZero = !isPositive
let isEven = isMultiple(multiplier: 2)
let isOdd = !isEven


[-4,-2,0,4,7,-8,3].filter(isZero)

[-4,-2,0,4,7,-8,3].filter(isPositiveOrZero)


[-4,-2,0,4,7,-8,3].filter(isNegative)

[-4,-2,0,4,7,-8,3].filter(isNegativeOrZero)

[-4,-2,0,4,7,-8,3].filter(isEven)

[-4,-2,0,4,7,-8,3].filter(isOdd)


//总结
//通过这些简单的例子，我们学习到了返回函数的函数的好用之处，同时还学习了如何对运算符进行重载以用来对返回 Bool 类型的函数进行组合，最后还介绍了柯里化的概念。
//
//函数还有很多有乐趣值得我们去挖掘。我们可以使 &&, || 和 ! 的重载更加泛型化，以使它们可以接受 T -> Bool 类型的函数，这里的 T 可以是任何类型。我甚至还可以全面地讲解柯里化的知识，解开它的封印，深入探索下函数式编程(不过目前已经有很多其它的博客对这些进行了讲解，因此我觉得不需要再增加我的一篇了)，不过我觉得今天这些知识已经足够你充实一整天了！
