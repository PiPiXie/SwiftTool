//
//  ViewController.swift
//  PPXTextView
//
//  Created by admin on 17/11/21.
//  Copyright © 2017年 PPX. All rights reserved.
//

import UIKit

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let SCREEN_WIDTH = UIScreen.main.bounds.size.width


class ViewController: UIViewController {
    
    /// 提交
    let submitBtn = UIButton.init(type: .custom)
    
    /// 输入框
    let contentView: PPXTextView! = PPXTextView()
    
    /// 输入字数个数label
    let inputNumLabel: UILabel! = UILabel()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    
    /// 初始化一些视图设置
    func setupView() {
        

        /// 输入框
        self.contentView.frame = CGRect.init(x: 15, y: 50, width: SCREEN_WIDTH-30, height: 140)
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.setupView()
        self.contentView.maxNumber = 10
        self.contentView.textDidChangedBlock = { (string) in
            self.inputNumLabel.text = "\(string.length())" + "/" + "\(self.contentView.maxNumber!)"
            
            self.submitBtn.isEnabled = (string.length() != 0)
        }
        self.view.addSubview(self.contentView)
        
        
        /// 输入字数个数label
        self.inputNumLabel.frame = CGRect.init(x: 15, y: 250, width: SCREEN_WIDTH-30, height: 16)
        self.inputNumLabel.textAlignment = .right
        self.inputNumLabel.text = "0/"  + "\(self.contentView.maxNumber!)"
        self.inputNumLabel.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(self.inputNumLabel)
        
        
        
        
        submitBtn.frame = CGRect.init(x: 50, y: 300, width: SCREEN_WIDTH-100, height: 40)
        submitBtn.setTitle("提    交", for: .normal)
        submitBtn.setTitleColor(UIColor.white, for: .normal)
        submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        submitBtn.layer.cornerRadius = 5.0
        submitBtn.layer.masksToBounds = true
        submitBtn.setBackgroundImage(UIImage.init(named: "btn_bg_def"), for: .normal)
        submitBtn.setBackgroundImage(UIImage.init(named: "btn_bg_pre"), for: .highlighted)
        submitBtn.setBackgroundImage(UIImage.init(named: "btn_bg_nonick"), for: .disabled)
        submitBtn.addTarget(self, action: #selector(didRightItemWithTextView), for: .touchUpInside)
        submitBtn.isEnabled = false
        self.view.addSubview(submitBtn)
    }
    
    
    
    func didRightItemWithTextView() {
        
        print("didRightItemWithTextView")
    }
}

