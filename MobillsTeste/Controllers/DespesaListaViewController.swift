//
//  DespesaListaViewController.swift
//  MobillsTeste
//
//  Created by Lucas Inocencio on 21/05/21.
//

import UIKit
import Firebase

class DespesaListaViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var despesas = [Despesa]()
    
    var despesaListener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        recuperarDespesas()
    }
    
    func recuperarDespesas() {
        let db = Firestore.firestore()
        
        db.collection(REF_DESPESA).order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            
            self.despesas.removeAll()
            self.despesas = Despesa.parseData(snapshot: snapshot)
            self.tableView.reloadData()
        }
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "detalhesDespesaSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalhesDespesaSegue" {
            if let destinationVC = segue.destination as? DespesaViewController {
                if let despesa = sender as? Despesa {
                    destinationVC.despesa = despesa
                }
            }
        }
    }
    
}

extension DespesaListaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return despesas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = despesas[indexPath.row].descricao
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detalhesDespesaSegue", sender: despesas[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "Excluir", message: "Você quer excluir este item ?", preferredStyle: .actionSheet)

            let deleteAction = UIAlertAction(title: "Excluir despesa", style: .default) { (action) in
                let db = Firestore.firestore()
                
                db.collection("despesas").whereField("id", isEqualTo: self.despesas[indexPath.row].id).getDocuments { snapshot, error in
                    if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        for document in snapshot!.documents {
                            document.reference.delete()
                        }
                    }
                }
                
                self.despesas.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }

            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(deleteAction)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }
    
}

extension DespesaListaViewController: UITableViewDelegate {}
