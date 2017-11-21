//
//  StringExtension.swift
//  LBSwiftDemo
//
//  Created by admin on 17/7/13.
//  Copyright © 2017年 YunChuangCheLian. All rights reserved.
//

import Foundation
import UIKit


extension String {
    
    
    /// 返回字符串长度
    func length() -> Int {
        
        let str = self as NSString
        return (str.length)
    }
 
}
