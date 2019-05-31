//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Jose Cristobal on 30/05/19.
//  Copyright © 2019 Jose Cristobal. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func cerrarSessionTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
