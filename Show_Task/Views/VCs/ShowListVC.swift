//
//  ViewController.swift
//  Show_Task
//
//  Created by Mostafa on 24/12/2021.
//

import UIKit

class ShowListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func registerNib() {
        tableView.register(UINib(nibName: "ShowsTableViewCell", bundle: nil), forCellReuseIdentifier: "ShowsTableViewCell")
    }

}

