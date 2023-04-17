//
//  CustomCell.swift

//

import UIKit

class CustomCell: UITableViewCell {

    // MARK: - IBOutlet Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var lockedImageView: UIImageView!
    @IBOutlet weak var topSeparator: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureWithRemoveAds() {
        
        descriptionLabel.text = NSLocalizedString("removeAds", comment: "")
        if #available(iOS 15.0, *) {
            descriptionLabel.backgroundColor = .systemYellow
        } else {
            descriptionLabel.backgroundColor = .systemYellow
        }
        descriptionLabel.layer.cornerRadius = 5.0
        descriptionLabel.textColor = .systemGray
        descriptionLabel.clipsToBounds   = true
        descriptionLabel.font = UIFont(name: "Avenir-Medium", size: 14)!
         
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
       // super.setSelected(selected, animated: animated)
        if selected{
            descriptionLabel.textColor = .lightGray
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            self.descriptionLabel.textColor = calculatorBackroudColor
        }
        

        // Configure the view for the selected state
        print("selected state  : \(selected )")
       
    }

}
