//
//  CriarDespesa.swift
//  MobillsTeste
//
//  Created by Lucas Inocencio on 24/05/21.
//

import UIKit
import Firebase

class CadastrarDespesa {
    
    static let shared = CadastrarDespesa()
    
    var userRef: DocumentReference!
    
    func cadastrar(valor: Double, descricao: String, estaPago: Bool) {
        
        let db = Firestore.firestore()

        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let dict: [String : Any] = [
            "valor": valor,
            "descricao": descricao,
            "estaPago": estaPago,
            "timestamp": Timestamp(date: Date()),
            "userId": userId
        ]
        
        
        db.collection("despesas").document(userId).collection("despesas-\(userId)")
            .document().setData(dict) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    
}

