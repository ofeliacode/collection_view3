//
//  DetailViewController.swift
//  test1
//
//  Created by Офелия Баширова on 28.09.2020.
//  Copyright © 2020 Офелия Баширова. All rights reserved.
//

import UIKit

class DetailViewController: UICollectionViewController {
    
    var labelName = ""
    var labelPrice = ""
    var labelDescription = ""
    var labelDiscount = ""
    var imageView = ""
    var labelCategories = ""
    
    let scrollView: UIScrollView = {
            let scrV = UIScrollView()
        scrV.translatesAutoresizingMaskIntoConstraints = false
        scrV.backgroundColor = .cyan
            return scrV
        }()
    
    //имя
    var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Img")
        return imageView
    }()
    
    var circleView: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.frame = CGRect(x: 340, y: 380, width: 60, height: 60)
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.backgroundColor = UIColor.white.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        return image
    }()
    private let buttonWithHeart: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "heart.png"), for: .normal)
        btn.frame = CGRect(x: 340, y: 380, width: 60, height: 60)
        btn.addTarget(self, action: #selector(btnPressed(_:)), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    @objc func btnPressed (_ sender: UIButton) {
        if sender.isSelected {
            sender.setImage(UIImage(named: "heart2.png"), for: .selected)
            sender.isSelected = false
            }else {
                sender.setImage(UIImage(named: "heart.png"), for: . normal)
                sender.isSelected = true
            }
        }
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
    var categoriesTitle: UILabel = {
           let label = UILabel()
           label.textAlignment = .right
           label.text = "Categories"
           label.textColor = .black
           label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
           label.numberOfLines = 0
           return label
       }()
   
    @objc func goBack(sender:UIBarButtonItem){
        self.navigationController?.popToRootViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
      //stackView.frame = view.frame
        view.addSubview(scrollView)
        scrollView.addSubview(imageView2)
        scrollView.addSubview(labelName2)
        scrollView.addSubview(labelDescription2)
        scrollView.addSubview(labelPrice2)
        scrollView.addSubview(labelDiscount2)
        
        scrollView.addSubview(circleView)
        scrollView.addSubview(buttonWithHeart)
        scrollView.addSubview(categoriesTitle)

        collectionView.register(DetailViewCell.self, forCellWithReuseIdentifier: DetailViewCell.identifier)
        //collectionView.contentInsetAdjustmentBehavior = .never
        self.title = labelName
        labelName2.text = "name: \(labelName)"
        labelPrice2.text = "\(labelPrice) USD Dollars"
        labelDescription2.text = "Description: \(labelDescription)"
        labelDiscount2.text = "\(labelDiscount) USD Dollars discount"
        let url = URL(string: imageView)
         URLSession.shared.dataTask(with: url!) { (data, response, error) in
                      if let imageData = data {
                          DispatchQueue.main.async {
                              self.imageView2.image = UIImage(data: imageData)
                               print("Show image data")
                          }
                          print("Did download  image data")
                      }
          }.resume()
        
        self.navigationController?.navigationBar.barTintColor = .white
        
        labelName2.translatesAutoresizingMaskIntoConstraints = false
        labelPrice2.translatesAutoresizingMaskIntoConstraints = false
        labelDescription2.translatesAutoresizingMaskIntoConstraints = false
        labelDiscount2.translatesAutoresizingMaskIntoConstraints = false
        imageView2.translatesAutoresizingMaskIntoConstraints = false
        categoriesTitle.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8.0).isActive = true
       // scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0).isActive = true

                
        
        imageView2.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 93).isActive = true
        imageView2.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:0).isActive = true
        imageView2.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant:0).isActive = true
        imageView2.heightAnchor.constraint(greaterThanOrEqualToConstant: 364).isActive = true
        
        labelName2.topAnchor.constraint(equalTo: imageView2.bottomAnchor, constant: 15).isActive = true
        labelName2.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:16).isActive = true
        labelName2.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant:-16).isActive = true
        
        labelDescription2.topAnchor.constraint(equalTo:  labelName2.bottomAnchor, constant: 7).isActive = true
        labelDescription2.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:16).isActive = true
        labelDescription2.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant:-16).isActive = true
        
        labelPrice2.topAnchor.constraint(equalTo:  labelDescription2.bottomAnchor, constant: 7).isActive = true
        labelPrice2.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:16).isActive = true
        labelPrice2.rightAnchor.constraint(equalTo: labelDiscount2.leftAnchor).isActive = true
       
        labelDiscount2.topAnchor.constraint(equalTo:  labelDescription2.bottomAnchor, constant: 7).isActive = true
        labelDiscount2.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant:-16).isActive = true
        
        categoriesTitle.topAnchor.constraint(equalTo: labelDiscount2.bottomAnchor, constant: 15).isActive = true
        categoriesTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:16).isActive = true
    }
}
var dataArray2 = [Categoriess]()

extension DetailViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailViewCell.identifier, for: indexPath) as! DetailViewCell
        cell.setup2(name: dataArray2[indexPath.item].name)
        return cell
        
    }
}
extension DetailViewController: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (view.frame.width - 49) / 2
            return CGSize(width: width, height: 31)
        }
}
