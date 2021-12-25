//
//  ViewController.swift
//  Show_Task
//
//  Created by Mostafa on 24/12/2021.
//

import UIKit

class ShowListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var shows:  [ShowsModel]?
    private static var cellIdentifier = "ShowsTableViewCell"
    let loadingAlert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        fetchObjects(urlString: "http://api.tvmaze.com/search/shows?q=Future")
    }
    
    func registerNib() {
        tableView.register(UINib(nibName: ShowListVC.cellIdentifier, bundle: nil), forCellReuseIdentifier: ShowListVC.cellIdentifier)
    }
    
}

extension ShowListVC {
    fileprivate func fetchObjects(urlString: String) {
        startLoading()
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let data = data, err == nil else { return }
            self.endLoading()
            do {
                let jsonData = try JSONDecoder().decode([ShowsModel].self, from: data)
                self.shows = jsonData
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let jsonErr {
                print("failed to decode json:", jsonErr)
            }
            
        }.resume() // don't forget
    }
}

extension ShowListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowListVC.cellIdentifier) as! ShowsTableViewCell
        if let show = self.shows?[indexPath.row].show {
            cell.configure(show: show)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ShowDetailsVC") as! ShowDetailsVC
        next.show = self.shows![indexPath.row].show
        self.present(next, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ShowListVC {
    func startLoading() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        loadingAlert.view.addSubview(loadingIndicator)
        present(loadingAlert, animated: true, completion: nil)
    }
    
    func endLoading() {
        DispatchQueue.main.async {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        }
    }
}
