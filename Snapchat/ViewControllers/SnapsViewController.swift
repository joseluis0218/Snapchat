//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Jose Cristobal on 30/05/19.
//  Copyright © 2019 Jose Cristobal. All rights reserved.
//

import UIKit
import Firebase
class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var snaps : [Snap] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        FIRDatabase.database().reference().child("usuarios").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            let snap = Snap()
            
            snap.imagenURL = (snapshot.value as! NSDictionary)["imagenURL"] as! String
            snap.from = (snapshot.value as! NSDictionary)["from"] as! String
            snap.descrip = (snapshot.value as! NSDictionary)["descripcion"] as! String
            snap.id = snapshot.key
            snap.imagenID = (snapshot.value as! NSDictionary)["imagenID"] as! String
            self.snaps.append(snap)
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0{
            return 1
        }
        else{
            return snaps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if snaps.count == 0{
            cell.textLabel?.text = "No tienes SNAPS 😰"
        }else{
            let snap = snaps[indexPath.row]
            cell.textLabel?.text = snap.from
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "versnapsegue", sender: snap)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "versnapsegue"{
            let siguienveVC = segue.destination as! VerSnapViewController
            siguienveVC.snap = sender as! Snap
        }
    }
    @IBAction func cerrarSessionTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
