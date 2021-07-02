//
//  FirstViewController.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 21/06/21.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard

        if let email = defaults.value(forKey: "email") as? String {
            //Utilizar un segue hasta inicio Chat
            performSegue(withIdentifier: "logueado", sender: self)
        }
        self.navigationController?.isNavigationBarHidden = true

    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}

