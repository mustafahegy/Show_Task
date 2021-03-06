//
//  UIImageView+Extension.swift
//  Show_Task
//
//  Created by Mostafa on 24/12/2021.
//

import UIKit

extension UIImageView {
    func download(urlString: String) {
        // replace image with avatar if url is empty
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
    
    // setup loading activityIndicator
    fileprivate var activityIndicator: UIActivityIndicatorView {
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.center = CGPoint(
            x: self.bounds.midX,
            y: self.bounds.midY
        )
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        loadingIndicator.tag = 100
        self.addSubview(loadingIndicator)
        return loadingIndicator
    }
    // stop loading
    func stopAnimation() {
        // viewWithTag(100) refer to the loadingIndicator
        DispatchQueue.main.async {
            if let viewWithTag = self.viewWithTag(100) {
                viewWithTag.removeFromSuperview()
            }
        }
        
    }
}
