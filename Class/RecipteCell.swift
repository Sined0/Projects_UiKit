//
//  RecipteCell.swift
//  Uikit_Menu_14_03_2023
//
//  Created by Denis Orlenko on 14.03.2023.
//

import UIKit

class RecipCelll: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     let nameFood: UILabel = {
         let lable = UILabel()
         lable.text = "TST"
         lable.font = UIFont.systemFont(ofSize: 16)
         return lable
     }()
    
     let rating: UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 14)
         label.textColor = .lightGray
         return label
     }()

      func setUpCell() {
         addSubview(nameFood)
         [rating,nameFood].forEach{
             $0.translatesAutoresizingMaskIntoConstraints = false
             contentView.addSubview($0)
         }

         NSLayoutConstraint.activate([
             nameFood.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
             nameFood.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
             nameFood.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48),

             rating.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
             rating.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
         ])
     }
 }

