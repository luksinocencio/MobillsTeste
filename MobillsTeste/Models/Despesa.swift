//
//  Despesa.swift
//  MobillsTeste
//
//  Created by Lucas Inocencio on 21/05/21.
//

import Foundation

class Despesa {
    var valor: Double
    var descricao: String
    var data: Data
    var pago: Bool
    
    init (valor: Double, descricao: String, data: Data, pago: Bool) {
        self.valor = valor
        self.descricao = descricao
        self.data = data
        self.pago = pago
    }
    
}
