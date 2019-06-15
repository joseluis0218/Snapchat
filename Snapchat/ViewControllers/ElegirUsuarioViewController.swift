//
//  ElegirUsuarioViewController.swift
//  Snapchat
//
//  Created by Jose Cristobal on 30/05/19.
//  Copyright © 2019 Jose Cristobal. All rights reserved.
//

import UIKit
import Firebase
class ElegirUsuarioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var usuarios : [Usuario] = []
    var imagenURL = ""
    var descrip = ""
    var imagenID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        FIRDatabase.database().reference().child("usuarios").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            
            let usuario = Usuario()
            usuario.email = (snapshot.value as! NSDictionary)["email"] as! String
            usuario.uid = snapshot.key
            self.usuarios.append(usuario)
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let usuario = usuarios[indexPath.row]
        cell.textLabel?.text = usuario.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usuario = usuarios[indexPath.row]
        let snap = ["from":FIRAuth.auth()?.currentUser!.email!, "descripcion":descrip,"imagenURL":imagenURL,"imagenID":imagenID]
        FIRDatabase.database().reference().child("usuarios").child(usuario.uid).child("snaps").childByAutoId().setValue(snap)
        navigationController?.popToRootViewController(animated: true)
    }
}
