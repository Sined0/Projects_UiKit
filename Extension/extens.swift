//
//  extens.swift
//  Uikit_Menu_14_03_2023
//
//  Created by Denis Orlenko on 14.03.2023.
//

import UIKit

var imageCahce = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func load(urlStr: String){
        
        if let image = imageCahce.object(forKey: urlStr as NSString) as? UIImage{
            self.image = image
            return
        }
        
        guard let url = URL(string: urlStr) else {return}
        
        DispatchQueue.global(qos: .utility).async {[weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        imageCahce.setObject(image, forKey: urlStr as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension MainViewRecipte{
    func setUpCell() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension Todo{
    func setUpCell() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}




