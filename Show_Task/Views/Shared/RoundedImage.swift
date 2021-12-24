//
//  RoundedImage.swift
//  Show_Task
//
//  Created by Mostafa on 24/12/2021.
//

import UIKit

class RoundedImage: UIImageView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
}
