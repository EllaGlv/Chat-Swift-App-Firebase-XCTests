//
//  WelcomeViewController.swift
//  Chat
//
//  Created by Alla Golovinova on 02.10.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    
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
        
        // Animation: Typing title
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = K.appName
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            for letter in titleText {
                Timer.scheduledTimer(withTimeInterval: 0.05 * charIndex, repeats: false) { (timer) in
                    self.titleLabel.text?.append(letter)
                }
                charIndex += 1
            }
        }
    }
}
