//
//  PPXTextField.swift
//  PPXTextField
//
//  Created by admin on 17/11/22.
//  Copyright © 2017年 PPX. All rights reserved.
//

import UIKit


typealias TextDidChangedBlock = (String) -> Void


class PPXTextField: UITextField, UITextFieldDelegate {

    /// 最大输入数字
    var maxNumber: Int! = 99999
    
    /// 文本变化回调
    var textDidChangedBlock: TextDidChangedBlock?
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.setupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.setupView()
    }
    
    
    func setupView() {
        
        self.delegate = self
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.font = UIFont.systemFont(ofSize: 16)
        if self.text == nil {
            self.text = ""
        }
    }
    
    
    // MARK:- editingChanged
    func textFieldDidChange(textField: UITextField) {
        
        
        //没有候选字符,拼音输入中
        if self.markedTextRange == nil {
            
            let text = (textField.text ?? "") as NSString
//            let text = textField.text as NSString
            
            if (text.length > self.maxNumber) {
                
                // 记录光标位置
                let selectRange = textField.selectedTextRange
                
                // 防止最后一位是emoji表情
                let rangeIndex = text.rangeOfComposedCharacterSequence(at: self.maxNumber)
                
                if  rangeIndex.length == 1 {
                    
                    textField.text = text.substring(to: self.maxNumber)
                }else {
                    if self.maxNumber == 1 {
                        textField.text = ""
                    }else {
                        textField.text = text.substring(to: self.maxNumber-1)
                    }
                }
                
                // 重新设置光标位置
                let beginning = self.beginningOfDocument
                var startOffset = self.offset(from: beginning, to: (selectRange?.start)!)
                var endOffset = self.offset(from: beginning, to: (selectRange?.end)!)
                if startOffset > (textField.text?.length())! {
                    startOffset = (textField.text?.length())!
                }
                if endOffset > (textField.text?.length())! {
                    endOffset = (textField.text?.length())!
                }
                let startPosition = self.position(from: beginning, offset: startOffset)
                let endPosition = self.position(from: beginning, offset: endOffset)
                let range = self.textRange(from: startPosition!, to: endPosition!)
                self.selectedTextRange = range
            }
            

            self.textDidChangedBlock?(textField.text!)
        }
    }
    
    
    // MARK:- UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if (string == "") {
            return true
        }
        
        let jointStr = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        
        let remainNumber = maxNumber - jointStr.length()
        
        //当没有候选字符,且字数超过限制时，输入无效
        if self.markedTextRange == nil  && remainNumber < 0 {
            return false
        }else {
            return true
        }
    }
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
