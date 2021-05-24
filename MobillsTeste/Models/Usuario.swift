//
//  Usuario.swift
//  MobillsTeste
//
//  Created by Lucas Inocencio on 24/05/21.
//

import Foundation
import Firebase

struct Usuario {
    var uid: String
    var nome: String
    var cadastro: Date
    var email: String
    
    init (uid: String, nome: String, cadastro: Date, email: String) {
        self.uid = uid
        self.nome = nome
        self.cadastro = cadastro
        self.email = email
    }
}
