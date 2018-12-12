import UIKit

//优秀的泛型使用案例中，最常见的例子当属对栈(Stack)的操作。栈作为容器有两种操作:一.压入(Push)操作添加项到容器中;二.弹出(Pop)操作将最近添加项从容器移除。


//泛型定义方式:由一对尖括号(<>)包裹，命名方式通常为大写字母开头(这里我们命名为T)。在初始化阶段，我们通过明确的类型(这里为Int)来定义参数,之后编译器将所有的泛型T替换成Int类型:

//注意到函数isItemInSatck(item:T)中，我们得到了一个编译错误，因为两个参数没有实现Equtable协议的话，类型值是不能进行比较的。实际上我们可以为泛型增加约束条件来解决这个问题。在本例中，通过对第一行进行修改，我们让泛型T遵循Equatable协议:
class Stack<T:Equatable> {
    
    private var stackItems: [T] = []
    
    func pushItem(item:T) {
        stackItems.append(item)
    }
    
    func popItem() -> T? {
        let lastItem = stackItems.last
        stackItems.removeLast()
        return lastItem
    }
    
    func isItemInStack(item:T) -> Bool {
        var found = false
        for stackItem in stackItems {
            if stackItem == item {
                found = true
            }
        }
        return found
     }
}
