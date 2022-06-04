//
//  ViewController.swift
//  Wallapop Marvel App
//
//  Created by Mohamed Shendy on 03/06/2022.
//

import UIKit
import Spring

class SplashViewController: UIViewController {

    @IBOutlet weak var logo: SpringImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: Constants.homeSegue, sender: self)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        logo.isHidden = false
    }

}

