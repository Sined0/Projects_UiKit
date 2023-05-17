//
//  Cell.swift
//  Uikit_Menu_14_03_2023
//
//  Created by Denis Orlenko on 28.04.2023.
//

import UIKit

class Cells: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    let name: UILabel = {
        let lableText = UILabel()
        lableText.text = "Tst"
        lableText.font = UIFont.systemFont(ofSize: 16)
        return lableText
    }()
    
    func setUpCell() {
        
        addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48)
        ])
        
        
        
        
    }
    
}
