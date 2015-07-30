//
//  TodayViewController.swift
//  TodayColor
//
//  Created by Cory Alder on 2015-07-29.
//  Copyright (c) 2015 Cory Alder. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    
        
    }
    
    @IBOutlet weak var moreButton: UIButton!
    @IBAction func moreButtonAction(sender: AnyObject) {
        
        let url = NSURL(string: "http://google.com")!
        
        self.extensionContext?.openURL(url, completionHandler: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        
        let defaults = NSUserDefaults(suiteName: "group.lighthouselabs.colors")
        
        
        print(defaults?.valueForKey("test"))
        
        ColorFinder.getColors { c1, c2 in
            
            self.view.backgroundColor = c1
            self.moreButton.tintColor = c2
            
            completionHandler(NCUpdateResult.NewData)
        }
        
        
    }

    
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
}
