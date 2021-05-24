//
//  DespesaViewController.swift
//  MobillsTeste
//
//  Created by Lucas Inocencio on 21/05/21.
//

import UIKit
import Firebase

class DespesaViewController: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var tfValor: UITextField!
    @IBOutlet weak var tfDescricao: UITextView!
    @IBOutlet weak var swEstaPago: UISwitch!
    
    var despesa: Despesa!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let despesa = despesa {
            tfValor.text = String(despesa.valor)
            tfDescricao.text = despesa.descricao
            swEstaPago.setOn(despesa.pago, animated: true)
        }
        
        setupView()
    }
    
    func setupView() {
        let borderColor : UIColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        tfDescricao.layer.borderWidth = 0.5
        tfDescricao.layer.borderColor = borderColor.cgColor
        tfDescricao.layer.cornerRadius = 5.0
    }
    
    
    @IBAction func saveBtnTapper(_ sender: UIButton) {
        guard let valor = tfValor.text, tfValor.text != "" else { return }
        guard let descricao = tfDescricao.text, tfDescricao.text != "" else { return }
        let estaPago = swEstaPago.isOn
        
        if (despesa == nil) {
            CadastrarDespesa.shared.cadastrar(valor: Double(valor)!, descricao: descricao, estaPago: estaPago)
        } else {
            let db = Firestore.firestore()
            
            guard let userID = Auth.auth().currentUser?.uid else { return }
            
            let dict: [String : Any] = [
                "valor": valor,
                "descricao": descricao,
                "estaPago": estaPago,
                "data": Timestamp(date: Date())
            ]
            
//            guard let id = despesa.id else { return }
//            
//            db.collection("despesas").document(userID).collection("despesas\(userID)").document().updateData(dict) { err in
//                if let err = err {
//                    print(err.localizedDescription)
//                } else {
//                    print("Atualizado")
//                }
//            }
        }
        
        
        
        tfValor.text = ""
        tfDescricao.text = ""
        
        self.navigationController?.popViewController(animated: true)
    }
    
}


// https://stackoverflow.com/questions/29782982/how-to-input-currency-format-on-a-text-field-from-right-to-left-using-swift
