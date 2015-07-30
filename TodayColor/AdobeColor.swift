//
//  AdobeColor.swift
//  Fleek
//
//  Created by Cory Alder on 2015-07-29.
//  Copyright (c) 2015 Cory Alder. All rights reserved.
//

import UIKit


class ColorFinder {
    static func colorFromSwatch(swatchValues: [NSNumber]) -> UIColor {
        if (swatchValues.count < 3) {
            return UIColor.clearColor()
        }
        
        let r = CGFloat(swatchValues[0].doubleValue)
        let g = CGFloat(swatchValues[1].doubleValue)
        let b = CGFloat(swatchValues[2].doubleValue)
        
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    
    static func getColors(completion: ((UIColor, UIColor)) -> (Void)) {
        
        
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: NSURL(string:"https://color.adobe.com/api/v2/themes?filter=public&startIndex=36&maxNumber=36&sort=like_count&time=week")!)
        
        request.setValue("7810788A1CFDC3A717C58F96BC4DD8B4", forHTTPHeaderField: "x-api-key")
        request.setValue("application/javascript", forHTTPHeaderField: "ContentType")
        
        let task = session.dataTaskWithRequest(request as NSURLRequest) { data, response, error in
            
            if let d = data,
                let json = NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.allZeros, error: nil) as? [ String: AnyObject ],
                let themes = json["themes"] as? [[String : AnyObject]]
            {
                
                let swatchSets = themes
                    .map { $0["swatches"] as? [[String : AnyObject]] }
                    .filter { $0 != nil }
                    .map { $0! }
                    .sorted { a, b in return arc4random() > arc4random() }
                
                if let topSwatches = swatchSets.first,
                    let firstSwatch = topSwatches.first,
                    let firstValueSet = firstSwatch["values"] as? [NSNumber],
                    let lastSwatch = topSwatches.last,
                    let lastValueSet = lastSwatch["values"] as? [NSNumber]
                {
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        let c1 = self.colorFromSwatch(firstValueSet)
                        let c2 = self.colorFromSwatch(lastValueSet)
                        
                        completion((c1, c2))
                    }
                    
                }
                
                
                
            }
            
            
        }
        
        task.resume()
    }
}
