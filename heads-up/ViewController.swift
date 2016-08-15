//
//  ViewController.swift
//  heads-up
//
//  Created by Espen Næss on 13.08.2016.
//  Copyright © 2016 Espen Næss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startknapp: UIButton!
    
    @IBAction func tilbake(segue : UIStoryboardSegue) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
}

