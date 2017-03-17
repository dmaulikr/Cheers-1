//
//  FriendsViewController.swift
//  Cheers
//
//  Created by Minna Xiao on 3/9/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

import UIKit
import MapKit
import Foundation
import MessageUI

class FriendsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MFMessageComposeViewControllerDelegate, UIViewControllerPreviewingDelegate {
    
    // model
    var partyPeople: [DrinkingBuddy] = []
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var chatButton: UIButton!
    
    @IBOutlet weak var bounceButton: UIButton!
    
    @IBAction func goToManualTracker(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let snapContainer = appDelegate.window?.rootViewController as! SnapContainerViewController
        let manualTrackerViewOffset = snapContainer.leftVc.view.frame.origin
        snapContainer.scrollView.setContentOffset(manualTrackerViewOffset, animated: true)
    }
    
    @IBAction func goToMap(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let snapContainer = appDelegate.window?.rootViewController as! SnapContainerViewController
        let mapViewOffset = snapContainer.rightVc.view.frame.origin
        snapContainer.scrollView.setContentOffset(mapViewOffset, animated: true)
    }

    @IBAction func gotToMyProfile(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let snapContainer = appDelegate.window?.rootViewController as! SnapContainerViewController
        let myProfileViewOffset = snapContainer.middleVertScrollVc.topVc.view.frame.origin
        snapContainer.middleVertScrollVc.scrollView.setContentOffset(myProfileViewOffset, animated: true)
    }

    @IBAction func messageGroup(_ sender: UIButton) {
        if MFMessageComposeViewController.canSendText(){
            let msg:MFMessageComposeViewController=MFMessageComposeViewController()
            var numbers = [String]()
            for buddy in partyPeople {
                numbers.append(buddy.phone)
            }
            msg.recipients = numbers
            msg.body="Hi everyone!"
            msg.messageComposeDelegate = self
            self.present(msg,animated:true,completion:nil)
        }
        else {
            NSLog("your device do not support SMS....")
        }
    }
    
    @IBAction func bounce(_ sender: UIButton) {
        let title = "Going home now?"
        let message = "We'll notify your group"
        let popup = PopupDialog(title: title, message: message, image: nil)
        
        let button = DefaultButton(title: "BOUNCE") {
            UserInfo.clearData()
            self.performSegue(withIdentifier: "Reset", sender: self)
        }
        
        popup.addButtons([button])
        self.present(popup, animated: true, completion: nil)
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
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        partyPeople = DrinkingBuddy.getFriends()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateMyImage(notification:)), name: Notification.Name(rawValue: "bitmojiProfileChange"), object: nil)
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        } else {
            print("3D Touch Not Available")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        
    }
    
    func updateMyImage(notification: Notification) {
        partyPeople[2].image = UserInfo.myBitmoji
        //let indexPath = IndexPath(item: 2, section: 0)
        //collectionView.reloadItems(at: [indexPath])
        //print(partyPeople[2].image)
        self.collectionView.reloadData()
    }

    // Private
    private struct Constants {
        static let sectionInsets = UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // implement the fading collection view thing here maybe? or use a gradient mask
        
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return partyPeople.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.item == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupNameCell", for: indexPath)
            cell.backgroundColor = UIColor.white
            return cell
        }
        
        let index = indexPath.item - 1 //offset the first cell
        
        let buddy = partyPeople[index]
        if buddy.status == DrinkingBuddy.Status.dangerZone {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrunkFriendCell", for: indexPath) as! DrunkFriendCollectionViewCell
            cell.backgroundColor = UIColor.white
            cell.name = buddy.name
            cell.friend = buddy
            return cell
        
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as! FriendCollectionViewCell
            cell.backgroundColor = UIColor.white
            cell.name = buddy.name
            cell.friend = buddy
            
            if buddy.status == DrinkingBuddy.Status.left {
                cell.alpha = 0.4
            }
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // if it's the group name cell
        if (indexPath.item == 0) {
            let width = view.frame.width - (Constants.sectionInsets.left * 2)
            let height: CGFloat = 40.0
            return CGSize(width: width, height: height)
        }
        
        let index = indexPath.item - 1 //offset the first cell
        
        let buddy = partyPeople[index]
        var itemsInRow: CGFloat = 2.0
        var paddingSpace = Constants.sectionInsets.left * (itemsInRow + 1)
        var availableWidth = view.frame.width - paddingSpace
        let heightPerItem = availableWidth / itemsInRow
        
        if buddy.status == DrinkingBuddy.Status.dangerZone {
            itemsInRow = 1.0
            paddingSpace = Constants.sectionInsets.left * (itemsInRow + 1)
            availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsInRow
            return CGSize(width: widthPerItem, height: heightPerItem)
        }
        
        return CGSize(width: heightPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    // MARK: - UIViewControllerPreviewingDelegate
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = collectionView?.indexPathForItem(at: location) else { return nil }
        
        guard let cell = collectionView?.cellForItem(at: indexPath) else { return nil }
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "friendprofile") as? FriendProfileViewController else { return nil }
        
        let friend = partyPeople[indexPath.item-1]
        detailVC.friend = friend
        
        detailVC.preferredContentSize = CGSize(width: 0.0, height: 450)
        
        previewingContext.sourceRect = cell.frame
        
        return detailVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        show(viewControllerToCommit, sender: self)
        
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "Show Friend":
                if let destinationvc = segue.destination as? FriendProfileViewController {
                    if let friendCell = sender as? FriendCollectionViewCell {
                        destinationvc.friend = friendCell.friend
                    }
                }
            case "Show Drunk Friend":
                if let destinationvc = segue.destination as? FriendProfileViewController {
                    if let friendCell = sender as? DrunkFriendCollectionViewCell {
                        destinationvc.friend = friendCell.friend
                    }
                }
            default: break
            }
        }
    }

}
