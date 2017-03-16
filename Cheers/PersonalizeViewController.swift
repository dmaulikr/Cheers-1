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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //setupDicts()
        
        self.circularSlider.textfield.isUserInteractionEnabled = false
        self.circularSlider.centeredView.layer.borderWidth = 0.0
        self.circularSlider.centeredView.layer.borderColor = UIColor.white.cgColor
        
        self.goOutButton.layer.cornerRadius = 5
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateLabels(notification:)), name: Notification.Name(rawValue: "drinkLimitChange"), object: nil)
        
    }
    
    func updateLabels(notification: Notification) {
        let newDrinkLimit = Int(self.circularSlider.value)
        let bac = BacInfo.drinkToBACDict[newDrinkLimit]
        let colorHex = BacInfo.BACToColorDict[bac!]
        self.bacLabel.text = bac
        self.bacLabel.textColor = UIColor(hex: colorHex!)
        self.effectLabel.text = BacInfo.BACToEffectDict[bac!]
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
    
    private func saveDrinkLimit() {
        self.drinkLimit = Int(ceil(self.circularSlider.value))
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
