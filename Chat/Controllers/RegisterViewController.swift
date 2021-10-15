//
//  RegisterViewController.swift
//  Chat
//
//  Created by Alla Golovinova on 02.10.2021.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var toSignInLabel: UILabel!
    
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
        
        // Gesture recognizer attribited Sign In Label
        let attString = NSMutableAttributedString()
        let atributesForRedSingIn = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor(red: 0.949, green: 0.502, blue: 0.502, alpha: 1)]
        attString.append(NSAttributedString(string: "Have an account? ", attributes: nil))
        attString.append(NSAttributedString(string: "Sign In", attributes: atributesForRedSingIn))
        toSignInLabel.attributedText = attString
        let tap = UITapGestureRecognizer(target: self, action: #selector(singInTapped))
        toSignInLabel.isUserInteractionEnabled = true
        toSignInLabel.addGestureRecognizer(tap)
        
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
    
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        //Validate the fields
        if let email = emailTextfield.text, let password = passwordTextfield.text, let username = usernameTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.errorLabel.text = e.localizedDescription
                }
                //Create the user
                else {
                    //User was created succesfully, now store the username
                    let db = Firestore.firestore()
                    
                    var ref: DocumentReference? = nil
                    ref = db.collection(K.FStore.collectionUserNames).addDocument(data: [
                        "name": username,
                        "uid": authResult!.user.uid
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }
                    //Navigate to ChatViewController
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                    
                }
                
            }
        }
    }
    
    @objc func singInTapped() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
