//
//  SignInViewController.swift
//  MobillsTeste
//
//  Created by Lucas Inocencio on 21/05/21.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
        }
    }
    
    
    @IBAction func signInTapped(_ sender: UIButton) {
        guard let email = tfEmail.text, tfEmail.text != "" else { return }
        guard let password = tfPassword.text, tfPassword.text != "" else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Error signing in: \(error)")
            } else {
                self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
            }
        }
    }
    
}
