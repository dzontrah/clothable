//
//  ViewController.swift
//  clothable
//
//  Created by Nikola Jeremic on 15.3.22..
//

import UIKit
import SwiftUI
import Lottie

class OutfitViewController: UIViewController {
    
    
    
    @IBOutlet weak var animationView: AnimationView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var clothableLabel: UILabel!
    
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
        setupAnimation()
     
        
        clothableLabel.text = ""
        var charIndex = 0.0
        let titleText = "clothable"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.clothableLabel.text?.append(letter)
            }
            charIndex += 1
        }
        
    }
    func setupAnimation(){
        animationView.animation = Animation.named("97834-t-shirt")
        animationView.frame = view.frame
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()
    }

}



