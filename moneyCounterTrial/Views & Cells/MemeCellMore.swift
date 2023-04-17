//
//  MemeCell.swift
//  MemeIQ
//


import UIKit
 
let imagefromClassAds = ImageClassAds()

class MemeCellMore: UICollectionViewCell {
 
@IBOutlet weak var calculatorImage: UIImageView!
@IBOutlet weak var calculatorLabel: UILabel!
var candies = [Candy]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.candies = ModelManager.sharedInstance.moreAppCandies
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 10
        self.backgroundColor = UIColor.systemBackground
    }
    func configureWithImage(index: Int) {
        calculatorImage.image = imagefromClassAds.imageForCellAds(row:index)
        calculatorImage.layer.cornerRadius = 5.0
        calculatorImage.clipsToBounds = true
        calculatorLabel.numberOfLines = 0
        calculatorLabel.textColor = .systemTeal 
        calculatorLabel.text = candies[index].name
        if deviceIdiom == .pad{
            calculatorLabel.font = UIFont(name: "Avenir-Heavy", size: 14)
        }else{
            calculatorLabel.font = UIFont(name: "Avenir-Heavy", size: 12)
        }
        
    }
    

}

