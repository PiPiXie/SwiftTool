//
//  ViewController.swift
//  PPXTextField
//
//  Created by admin on 17/11/22.
//  Copyright © 2017年 PPX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textField: PPXTextField!
    
    
    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.textField.maxNumber = 10
        self.textField.textDidChangedBlock = { (string) in
            
            self.contentLabel.text = string
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

