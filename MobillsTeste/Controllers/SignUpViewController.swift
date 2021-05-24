//
//  SignUpViewController.swift
//  MobillsTeste
//
//  Created by Lucas Inocencio on 21/05/21.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        guard let nome = tfName.text, tfName.text != "" else { return }
        guard let email = tfEmail.text, tfEmail.text != "" else { return }
        guard let senha = tfPassword.text, tfPassword.text != "" else { return }
        
        Auth.auth().createUser(withEmail: email, password: senha) { (result, error) in
            if let error = error {
                debugPrint("Error creating user: \(error.localizedDescription)")
            }
            
            guard let uid = result?.user.uid else { return }
            
            let data: [String: Any] = [
                "id": uid,
                "nome": nome,
                "cadastrado": Timestamp(date: Date()),
                "email": email
            ]
            
            Firestore.firestore().collection("users").document(uid).setData(data, completion: { (error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                } else {
                    print("Deu certo")
                }
            })
        }
    }
    
}
