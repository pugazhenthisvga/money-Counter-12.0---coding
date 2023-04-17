//
//  Calculator.swift
//  CustomSplitControl
//

import UIKit
class Calculator: NSObject {
    struct Candy {
        let name : String , segueNo : String , index : Int
    }
    var Title: String
    var Description: String
    var Image: UIImage
    init(Title: String, Description: String, Image : UIImage) {
        self.Title = Title
        self.Description = Description
        self.Image = Image
    }
}
    



