//
//  ViewController.swift
//  Roll Player Dice Helper
//
//  Created by Robert Biddle on 11/1/14.
//  Copyright (c) 2014 Robert Biddle. All rights reserved.
//

import UIKit
import iAd


class ViewController: UIViewController, ADBannerViewDelegate {

    @IBOutlet weak var textStatValue: UITextField!
    
    @IBOutlet weak var switchBonusFlag: UISwitch!
    @IBOutlet weak var switchPenaltyFlag: UISwitch!
    
    @IBOutlet weak var labelResults: UILabel!
    
    @IBOutlet weak var iAdBannerView: ADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.canDisplayBannerAds = true
        self.iAdBannerView.delegate = self
        self.iAdBannerView.hidden = true
        
    }

    func bannerViewWillLoadAd(banner: ADBannerView!) {
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        self.iAdBannerView.hidden = false
    }
    
    func bannerViewActionDidFinish(banner: ADBannerView!) {
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return true
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchBonusValueChanged(sender: UISwitch) {
        if switchBonusFlag.on == true {
            switchPenaltyFlag.setOn(false, animated: true)
        }
    }
    
    @IBAction func switchPenaltyValueChanged(sender: UISwitch) {
        if switchPenaltyFlag.on == true {
            switchBonusFlag.setOn(false, animated: true)
        }
    }
    
    @IBAction func buttonRollTouchUpInside(sender: UIButton) {
        
        var rollOnesPlace = Int(arc4random_uniform(9))
        var rollTensPlace = Int(arc4random_uniform(9))
        var rollExtraTens = Int(arc4random_uniform(9))
        var resultText: String!
        var result = 0
        
        if switchPenaltyFlag.on == true {
            // use extra die as penalty
            result = (min(rollTensPlace, rollExtraTens) * 10) + rollOnesPlace
            resultText = "You rolled: \(result) (\(rollTensPlace) for 10s; \(rollExtraTens) for Penalty)\n Result: ????"
            
        } else if switchBonusFlag.on == true {
            // use extra die as bonus
            result = (max(rollTensPlace, rollExtraTens) * 10) + rollOnesPlace
            resultText = "You rolled: \(result) (\(rollTensPlace) for 10s; \(rollExtraTens) for Bonus)\n Result: ????"
            
        } else {
            //ignore extra die
            result = (rollTensPlace * 10) + rollOnesPlace
            resultText = "You rolled: \(result)\n Result: ????"
            
        }
        
        labelResults.hidden = false
        labelResults.text = resultText
        
        textStatValue.resignFirstResponder()
    }

}

