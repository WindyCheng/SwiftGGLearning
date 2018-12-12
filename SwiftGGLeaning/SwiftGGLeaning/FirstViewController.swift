//
//  FirstViewController.swift
//  SwiftGGLeaning
//
//  Created by WindyCheng on 2018/12/11.
//  Copyright © 2018 WindyCheng. All rights reserved.
//

import UIKit


//在 Swift 编程中，最吸引我的就是能在文件中创建多个扩展。这使得我可以把互相关联的方法放在一起。比如每次我向控制器添加一个新协议时，就可以把这个协议的方法放在同一个扩展中。同理，TableView 相关的私有样式初始化方法或者私有 cell 初始化方法都可以放入各自的扩展中。
//
//美中不足的是，我们无法给扩展命名，只能使用//MARK:来标识各个扩展的位置。直到有一天，我向@allonsykraken提出了这个问题，他告诉我一种简单的实现方法——使用typealias!

//MARK:
class FirstViewController: UIViewController {

   // 优雅地设置 IBOutlets
//    @IBOutlet weak var myLabel: UILabel! {
//        didSet {
//            myLabel.textColor = UIColor.purpleColor()
//        }
//    }
//
//    @IBOutlet weak var myOtherLabel: UILabel! {
//        didSet {
//            myOtherLabel.textColor = UIColor.yellowColor()
//        }
//    }
//
//    @IBOutlet weak var myButton: UIButton! {
//        didSet {
//            myButton.tintColor = UIColor.magentaColor()
//        }
//    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "identifier")
    }
}


private typealias TableViewDataSource = FirstViewController
extension TableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        cell.textLabel?.text = String.init(format: "%d", indexPath.row)
        return cell
    }
}

private typealias TableViewDelegate = FirstViewController
extension TableViewDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
}

private typealias ViewStylingHelpers = FirstViewController
private extension ViewStylingHelpers {
    
    func styleNavigationBar() {
        // style navigation bar here
    }
}


extension UIImage {
    enum AssetIdentifier: String {
        // Image Names of Minions
        case Bob, Dave, Jorge, Jerry, Tim, Kevin, Mark, Phil, Stuart
    }
    
    convenience init!(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }
}

//这样，就可以通过以下的方式在任何需要的地方构建Image：

let minionBobImage = UIImage(assetIdentifier: .Bob)

//这个视频里解决的问题是方法UIImage:named:总需要传入硬编码(hard-coded)的字符串参数，然后返回一个可空(optional)的UIImage。这就意味着可能会有两种出错的情况：一种是字符串的拼写错误；另一种是对可选的UIImage不正确解包。
//
//一种可以解决这个字符串拼写错误的方式就是构建一个Image的常量文件，但是这不能解决出错的第二种情况。在 Swift 中，有个更好的解决方案。可以扩展UIImage，把所有的Image名字作为枚举类型，然后建立便利构造器来通过枚举构造对应的Image。看代码：
