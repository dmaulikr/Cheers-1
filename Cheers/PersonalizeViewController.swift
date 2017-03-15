//
//  PersonalizeViewController.swift
//  Cheers
//
//  Created by Minna Xiao on 3/13/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

import UIKit
import CircularSlider

class PersonalizeViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var goOutButton: UIButton!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var circularSlider: CircularSlider!
    
    @IBOutlet weak var bacLabel: UILabel!
    
    @IBOutlet weak var effectLabel: UILabel!
    
    
    var drinkToBACDict = Dictionary<Int, String>()
    var BACToColorDict = Dictionary<String, String>() //bac to hexadecimal
    var BACToEffectDict = Dictionary<String, String>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupDicts()
        
        self.circularSlider.textfield.isUserInteractionEnabled = false
        self.circularSlider.centeredView.layer.borderWidth = 0.0
        self.circularSlider.centeredView.layer.borderColor = UIColor.white.cgColor
        
        self.goOutButton.layer.cornerRadius = 5
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateLabels(notification:)), name: Notification.Name(rawValue: "drinkLimitChange"), object: nil)
        
    }
    
    func updateLabels(notification: Notification) {
        let newDrinkLimit = Int(self.circularSlider.value)
        let bac = drinkToBACDict[newDrinkLimit]
        let colorHex = BACToColorDict[bac!]
        self.bacLabel.text = bac
        self.bacLabel.textColor = UIColor(hex: colorHex!)
        self.effectLabel.text = BACToEffectDict[bac!]
        self.effectLabel.textColor = UIColor(hex: colorHex!)
    }
    
    // MARK: - Properties
    var drinkLimit: Int = 0

    @IBAction func goingOut(_ sender: UIButton) {
        saveDrinkLimit()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let left = storyboard.instantiateViewController(withIdentifier: "left")
        let middle = storyboard.instantiateViewController(withIdentifier: "middle")
        let right = storyboard.instantiateViewController(withIdentifier: "right")
        let top = storyboard.instantiateViewController(withIdentifier: "top")
        // let bottom
        let snapContainer = SnapContainerViewController.containerViewWith(left, middleVC: middle, rightVC: right, topVC: top, bottomVC: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = snapContainer
        appDelegate.window?.makeKeyAndVisible()
        
    }
    
    private func setupDicts() {
        drinkToBACDict = [
            0:"0.00",
            1:"0.04",
            2:"0.07",
            3:"0.1",
            4:"0.13",
            5:"0.16",
            6:"0.19",
            7:"0.23",
            8:"0.27",
            9:"0.3",
            10:"0.33"
        ]
        
        BACToColorDict = [
            "0.00":"9AD145",
            "0.04":"9AD145",
            "0.07":"E7B90B",
            "0.1":"E7B90B",
            "0.13":"FF871D",
            "0.16":"FF871D",
            "0.19":"CC0F0F",
            "0.23":"CC0F0F",
            "0.27":"CC0F0F",
            "0.3":"CC0F0F",
            "0.33":"CC0F0F"
        ]
        
        BACToEffectDict = [
            "0.00":"SOBER",
            "0.04":"TIPSY",
            "0.07":"BUZZED",
            "0.1":"LEGALLY DRUNK",
            "0.13":"SLOPPY DRUNK",
            "0.16":"SLOPPY DRUNK",
            "0.19":"WASTED",
            "0.23":"WASTED",
            "0.27":"BLACKOUT",
            "0.3":"BLACKOUT",
            "0.33":"UNCONSCIOUS"
        ]
    }
    
    private func saveDrinkLimit() {
        self.drinkLimit = Int(self.circularSlider.value)
        UserInfo.drinkLimit = self.drinkLimit
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
