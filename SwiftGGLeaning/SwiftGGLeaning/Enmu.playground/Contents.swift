import UIKit
import Foundation

//enum FamilyRelationshipType: Int {
//    case GrandFather = 400
//    case GrandMother = 500
//    case Father = 600
//    case Mother = 700
//    case Brother = 800
//    case Sister = 900
//    case Son = 1000
//    case Daugther = 1100
//}

enum FamilyRelationshipType {
    case GrandFather(age: Int)
    case GrandMother(age: Int)
    case Father(age: Int)
    case Mother(age: Int)
    case Husband(age: Int)
    case Wife(age: Int)
    case Brother(age: Int)
    case Sister(age: Int)
    case Son(age: Int)
    case Daugther(age: Int)
    
    func gift() -> String {
        switch(self) {
        case .Brother(let age):
            if age > 10 {
                return "video games"
            } else {
                return "toys"
            }
        case .GrandFather:
            return "Book"
        case .GrandMother:
            return "Sweater"
        case .Father:
            return "Shirt"
        case .Mother:
            return "Flowers"
        default:
            return "Choclates"
        }
    }
}


//最后，说一下Swift中枚举最酷的地方，就是在枚举中可以有方法，也可以使用构造器。giftFor函数其实可以从FamilyMember结构内移到FamilyRelationType枚举中去，因为该方法是基于成员关系及其联合值的。对上面的代码进行重构(我同时把函数giftFor也改名为gift)后，最终的代码如下：


struct FamilyMember {
    var name: String
    var relationshipType: FamilyRelationshipType
    
    init(name: String, relationshipType: FamilyRelationshipType) {
        self.name = name
        self.relationshipType = relationshipType
    }
}

//let sister = FamilyMember(name: "Jacky", relationshipType: FamilyRelationshipType.Sister)
//let brother = FamilyMember(name: "Jack", relationshipType: FamilyRelationshipType.Brother)

func giftFor(member: FamilyMember) -> String {
    switch (member.relationshipType) {
    case .GrandFather:
        return "Book"
    case .GrandMother:
        return "Sweater"
    case .Father:
        return "Shirt"
    case .Mother:
        return "Flowers"
    default:
        return "Choclates"
    }
}


//正如刚才所见，枚举也可以进行扩展。最明显的用例就是将枚举的case和method分离，这样阅读你的代码能够简单快速地消化掉enum内容，紧接着转移到方法定义:

enum Entities {
    case Soldier(x: Int, y: Int)
    case Tank(x: Int, y: Int)
    case Player(x: Int, y: Int)
}


extension Entities {
    mutating func move(dist: CGVector) {}
    mutating func attack() {}
}

//你同样可以通过写一个扩展来遵循一个特定的协议:

extension Entities: CustomStringConvertible {
    var description: String {
        switch self {
        case let .Soldier(x, y): return "\(x), \(y)"
        case let .Tank(x, y): return "\(x), \(y)"
        case let .Player(x, y): return "\(x), \(y)"
        }
    }
}


extension CGSize: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        let size = NSCoder.cgSize(for: value)
        self.init(width: size.width, height: size.height)
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        let size = NSCoder.cgSize(for: value)
        self.init(width: size.width, height: size.height)
    }
    
    public init(unicodeScalarLiteral value: String) {
        let size = NSCoder.cgSize(for: value)
        self.init(width: size.width, height: size.height)
    }
}

enum Devices: CGSize {
    case iPhone3GS = "{320, 480}"
    case iPhone5 = "{320, 568}"
    case iPhone6 = "{375, 667}"
    case iPhone6Plus = "{414, 736}"
}

let a = Devices.iPhone5
let b = a.rawValue
print("the phone size string is \(a), width is \(b.width), height is \(b.height)")
// prints : the phone size string is iPhone5, width is 320.0, height is 568.0


//enum APIError : ErrorType {
//    typealias RawValue = <#type#>
//
//    typealias RawValue = <#type#>
//
//    // Can't connect to the server (maybe offline?)
//    case ConnectionError(error: NSError)
//    // The server responded with a non 200 status code
//    case ServerError(statusCode: Int, error: NSError)
//    // We got no data (0 bytes) back from the server
//    case NoDataError
//    // The server response can't be converted from JSON to a Dictionary
//    case JSONSerializationError(error: ErrorType)
//    // The Argo decoding Failed
//    case JSONMappingError(converstionError: DecodeError)
//}

//enum JSON {
//    case JSONString(Swift.String)
//    case JSONNumber(Double)
//    case JSONObject([String : J])
//    case JSONArray([JSON])
//    case JSONBool(Bool)
//    case JSONNull
//}

enum CellType: String {
    case ButtonValueCell = "ButtonValueCell"
    case UnitEditCell = "UnitEditCell"
    case LabelCell = "LabelCell"
    case ResultLabelCell = "ResultLabelCell"
}


//单位
//单位以及单位转换是另一个使用枚举的绝佳场合。可以将单位及其对应的转换率映射起来，然后添加方法来对单位进行自动的转换。以下是一个相当简单的示例：

enum Liquid: Float {
    case ml = 1.0
    case l = 1000.0
    func convert(amount: Float, to: Liquid) -> Float {
        if self.rawValue < to.rawValue {
            return (self.rawValue / to.rawValue) * amount
        } else {
            return (self.rawValue * to.rawValue) * amount
        }
    }
}
// Convert liters to milliliters
print (Liquid.l.convert(amount: 5, to: Liquid.ml))
//另一个示例是货币的转换。以及数学符号(比如角度与弧度)也可以从中受益。



enum Media {
    case Book(title: String, author: String, year: Int)
    case Movie(title: String, director: String, year: Int)
    case WebSite(url: URL, title: String)
}

extension Media {
    var mediaTitle: String {
        switch self {
        case .Book(title: let aTitle, author: _, year: _):
            return aTitle
        case .Movie(title: let aTitle, director: _, year: _):
            return aTitle
        case .WebSite(url: _, title: let aTitle):
            return aTitle
        }
    }
}

let book = Media.Book(title: "20,000 leagues under the sea", author: "Jules Verne", year: 1870)
book.mediaTitle

let count = 7
switch count {
case Int.min..<0: print("Negative count, really?")
case 0: print("Nothing")
case 1: print("One")
case 2..<5: print("A few")
case 5..<10: print("Some")
default: print("Many")
}

func charType(car: Character) -> String {
    switch car {
    case "A", "E", "I", "O", "U", "Y", "a", "e", "i", "o", "u", "y":
        return "Vowel"
    case "A"..."Z", "a"..."z":
        return "Consonant"
    default:
        return "Other"
    }
}
print("Jules Verne".map(charType))




protocol Medium {
    var title: String { get }
}
struct Book: Medium {
    let title: String
    let author: String
    let year: Int
}
struct Movie: Medium {
    let title: String
    let director: String
    let year: Int
}
struct WebSite: Medium {
    let url: NSURL
    let title: String
}

// And an array of Media to switch onto
let media: [Medium] = [
    Book(title: "20,000 leagues under the sea", author: "Jules Vernes", year: 1870),
    Movie(title: "20,000 leagues under the sea", director: "Richard Fleischer", year: 1955)
]


for medium in media {
    // The title part of the protocol, so no need for a switch there
    print(medium.title)
    // But for the other properties, it depends on the type
    switch medium {
    case let b as Book:
        print("Book published in \(b.year)")
    case let m as Movie:
        print("Movie released in \(m.year)")
    case is WebSite:
        print("A WebSite with no date")
    default:
        print("No year info for \(medium)")
    }
}

func test() {
    fatalError("test")
//    var a = 1 // 警告：Will never be executed
//    a = a + 1
}

//test()


enum MediaA{
    case Book(title: String, author: String, year: Int)
    case Movie(title: String, director: String, year: Int)
    case WebSite(urlString: String)
}

let m = MediaA.Movie(title: "Captain America: Civil War", director: "Russo Brothers", year: 2016)

if case let MediaA.Movie(title, _, _) = m {
    print("This is a movie named \(title)")
}

//改用 switch 后更冗长的版本：
switch m {
case let MediaA.Movie(title, _, _):
    print("This is a movie named \(title)")
default: () // do nothing, but this is mandatory as all switch in Swift must be exhaustive
}


if case let MediaA.Movie(_, _, year) = m, year < 1888 {
    print("Something seems wrong: the movie's year is before the first movie ever made.")
}


enum NetworkResponse {
    case Response(URLResponse, Data)
    case Error(Error)
}

func processRequestResponse(response: NetworkResponse) {
    guard case let .Response(urlResp, data) = response,
        let httpResp = urlResp as? HTTPURLResponse, 200..<300 ~= httpResp.statusCode else {
            print("Invalid response, can't process")
            return
    }
    print("Processing \(data.count) bytes…")
    /* … */
}

let mediaList: [Media] = [
    .Book(title: "Harry Potter and the Philosopher's Stone", author: "J.K. Rowling", year: 1997),
    .Movie(title: "Harry Potter and the Philosopher's Stone", director: "Chris Columbus", year: 2001),
    .Book(title: "Harry Potter and the Chamber of Secrets", author: "J.K. Rowling", year: 1999),
    .Movie(title: "Harry Potter and the Chamber of Secrets", director: "Chris Columbus", year: 2002),
    .Book(title: "Harry Potter and the Prisoner of Azkaban", author: "J.K. Rowling", year: 1999),
    .Movie(title: "Harry Potter and the Prisoner of Azkaban", director: "Alfonso Cuarón", year: 2004),
    .Movie(title: "J.K. Rowling: A Year in the Life", director: "James Runcie", year: 2007),
//    .WebSite(url: (URL(string:"https://en.wikipedia.org/wiki/List_of_Harry_Potter-related_topics" ) ?? URL(string:"bad"), title: "")
]

print("Movies only:")
for case let Media.Movie(title, _, year) in mediaList {
    print(" - \(title) (\(year))")
}

print("Movies by C. Columbus only:")
for case let Media.Movie(title, director, year) in mediaList where director == "Chris Columbus" {
    print(" - \(title) (\(year))")
}




extension Media {
    var title: String? {
        switch self {
        case let .Book(title, _, _): return title
        case let .Movie(title, _, _): return title
        default: return nil
        }
    }
    var kind: String {
        /* Remember part 1 where we said we can omit the `(…)`
         associated values in the `case` if we don't care about any of them? */
        switch self {
        case .Book: return "Book"
        case .Movie: return "Movie"
        case .WebSite: return "Web Site"
        }
    }
}

print("All mediums with a title starting with 'Harry Potter'")
for case let (title?, kind) in mediaList.map({ ($0.title, $0.kind) })
    where title.hasPrefix("Harry Potter") {
        print(" - [\(kind)] \(title)")
}





