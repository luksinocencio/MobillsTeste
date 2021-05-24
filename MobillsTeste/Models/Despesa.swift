//
//  Despesa.swift
//  MobillsTeste
//
//  Created by Lucas Inocencio on 21/05/21.
//

import Foundation
import Firebase

class Despesa {
    var id: String?
    var valor: Double
    var descricao: String
    var timestamp: Timestamp!
    var pago: Bool
    var userId: String?
    
    init (valor: Double, descricao: String, timestamp: Timestamp!, pago: Bool, id: String, userId: String) {
        self.valor = valor
        self.descricao = descricao
        self.timestamp = timestamp
        self.pago = pago
        self.id = id
        self.userId = userId
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> [Despesa] {
        var despesas = [Despesa]()
        
        guard let snap = snapshot else { return despesas }
        
        for document in snap.documents {
            let dados = document.data()
            
            let valor = dados["valor"] as? Double ?? 0.0
            let descricao = dados["descricao"] as? String  ?? ""
            let timestamp = dados["timestamp"] as? Timestamp ?? Timestamp(date: Date())
            let pago = dados["pago"] as? Bool ?? false
            let id = dados["id"] as? String ?? ""
            let userId = dados["userId"] as? String ?? ""

            let novaDespesa = Despesa(valor: valor, descricao: descricao, timestamp: timestamp, pago: pago, id: id, userId: userId)
            
            despesas.append(novaDespesa)
        }
        
        return despesas
    }
    
}


