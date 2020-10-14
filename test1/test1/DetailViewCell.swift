//
//  DetailViewCell.swift
//  test1
//
//  Created by Офелия Баширова on 14.10.2020.
//  Copyright © 2020 Офелия Баширова. All rights reserved.
//

import UIKit

class DetailViewCell: UICollectionViewCell {
    
   static let identifier = "headerId"
    
    var nameOfCategories: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.layer.backgroundColor = UIColor(red: 0.882, green: 0.894, blue: 0.894, alpha: 1).cgColor
        label.layer.cornerRadius = 7
        label.numberOfLines = 0
        return label
    }()
    func setup2 (name: String) {
        nameOfCategories.text = name
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameOfCategories)
       
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
