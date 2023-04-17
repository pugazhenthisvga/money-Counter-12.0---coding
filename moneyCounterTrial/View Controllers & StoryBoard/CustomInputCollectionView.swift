import UIKit
class CustomInputCollectionView: UICollectionView {
  
  required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       initialize()
   }
    
   public func initialize() {
       backgroundColor = UIColor.systemBackground
       let background = UIView()
       background.isUserInteractionEnabled = true
       background.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:))))
       backgroundView = background
       translatesAutoresizingMaskIntoConstraints = false
    }
    
   @objc private func backgroundTapped(_ sender: UIGestureRecognizer) {
       endEditing(true)
    
   }

}
