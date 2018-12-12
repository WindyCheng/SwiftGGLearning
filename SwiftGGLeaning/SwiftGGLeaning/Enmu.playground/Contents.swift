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

