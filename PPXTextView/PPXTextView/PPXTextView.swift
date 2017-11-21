//
//  PPXTextView.swift
//  PPXTextView
//
//  Created by admin on 17/11/21.
//  Copyright © 2017年 PPX. All rights reserved.
//

import UIKit


typealias TextDidChangedBlock = (String) -> Void


class PPXTextView: UITextView, UITextViewDelegate {

    /// 提示文本
    private let placeholderLabel: UILabel! = UILabel()
    
    /// 提示文本坐标
    private var placeHolderLabelInsets: UIEdgeInsets! = UIEdgeInsets()
    
    /// 行间距
    var verticalSpacing: Float! = 5.0
    
    /// 最大输入数字
    var maxNumber: Int! = 99999
    
    /// 文本变化回调
    var textDidChangedBlock: TextDidChangedBlock?
    
    
    /// 占位文字
    var placeholder: String! = "请输入文字!" {
        didSet {
            self.placeholderLabel.text = placeholder
        }
    }
    
    /// 占位文字颜色
    var placeholderColor: UIColor! = UIColor.gray {
        didSet {
            self.placeholderLabel.textColor = placeholderColor
        }
    }
    
    // MARK:- 重写一些set方法
    override var textContainerInset: UIEdgeInsets {
        didSet {
            //调整text内容边距
            super.textContainerInset = textContainerInset
            self.placeHolderLabelInsets = UIEdgeInsetsMake(textContainerInset.top, textContainerInset.left + 2, textContainerInset.bottom, textContainerInset.right + 2)
            self.setNeedsLayout()
        }
    }
    
    
    override var text: String! {
        didSet {
            super.text = text
        }
    }
    
    
    override var font: UIFont? {
        didSet {
            super.font = font
            self.placeholderLabel.font = font
        }
    }
    
    
    
    /// 不够成熟的初始化操作
    func setupView() {
        
        self.delegate = self
        self.font = UIFont.systemFont(ofSize: 16)
        self.placeholderLabel.text = self.placeholder
        self.placeholderLabel.textColor = self.placeholderColor
        self.placeholderLabel.font = self.font
        self.placeholderLabel.numberOfLines = 0
        self.addSubview(self.placeholderLabel)
    }
    
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.placeholderLabel.frame = CGRect.init(x: 6, y: self.textContainerInset.top, width: self.frame.size.width - 12, height: 0)
        self.placeholderLabel.sizeToFit()
    }
    
    
    
    // MARK:- UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        
        let jointStr = (textView.text as NSString).replacingCharacters(in: range, with: text)
        
        let remainNumber = maxNumber - jointStr.length()
        
        //当没有候选字符,且字数超过限制时，输入无效
        if self.markedTextRange == nil  && remainNumber < 0 {
            return false
        }else {
            return true
        }
    }
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.length() == 0 {
            self.placeholderLabel.isHidden = false
        }else {
            self.placeholderLabel.isHidden = true
        }
        
        
        //没有候选字符,拼音输入中 等
        if self.markedTextRange == nil {
            
            let text = textView.text as NSString
            
            if (text.length > self.maxNumber) {
                
                // 记录光标位置
                let selectRange = textView.selectedRange
                
                
                // 防止最后一位是emoji表情
                let rangeIndex = text.rangeOfComposedCharacterSequence(at: self.maxNumber)
                
                if  rangeIndex.length == 1 {
                    
                    textView.text = text.substring(to: self.maxNumber)
                }else {
                    if self.maxNumber == 1 {
                        textView.text = ""
                    }else {
                        textView.text = text.substring(to: self.maxNumber-1)
                    }
                }
                
                // 重新设置光标位置
                if selectRange.location > textView.text.length() {
                    textView.selectedRange = NSRange.init(location: textView.text.length(), length: 0)
                }else {
                    textView.selectedRange = selectRange
                }
            }
            
            self.st_setAttributedString()
            
            self.textDidChangedBlock?(textView.text)
        }
    }
    
    
    //设置属性字符串，主要是弄字体间距
    func st_setAttributedString() {
        //设置了间距
        if (self.verticalSpacing > 0) {
            
            if (self.text.length() > 0) {
                
                let range = self.selectedRange
                self.attributedText = NSAttributedString.init(string: self.text, attributes: self.attrs())
                self.selectedRange = range
            }
        }
    }
    
    
    func attrs() -> [String: Any]? {
        
        if self.verticalSpacing > 0 {
            
            let paragraphStyle = NSMutableParagraphStyle.init()
            paragraphStyle.lineSpacing = CGFloat(self.verticalSpacing)
            let attributes  = [NSFontAttributeName: self.font ?? UIFont.systemFont(ofSize: 16), NSParagraphStyleAttributeName:paragraphStyle] as [String : Any]
            return attributes
        }
        
        return nil
    }
    

}








