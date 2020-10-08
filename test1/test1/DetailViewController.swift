//
//  DetailViewController.swift
//  test1
//
//  Created by Офелия Баширова on 28.09.2020.
//  Copyright © 2020 Офелия Баширова. All rights reserved.
//

import UIKit
//import SnapKit
class DetailViewController: UIViewController {
    
    var labelName = ""
    var labelPrice = ""
    var labelDescription = ""
    var labelDiscount = ""
    //var data: dataArray?
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.frame =  CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        scrollview.backgroundColor = .white
        scrollview.contentSize = CGSize(width: self.view.frame.size.width, height: 400)
        scrollview.isScrollEnabled = true
        return scrollview
    }()
    
    //линия
    let line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    //имя
    var labelName2: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)

        label.numberOfLines = 0
        return label
    }()
    //цена
    var labelPrice2: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    var labelDescription2: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    var labelDiscount2: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
   /* var imageView : UIImageView = {
        let image = UIImage()
        return image
    }*/
  
    @objc func goBack(sender:UIBarButtonItem){
        self.navigationController?.popToRootViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        
      //  stackView.frame = view.frame
        view.addSubview(labelName2)
        view.addSubview(labelDescription2)
        view.addSubview(labelPrice2)
        view.addSubview(labelDiscount2)
       
        self.title = labelName
        labelName2.text = "name: \(labelName)"
        labelPrice2.text = "\(labelPrice) USD Dollars"
        labelDescription2.text = "Description: \(labelDescription)"
        labelDiscount2.text = "\(labelDiscount) USD Dollars discount"
     
        self.navigationController?.navigationBar.barTintColor = .white
        
        labelName2.translatesAutoresizingMaskIntoConstraints = false
        labelPrice2.translatesAutoresizingMaskIntoConstraints = false
        labelDescription2.translatesAutoresizingMaskIntoConstraints = false
        labelDiscount2.translatesAutoresizingMaskIntoConstraints = false

        labelName2.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 115).isActive = true
        labelName2.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:16).isActive = true
        labelName2.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant:-16).isActive = true
        
        labelDescription2.topAnchor.constraint(equalTo:  labelName2.bottomAnchor, constant: 7).isActive = true
        labelDescription2.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:16).isActive = true
        labelDescription2.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant:-16).isActive = true
        
        labelPrice2.topAnchor.constraint(equalTo:  labelDescription2.bottomAnchor, constant: 7).isActive = true
        labelPrice2.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:16).isActive = true
       labelPrice2.rightAnchor.constraint(equalTo: labelDiscount2.leftAnchor).isActive = true
       
        labelDiscount2.topAnchor.constraint(equalTo:  labelDescription2.bottomAnchor, constant: 7).isActive = true
       //labelDiscount2.leftAnchor.constraint(equalTo: labelPrice2.rightAnchor, constant: 5).isActive = true
        labelDiscount2.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant:-16).isActive = true
        
    }
}
