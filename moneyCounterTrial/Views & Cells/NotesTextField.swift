//
//  RemarksTextField.swift
//  Money Counter
//
//  Created by V PUGAZHENTHI on 29/12/22.
//  Copyright © 2022 V PUGAZHENTHI. All rights reserved.
//

import UIKit

class NotesTextField : UITextField{
    override func layoutSubviews() {
            super.layoutSubviews()
            let myColor = UIColor.systemGray2
            self.layer.borderColor = myColor.cgColor
            self.layer.borderWidth = 1.0
            self.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            self.adjustsFontSizeToFitWidth = true
            self.minimumFontSize = 10.0
            self.borderStyle = .roundedRect
            self.clearButtonMode = .always
            self.layer.cornerRadius = 5.0
            self.clipsToBounds = true
        let notesPlaceholderText = NSAttributedString(string:  NSLocalizedString("remarks", comment: ""),
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont.preferredCustomFont(forTextStyle: .subheadline).italicized ])
        self.attributedPlaceholder = notesPlaceholderText
        }
}

