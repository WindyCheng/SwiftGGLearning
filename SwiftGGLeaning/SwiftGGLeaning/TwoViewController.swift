//
//  TwoViewController.swift
//  SwiftGGLeaning
//
//  Created by WindyCheng on 2018/12/14.
//  Copyright © 2018 WindyCheng. All rights reserved.
//

import UIKit
import Foundation

protocol Shakeable { }

// 你可以只为 UIView 添加 shake 方法！
extension Shakeable where Self: UIView {
    
    // shake 方法的默认实现
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4.0, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
}

class FoodImageView: UIImageView, Shakeable {
    // 其他自定义写在这儿
}

class ActionButton: UIButton, Shakeable {
    // 其他自定义写在这儿
}

class TwoViewController: UIViewController,Shakeable {
    
    @IBOutlet weak var foodImageView: UIImageView!
    
    @IBOutlet weak var actionButton: UIButton!
    
    @IBAction func onShakeButtonTap(_ sender: Any) {
//        foodImageView.shake()
//        actionButton.shake()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
