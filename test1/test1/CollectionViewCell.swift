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
        contentView.addSubview(gradientView)
        contentView.addSubview(buttonWithHeart)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(discountLabel)
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
        buttonWithHeart.frame = CGRect(x:  168, y:  152, width: 12, height: 9)
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
    
    static func makeDiscountLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor(red: 0.369, green: 0.369, blue: 0.369, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        return label
    }
    
    private let buttonWithHeart: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "heart.png"), for: .normal)
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
    
    private let gradientView: UIView = {
        let view = UIView()
        view.frame = CGRect(x:  157, y:  145, width: 34, height: 22)
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.clear, UIColor.white.withAlphaComponent(4).cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        return view
    }()
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
            + CGFloat(200)
        return CGSize(
            width: width/2,
            height: height
        )
    }
}
