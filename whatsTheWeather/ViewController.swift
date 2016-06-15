//
//  ViewController.swift
//  whatsTheWeather
//
//  Created by Kaylan Smith on 6/12/16.
//  Copyright © 2016 Kaylan Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityTextField: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        
        // get a simple forecast first
        
        
        var wasSuccessful = false
        
        // concatenate string to city
        // replace space for cities like "San Francisco"
        let attemptedURL = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attemptedURL {
        
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                
                if let urlContent = data {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    // grab from browser, View Pages Source
                    
                    // components separated by string
                    // put "\" before internal quotes to knock them out
                    let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    
                    
                    // make sure there is website content first
                    if websiteArray.count > 1 {
                        
                        
                        let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                        
                        
                        if weatherArray.count > 1 {
                            
                            wasSuccessful = true
                            
                            let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                            
                            // bc we are updating UI
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                self.resultLabel.text = weatherSummary
                                
                                self.resultLabel.textColor = UIColor(red: 0.0, green: 0.004, blue: 0.502, alpha: 1.0)

                                
                            })
                            
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                }
                
                if wasSuccessful == false {
                    
                    self.resultLabel.text = "Couldn't find the weather for that city. Please try again."
                    
                    self.resultLabel.textColor = UIColor(red: 0.502, green: 0.004, blue: 0.0, alpha: 1.0)
                    
                }
                
            }
            
            task.resume()
            
        } else {
            
            self.resultLabel.text = "Couldn't find the weather for that city. Please try again."
            
            self.resultLabel.textColor = UIColor(red: 0.502, green: 0.004, blue: 0.0, alpha: 1.0)


            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

