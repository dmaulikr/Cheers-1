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

class FriendsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MFMessageComposeViewControllerDelegate {
    
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
            msg.body="hello"
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
        // image size is fucked up
        //let image = UIImage(named: "emily2")
        let popup = PopupDialog(title: title, message: message, image: nil)
        
        let button = DefaultButton(title: "BOUNCE") {
            print("button pressed")
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
        createFriends()
        
        /*guard let collectionView = collectionView else { return }
        collectionView.mask = GradientMaskView(frame: CGRect(origin: CGPoint.zero, size: collectionView.bounds.size))*/
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        
        // mask view shit
        /*guard let collectionView = collectionView,
            let maskView = collectionView.mask as? GradientMaskView,
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            else {
                return
        }
        
        /*
         Update the mask view to have fully faded out any collection view
         content above the navigation bar's label.
         */
        maskView.maskPosition.end = topLayoutGuide.length * 0.8
        
        /*
         Update the position from where the collection view's content should
         start to fade out. The size of the fade increases as the collection
         view scrolls to a maximum of half the navigation bar's height.
         */
        let maximumMaskStart = maskView.maskPosition.end + (topLayoutGuide.length * 0.5)
        let verticalScrollPosition = max(0, collectionView.contentOffset.y + collectionView.contentInset.top)
        maskView.maskPosition.start = min(maximumMaskStart, maskView.maskPosition.end + verticalScrollPosition)
        
        /*
         Position the mask view so that it is always fills the visible area of
         the collection view.
         */
        var rect = CGRect(origin: CGPoint(x: 0, y: collectionView.contentOffset.y), size: collectionView.bounds.size)
        
        /*
         Increase the width of the mask view so that it doesn't clip focus
         shadows along its edge. Here we are basing the amount to increase the
         frame by on the spacing defined in the collection view's layout.
         */
        rect = rect.insetBy(dx: -layout.minimumInteritemSpacing, dy: 0)
        
        maskView.frame = rect
        */
        
 
    }

    // Private
    private struct Constants {
        static let sectionInsets = UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)
    }
    
    
    private func createFriends() {
        let coord = CLLocationCoordinate2D(latitude: 37.445158, longitude: -122.163913)
        let minna = DrinkingBuddy(name: "minna", status: DrinkingBuddy.Status.dangerZone, title: nil, subtitle: "The Patio", coordinate: coord, phone: "6073791277", image: "minna-bitmoji", count: 7, limit: 6)
        let catherine = DrinkingBuddy(name: "catherine", status: DrinkingBuddy.Status.fine, title: nil, subtitle: "The Patio", coordinate: coord, phone: "9492417906", image: "cat-profile-bitmoji", count: 4, limit: 7)
        let me = DrinkingBuddy(name: "me", status: DrinkingBuddy.Status.fine, title: nil, subtitle: "The Patio", coordinate: coord, phone: "9492417906", image: "emily2", count: UserInfo.numDrinks, limit: UserInfo.drinkLimit) //emily
        let jeremy = DrinkingBuddy(name: "jeremy", status: DrinkingBuddy.Status.fine, title: nil, subtitle: "The Patio", coordinate: coord, phone: "5038676659", image: "jeremy-profile-bitmoji", count: 0, limit: 0)
        let shubha = DrinkingBuddy(name: "shubha", status: DrinkingBuddy.Status.left, title: nil, subtitle: "The Patio", coordinate: coord, phone: "4085945805", image: "shubha-sleeping-bitmoji", count: 1, limit: 4)
        let nick = DrinkingBuddy(name: "nick", status: DrinkingBuddy.Status.left, title: nil, subtitle: "The Patio", coordinate: coord, phone: "4085945805", image: "nick-sleeping-bitmoji", count: 3, limit: 8)
        let raven = DrinkingBuddy(name: "raven", status: DrinkingBuddy.Status.left, title: nil, subtitle: "The Patio", coordinate: coord, phone: "4085945805", image: "raven-sleeping-bitmoji", count: 2, limit: 5)
        partyPeople = [minna, catherine, me, jeremy, shubha, nick, raven]
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
            default: break
            }
        }
    }

}
