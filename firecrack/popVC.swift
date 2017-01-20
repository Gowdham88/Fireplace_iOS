//
//  popVC.swift
//  firecrack
//
//  Created by Paramesh on 18/01/17.
//  Copyright © 2017 Paramesh. All rights reserved.
//

import UIKit

class popVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func closePopview(_ sender: Any) {
        
         dismiss(animated: true, completion: nil)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
