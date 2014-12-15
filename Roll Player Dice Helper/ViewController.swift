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
    
    @IBOutlet weak var labelRollDetails: UILabel!
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
        //return true
        return false
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
        textStatValue.resignFirstResponder()
    }
    
    @IBAction func switchPenaltyValueChanged(sender: UISwitch) {
        if switchPenaltyFlag.on == true {
            switchBonusFlag.setOn(false, animated: true)
        }
        textStatValue.resignFirstResponder()
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    @IBAction func statValueFieldEndEditing(sender: AnyObject) {
        textStatValue.resignFirstResponder()
    }
    
    @IBAction func buttonRollTouchUpInside(sender: UIButton) {
        
        var rollOnesPlace = Int(arc4random_uniform(9))
        var rollTensPlace = Int(arc4random_uniform(9))
        var rollExtraTens = Int(arc4random_uniform(9))
        var detailText: String = ""
        var resultText: String = ""
        var result = 0
        
        if textStatValue.text.toInt() == nil {
            textStatValue.text = "1"
        }
        if textStatValue.text == "" {
            textStatValue.text = "1"
        }
        if textStatValue.text.toInt() > 999 {
            textStatValue.text = "999"
        }
        if textStatValue.text.toInt() < 1 {
            textStatValue.text = "1"
        }
        
        let skillValue = textStatValue.text.toInt()!
        let halfValue = skillValue / 2
        let fifthValue = skillValue / 5
        
        if switchPenaltyFlag.on == true {
            // use extra die as penalty
            result = (max(rollTensPlace, rollExtraTens) * 10) + rollOnesPlace
            if result == 0 {
                result = 100
            }
            detailText = "Roll: \(result) \n(\(rollOnesPlace) for 1s; \(rollTensPlace) for 10s; \(rollExtraTens) for Penalty)"
            
        } else if switchBonusFlag.on == true {
            // use extra die as bonus
            result = (min(rollTensPlace, rollExtraTens) * 10) + rollOnesPlace
            if result == 0 {
                result = 100
            }
            detailText = "Roll: \(result) \n(\(rollOnesPlace) for 1s; \(rollTensPlace) for 10s; \(rollExtraTens) for Bonus)"
            
        } else {
            //ignore extra die
            result = (rollTensPlace * 10) + rollOnesPlace
            if result == 0 {
                result = 100
            }
            detailText = "Roll: \(result) \n(\(rollOnesPlace) for 1s; \(rollTensPlace) for 10s)"
        }
        
        if result <= fifthValue {
            // extreme success
            resultText += "Extreme Success!"
        } else if result <= halfValue {
            // hard success
            resultText += "Hard Success!"
        } else if result <= skillValue {
            // normal success
            resultText += "Normal Success!"
        } else {
            // failure
            resultText += "Failure!"
        }
        
        labelRollDetails.hidden = false
        labelRollDetails.text = detailText
        labelResults.hidden = false
        labelResults.text = resultText
        
        textStatValue.resignFirstResponder()
    }

}

