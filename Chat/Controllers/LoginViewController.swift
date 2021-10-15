//
//  LoginViewController.swift
//  Chat
//
//  Created by Alla Golovinova on 02.10.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var toSignUpLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
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
        
        // Gesture recognizer attribited Sing Up Label
        let attString = NSMutableAttributedString()
        let atributesForRedSingUp = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor(red: 0.949, green: 0.502, blue: 0.502, alpha: 1)]
        attString.append(NSAttributedString(string: "Don’t have an account? ", attributes: nil))
        attString.append(NSAttributedString(string: "Sign Up", attributes: atributesForRedSingUp))
        toSignUpLabel.attributedText = attString
        let tap = UITapGestureRecognizer(target: self, action: #selector(singUpTapped))
        toSignUpLabel.isUserInteractionEnabled = true
        toSignUpLabel.addGestureRecognizer(tap)
        
        //attribited labels for email and password
        let atributesForRed = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor(red: 0.949, green: 0.502, blue: 0.502, alpha: 1)]
        let emailLabelattString = NSMutableAttributedString()
        emailLabelattString.append(NSAttributedString(string: "* ", attributes: atributesForRed))
        emailLabelattString.append(NSAttributedString(string: "Email", attributes: nil))
        emailLabelattString.append(NSAttributedString(string: "    (Required)", attributes: atributesForRed))
        emailLabel.attributedText = emailLabelattString
        let passwordLabelattString = NSMutableAttributedString()
        passwordLabelattString.append(NSAttributedString(string: "* ", attributes: atributesForRed))
        passwordLabelattString.append(NSAttributedString(string: "Password", attributes: nil))
        passwordLabelattString.append(NSAttributedString(string: "    (Required)", attributes: atributesForRed))
        passwordLabel.attributedText = passwordLabelattString
        
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                if let e = error {
                    self.errorLabel.text = e.localizedDescription
                    print(e)
                } else {
                    //Navigate to ChatViewController
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
    
    @objc func singUpTapped() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
