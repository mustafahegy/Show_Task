//
//  ShowsTableViewCell.swift
//  Show_Task
//
//  Created by Mostafa on 24/12/2021.
//

import UIKit

class ShowsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var showImage: RoundedImage!
    @IBOutlet weak var showTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(show: Show) {
        showImage.download(urlString: show.image?.original ?? "")
        showTitle.text = show.name
    }
}
