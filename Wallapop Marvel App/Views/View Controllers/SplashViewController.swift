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
        
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseIn) {
            self.logo.alpha = 1
            self.view.layoutIfNeeded()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: Constants.homeSegue, sender: self)
        }

    }
}

