//
//  ViewController.swift
//  CoolExtensionContainer
//
//  Created by Cory Alder on 2015-07-29.
//  Copyright (c) 2015 Cory Alder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func shareButtonAction(sender: AnyObject) {
//        
//        let activityController = UIActivityViewController(activityItems: ["Share this txt pls"], applicationActivities: nil)
//        
//        
//        self.presentViewController(activityController, animated: true, completion: nil)
        let defaults = NSUserDefaults(suiteName: "group.lighthouselabs.colors")
        
        defaults?.setValue("Hello World", forKey: "test")
        
        defaults?.synchronize()

    }
}

