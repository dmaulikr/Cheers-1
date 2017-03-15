//
//  FriendProfileViewController.swift
//  Cheers
//
//  Created by Minna Xiao on 3/14/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

import UIKit
import MessageUI

class FriendProfileViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    // MARK: - Properties
    var friend: DrinkingBuddy?
    
    
    // MARK: - Outlets
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var textButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var bacView: UIView!

    
    @IBAction func dismissProfile(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func messageFriend(_ sender: UIButton) {
        if MFMessageComposeViewController.canSendText(){
            let msg:MFMessageComposeViewController=MFMessageComposeViewController()
            let number = [friend!.phone]
            msg.recipients = number
            msg.body="are you okay?"
            msg.messageComposeDelegate = self
            self.present(msg,animated:true,completion:nil)
        }
        else {
            NSLog("your device do not support SMS....")
        }
    }
    
    @IBAction func callFriend(_ sender: UIButton) {
        
        let number = friend!.phone
        //@available(iOS 10.0, *)
        guard let no = URL(string: "telprompt://" + number) else { return }
        
        UIApplication.shared.open(no, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = friend?.name
        
        setupUI()
    }
    
    private func setupUI() {
        self.bacView.layer.cornerRadius = 12
        self.bacView.clipsToBounds = true
        self.bacView.layer.borderWidth = 1.0
        self.bacView.layer.borderColor = UIColor.gray.cgColor
    }
    
    
    // MARK: - MFMessageComposeViewControllerDelegate
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            print("Message was cancelled")
            controller.dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            controller.dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            controller.dismiss(animated: false, completion: nil)
        }
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