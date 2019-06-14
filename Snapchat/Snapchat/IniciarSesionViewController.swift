//
//  IniciarSesionViewController.swift
//  Snapchat
//
//  Created by Jose Cristobal on 29/05/19.
//  Copyright © 2019 Jose Cristobal. All rights reserved.
//

import UIKit
import Firebase
class IniciarSesionViewController: UIViewController {


    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func iniciarSessionTapped(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(user, error) in
            
            print("Intentamos Iniciar Sesiòn")
            print("Tenemos el siguiente error:\(String(describing: error))")
            print("-----------")
            if error != nil{
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user,error) in
                    print("Intentamos crear un usuario")
                    if error != nil{
                        
                        print("Tenemos el siguiente error:\(String(describing: error))")
                        print("EMAIL", self.emailTextField.text!)
                    }else{
                        print("El usuario fue creado exitosamente")
                    FIRDatabase.database().reference().child("usuarios").child(user!.uid).child("email").setValue(user!.email)
                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                    }
                })
            }else{
                print("Inicio de Sesiòn exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        })
    }
    
}

