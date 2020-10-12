//
//  CollectionViewCell.swift
//  test1
//
//  Created by Офелия Баширова on 20.09.2020.
//  Copyright © 2020 Офелия Баширова. All rights reserved.
//

import UIKit

class CustomViewCell: UICollectionViewCell {
    static let identifier = "customCellIdentifier"

    // MARK: Nested types

    private enum Style {
        static let contentInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        static let spacingBetweenNameAndDescription: CGFloat = 0
        static let spacingBetweenNameAndPrice: CGFloat = 4
        static let spacingBetweenDescriptionAndSeparator: CGFloat = 4
        static let priceFont = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let nameFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    // MARK: Subviews

    private lazy var imageView: UIImageView = Self.makeImageView()
    private lazy var nameLabel: UILabel = Self.makeNameLabel()
    private lazy var priceLabel: UILabel = Self.makePriceLabel()
    private lazy var discountLabel: UILabel = Self.makeDiscountLabel()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        contentView.layer.cornerRadius = 8
        setupSubviews()
    }
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    private func setupSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(discountLabel)
        contentView.addSubview(buttonWithHeart)
        print(buttonWithHeart)
        //contentView.bringSubviewToFront(buttonWithHeart)
    }

    // MARK: Public
   
    func setup(image: String, name: String, price: String, discount: String) {
        let url = URL(string: "https://lorempixel.com/250/250")
         URLSession.shared.dataTask(with: url!) { (data, response, error) in
                      if let imageData = data {
                          DispatchQueue.main.async {
                              self.imageView.image = UIImage(data: imageData)
                               print("Show image data")
                          }
                          print("Did download  image data")
                      }
          }.resume()
        nameLabel.text = name
        priceLabel.text = price
        discountLabel.text = discount
     }
    // MARK: Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.sizeToFit()
        imageView.frame = CGRect(x: 0, y: 0, width: 191, height: 167)
        let nameLabelSize = nameLabel.sizeThatFits(CGSize(width: bounds.width - priceLabel.frame.width, height: .greatestFiniteMagnitude))
        nameLabel.frame.size = nameLabelSize
        nameLabel.frame.origin = CGPoint(x: 10, y: imageView.frame.maxY)
        priceLabel.sizeToFit()
        priceLabel.frame.origin = CGPoint(x: 10, y: nameLabel.frame.maxY)
        discountLabel.sizeToFit()
        discountLabel.frame.origin = CGPoint(x: priceLabel.frame.width + 11, y: nameLabel.frame.maxY + 1)
        buttonWithHeart.frame = CGRect(x:  imageView.frame.maxX + 5, y:  imageView.frame.maxY + 5, width: 250, height: 250)
}

    // MARK: Subview factories
    static func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Img")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }
    
    static func makeNameLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Style.nameFont
        label.numberOfLines = 0
        return label
    }

    static func makePriceLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = Style.priceFont        
        return label
    }
    func strikeThroughText (_ text:String) -> NSAttributedString {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
            return attributeString
        }
    
    static func makeDiscountLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor(red: 0.369, green: 0.369, blue: 0.369, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        return label
    }
    
    private  let buttonWithHeart: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "heart.png"), for: .normal)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        btn.addTarget(self, action: Selector(("btnTouched")), for:.touchUpInside)
      
        return btn
    }()
        func btnTouched (_ sender: UIButton) {
                if buttonWithHeart.isSelected {
                    buttonWithHeart.isSelected = false
                    buttonWithHeart.setImage(UIImage(named: "heart2.png"), for: .normal)
                } else {
                    buttonWithHeart.isSelected = true
                    buttonWithHeart.setImage(UIImage(named: "heart.png"), for: .normal)
                }
        }
    
    
    // MARK: Layout calculation

    static func calculateSize(fittingSize: CGSize, image: String, name: String, price: String, discount: String) -> CGSize {
        let imageView = makeImageView()
        let nameLabel = makeNameLabel()
        let priceLabel = makePriceLabel()
        let discountLabel = makeDiscountLabel()
        
        let width = fittingSize.width - Style.contentInsets.left - Style.contentInsets.right

        nameLabel.text = name
        priceLabel.text = price
        imageView.image = UIImage(contentsOfFile: image)
        discountLabel.text = discount
        
        let imageViewSize = imageView.sizeThatFits(CGSize(width: width, height: fittingSize.height))
        let priceSize = priceLabel.sizeThatFits(CGSize(width: width, height: fittingSize.height))
        let nameSize = nameLabel.sizeThatFits(CGSize(width: width - priceSize.width, height: fittingSize.height))
        let discountSize = discountLabel.sizeThatFits(CGSize(width: width - priceSize.width, height: fittingSize.height))
        
        let height = Style.contentInsets.top
            + max(priceSize.height, nameSize.height, discountSize.height)
            + CGFloat(185)
        
        return CGSize(
            width: width/2,
            height: height
        )
    }
}
