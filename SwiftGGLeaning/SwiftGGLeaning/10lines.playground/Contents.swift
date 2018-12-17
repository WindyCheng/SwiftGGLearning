import UIKit


//#1 将数组中每个元素的值乘以 2
(1...1024).map{$0 * 2}

//#2 求一组数字的和
(1...1024).reduce(0, +)


//#3 证明字符串中含有某个单词
let words = ["Swift","iOS","cocoa","OSX","tvOS"]
let tweet = "This is an example tweet larking about Swift"

let valid = !words.filter({tweet.contains($0)}).isEmpty
valid //true

let valid1 = words.contains(where: tweet.contains)
valid1

//方法3:
let valid2 = tweet
    .split(separator: " ")
    .lazy
    .map(String.init)
    .contains(where: Set(words).contains)
valid2


//#4 读取一个文件
//let path = Bundle.main.path(forResource: "test", ofType: "txt")
//let lines = try? String(contentsOfFile: path!).split{$0 == "\n"}.map(String.init)
//if let lines=lines {
//    lines[0] // O! for a Muse of fire, that would ascend
//    lines[1] // The brightest heaven of invention!
//    lines[2] // A kingdom for a stage, princes to act
//    lines[3] // And monarchs to behold the swelling scene.
//}

//#5 祝你生日快乐
let name = "uraimo"
(1...4).forEach{print("Happy Birthday " + (($0 == 3) ? "dear \(name)":"to You"))}



//#6 数组过滤
extension Sequence{
    
    func anotherPartitionBy(fu: (Self.Iterator.Element)->Bool)->([Self.Iterator.Element],[Self.Iterator.Element]){
        return (self.filter(fu),self.filter({!fu($0)}))
    }
}

let part2 = [82, 58, 76, 49, 88, 90].anotherPartitionBy{$0 < 60}
part2 // ([58, 49], [82, 76, 88, 90])

var part3 = [82, 58, 76, 49, 88, 90].reduce( ([],[]), {
    (a:([Int],[Int]),n:Int) -> ([Int],[Int]) in
    (n<60) ? (a.0+[n],a.1) : (a.0,a.1+[n])
})
part3 // ([58, 49], [82, 76, 88, 90])

//#7 获取并解析 XML 格式的网络服务
//这次，我们打算使用纯 Swift 实现的库：AEXML：
//
//let xmlDoc = try? AEXMLDocument(xmlData: NSData(contentsOfURL: NSURL(string:"https://www.ibiblio.org/xml/examples/shakespeare/hen_v.xml")!)!)
//
//if let xmlDoc=xmlDoc {
//    var prologue = xmlDoc.root.children[6]["PROLOGUE"]["SPEECH"]
//    prologue.children[1].stringValue // Now all the youth of England are on fire,
//    prologue.children[2].stringValue // And silken dalliance in the wardrobe lies:
//    prologue.children[3].stringValue // Now thrive the armourers, and honour's thought
//    prologue.children[4].stringValue // Reigns solely in the breast of every man:
//    prologue.children[5].stringValue // They sell the pasture now to buy the horse,
//}

//#8 找到数组中最小（或最大）的元素
//Find the minimum of an array of Ints
[10,-22,753,55,137,-1,-279,1034,77].sorted().first

[10,-22,753,55,137,-1,-279,1034,77].reduce(Int.max, min)
[10,-22,753,55,137,-1,-279,1034,77].min()

//Find the maximum of an array of Ints
[10,-22,753,55,137,-1,-279,1034,77].sorted().last
[10,-22,753,55,137,-1,-279,1034,77].reduce(Int.min, max)
[10,-22,753,55,137,-1,-279,1034,77].max()


//#10 埃拉托色尼选筛法
//古老而优秀的埃拉托色尼选筛法被用于找到所有小于给定的上限 n 的质数。
//
//首先将所有小于 n 的整数都放入一个序列（sequence）中，这个算法会移除每个数字的倍数，直到剩下的所有数字都是质数。为了加快执行速度，我们其实不必检查每一个数字的倍数，当检查到 n 的平方根时就可以停止。
let n = 50
var primes = Set(2...n)

//sameprimes.subtract((2...Int(sqrt(Double(n))))
//    .flatMap{ (2*$0).stride(through:n, by:$0)})
//sameprimes.sorted()

(2...Int(sqrt(Double(n)))).forEach {
    let _ = primes.subtract(stride(from: 2*$0, through: n, by: $0))
}

print(primes.sorted())

//#11 福利：使用析构交换元组中的值
var a = 1, b = 2

(a,b) = (b,a)
a //2
b //1

// 装作这个函数执行了某些复杂的操作
func someArray() -> [Int]? {
    return [1, 2, 3, 4, 5, 6]
}

func example() {
    guard let array = someArray(),
        let numberThree = Optional.some(array[2]), numberThree == 3
        else { return }
    print(numberThree)
}


let anArray = Array(1...20)
let anotherArray = anArray.filter ({$0 > 10})

print(anotherArray) // [11,12,13,14,15,16,17,18,19,20]


let anotherArray1 = anArray.filter({$0 > 10}).map({$0 * 2})

print(anotherArray1) // [22, 24, 26, 28, 30, 32, 34, 36, 38, 40]


//func doSomething(){
//
//}
//
//var thing:String?
//guard let thing = thing else { return } // 在变量不能被解包的时候退出
//doSomething(with: thing) // thing 这个变量现在已经解包了


func doSomething(){

}

//let dobString = dob.flatMap(serverDateFormatter.stringFromDate) ?? ""


//Swift：让人眼前一亮的初始化方式
let yellowView: UIView = {
    $0.backgroundColor = .yellow
    return $0
    // 确保下一行的括号内要传入 UIView()
}(UIView())
