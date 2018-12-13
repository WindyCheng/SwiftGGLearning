//
//  ViewController.swift
//  SwiftGGLeaning
//
//  Created by WindyCheng on 2018/12/11.
//  Copyright © 2018 WindyCheng. All rights reserved.
//

import UIKit

//闭包一般是用来作为函数的参数。不过某些情况下，使用本地闭包也是十分方便的。
enum GUIMode {
    case Mode1
    case Mode2
}

class ViewController: UIViewController {
    
    
    var label1: UILabel!
    var label2: UILabel!
    var label3: UILabel!
    
  //  对于每一种 GUI 模式，我们都需要对三个 label 设置某些属性：
  //  在这种情况下使用闭包就是一个相当不错的解决方案：
    var guiMode: GUIMode = .Mode1 {
        didSet {
            let styleLabel: (_ label:UILabel,_ text:String,_ color:UIColor,_ size:CGFloat) -> () = { (label,text,color,size) in
                label.text = text
                label.textColor = color
                label.font = UIFont(name: "HelveticaNeue", size:size)
            }
            
            switch guiMode {
            case .Mode1:
                styleLabel(label1, "1", UIColor.red, 10)
                styleLabel(label2, "2", UIColor.blue, 12)
                styleLabel(label3, "3", UIColor.yellow,11)
            case .Mode2:
                styleLabel(label1, "4",  UIColor.yellow, 11)
                styleLabel(label2, "5",  UIColor.black, 9)
                styleLabel(label3, "6",   UIColor.brown, 10)
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

