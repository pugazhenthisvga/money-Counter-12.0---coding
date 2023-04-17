//
//  MemeCellPad.swift
//  MemeIQ
//
//  Created by Michael Rojas on 7/8/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import UIKit

class MemeCellPad: UICollectionViewCell {
    
@IBOutlet weak var calculatorImage: UIImageView!
@IBOutlet weak var calculatorLabel: UILabel!
var candies = [Candy]()
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.candies = ModelManager.sharedInstance.geometricCandies
        self.backgroundColor = UIColor.systemBackground
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 5
    }
    func configureWithImage(index: Int ,currencyArray: [String],flagArray : [String]) {
        
        calculatorImage.image  = UIImage(named: flagArray[index])
        calculatorLabel.text = currencyArray[index]
        calculatorLabel.textColor = .systemTeal
        calculatorLabel.font =  UIFont (name: "Avenir-Heavy", size:20)
    }
}


