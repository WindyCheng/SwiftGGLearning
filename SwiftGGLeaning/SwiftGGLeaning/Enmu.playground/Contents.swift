import UIKit

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



