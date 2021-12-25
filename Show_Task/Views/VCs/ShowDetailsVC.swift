//
//  ShowDetailsVC.swift
//  Show_Task
//
//  Created by Mostafa on 24/12/2021.
//

import UIKit
import Cosmos

class ShowDetailsVC: UIViewController {
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var premieredLabel: UILabel!
    
    var show: Show?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        showImage.download(urlString: self.show?.image?.original ?? "")
        showNameLabel.text = self.show?.name ?? ""
        rateView.rating = Double(self.show?.rating?.average ?? 2) / 2
        runtimeLabel.text = "\(self.show?.runtime ?? 0)"
        premieredLabel.text = self.show?.premiered ?? ""
    }
    
    @IBAction func clickTheLink(_ sender: Any) {
        openUrl()
    }
}

extension ShowDetailsVC {
    func openUrl() {
        if let url = URL(string: self.show?.url ?? "") {
            UIApplication.shared.open(url)
        }
    }
}
