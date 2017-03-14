//
//  PersonalizeViewController.swift
//  Cheers
//
//  Created by Minna Xiao on 3/13/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

import UIKit

class PersonalizeViewController: UIViewController {

    @IBOutlet weak var goOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func goingOut(_ sender: UIButton) {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
