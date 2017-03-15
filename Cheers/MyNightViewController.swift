//
//  MyNightViewController.swift
//  Cheers
//
//  Created by Minna Xiao on 3/11/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

import UIKit
import PKHUD

class MyNightViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var bacView: UIView!
    
    @IBOutlet weak var currDrinkCountLabel: UILabel!
    
    @IBOutlet weak var drinkLimitLabel: UILabel!
    
    @IBOutlet weak var setBitmojiButton: UIButton!
    
    @IBOutlet weak var infoButton: UIButton!
    
    @IBOutlet weak var bacLabel: UILabel!
    
    
    fileprivate var bitmojis = [String]()
    
    fileprivate var currentPage: Int = 0
    
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    @IBAction func setBitmoji(_ sender: UIButton) {
        let selectedBitmoji = bitmojis[currentPage]
        UserInfo.myBitmoji = selectedBitmoji
        HUD.flash(.label("Profile updated!"), delay: 0.5)
    }
    
    
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        let title = "WTF is BAC?"
        let message = "BAC (Blood Alcohol Concentration) is the amount of alcohol in your blood. It is illegal to drive if your BAC is over 0.08"
        
        let popup = PopupDialog(title: title, message: message, image: nil)
        
        let button = DefaultButton(title: "OK") {
            print("button pressed")
        }
        
        popup.addButtons([button])
        self.present(popup, animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupLayout()
        createBitmojis()
        self.currentPage = 0
        
        setupLabelInfo()
        setupUI()
        updateLabelUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateDrinkCountLabel(notification:)), name: Notification.Name(rawValue: "drinkCountChange"), object: nil)
    }
    
    func updateDrinkCountLabel(notification: Notification) {
        let currDrink = UserInfo.numDrinks
        currDrinkCountLabel.text = String(currDrink)
        updateLabelUI()
    }
    
    private func setupUI() {
        self.bacView.layer.cornerRadius = 12
        self.bacView.clipsToBounds = true
        self.bacView.layer.borderWidth = 1.0
        self.bacView.layer.borderColor = UIColor.gray.cgColor
        
        self.setBitmojiButton.layer.borderColor = UIColor.gray.cgColor
        self.setBitmojiButton.layer.borderWidth = 1.0
        self.setBitmojiButton.layer.cornerRadius = 10
    }
    
    private func setupLabelInfo() {
        let currDrinkCount = UserInfo.numDrinks
        currDrinkCountLabel.text = String(currDrinkCount)
        let drinkLim = UserInfo.drinkLimit
        drinkLimitLabel.text = String(drinkLim)
    }
    
    private func updateLabelUI() {
        let currDrinkCount = UserInfo.numDrinks
        let bac = BacInfo.drinkToBACDict[currDrinkCount]
        let colorHex = BacInfo.BACToColorDict[bac!]
        bacLabel.text = bac
        bacLabel.textColor = UIColor(hex: colorHex!)
        currDrinkCountLabel.textColor = UIColor(hex: colorHex!)
    }
    
    
    private func setupLayout() {
        let layout = self.collectionView.collectionViewLayout as? UPCarouselFlowLayout
        
        // change this visibleOffset for the items on the side
        layout?.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 80)
    }
    
    private func createBitmojis() {
        self.bitmojis = ["emily1", "emily2", "wine-main", "cocktail-main", "shot-main"]
    }
    
    
    // MARK: - UICollectionView Delegate & DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bitmojis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BitmojiCell", for: indexPath) as! CarouselCollectionViewCell
        let bitmoji = bitmojis[indexPath.item]
        cell.image = UIImage(named: bitmoji)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightPerItem = self.view.frame.height
        return CGSize(width: heightPerItem, height: heightPerItem)
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
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
