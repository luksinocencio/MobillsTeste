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
            print(despesa)
            tfValor.text = String(despesa.valor)
            tfDescricao.text = despesa.descricao
            swEstaPago.setOn(despesa.pago, animated: false)
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
            let dict: [String : Any] = [
                "valor": Double(valor)!,
                "descricao": descricao,
                "estaPago": estaPago,
                "timestampe": Timestamp(date: Date())
            ]
            
            DB_REF_DESPESA.whereField("id", isEqualTo: despesa.id).getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in snapshot!.documents {
                        document.reference.updateData(dict) { error in
                            if let error = error {
                                debugPrint(error.localizedDescription)
                            } else {
                                print("Deu certo")
                            }
                        }
                    }
                }
            }
        }
        
        tfValor.text = ""
        tfDescricao.text = ""
        
        self.navigationController?.popViewController(animated: true)
    }
}
