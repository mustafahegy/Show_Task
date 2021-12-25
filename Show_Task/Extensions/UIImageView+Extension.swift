//
//  UIImageView+Extension.swift
//  Show_Task
//
//  Created by Mostafa on 24/12/2021.
//

import UIKit

extension UIImageView {
    func download(urlString: String) {
        if urlString == ""{
            DispatchQueue.main.async {
                self.image = UIImage(named: "avatar")
            }
            return
        }
        self.activityIndicator.startAnimating()
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                self.stopAnimation()
                guard let data = data, error == nil, let image = UIImage(data: data) else {return}
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            task.resume()
        }
    }
    
    fileprivate var activityIndicator: UIActivityIndicatorView {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        loadingIndicator.tag = 100
        self.addSubview(loadingIndicator)
        return loadingIndicator
    }
    
    func stopAnimation() {
        DispatchQueue.main.async {
            if let viewWithTag = self.viewWithTag(100) {
                viewWithTag.removeFromSuperview()
            }
        }
        
    }
}
