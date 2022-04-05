//
//  ViewController.swift
//  clothable
//
//  Created by Nikola Jeremic on 15.3.22..
//

import UIKit
import SwiftUI

class OutfitViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.isNavigationBarHidden = true
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.isNavigationBarHidden = false
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            titleLabel.text = ""
            var charIndex = 0.0
            let titleText = "clothable"
            
            for letter in titleText {
                Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                    self.titleLabel.text?.append(letter)
                }
                charIndex += 1
            }
           
        }
        

    }


