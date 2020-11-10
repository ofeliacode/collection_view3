//  CustomViewController.swift
//  test1
//
//  Created by Офелия Баширова on 26.08.2020.
//  Copyright © 2020 Офелия Баширова. All rights reserved.

import UIKit
import Foundation

class CustomViewController: UICollectionViewController {
   
    // MARK: UIRefreshControl
    
    var refresher: UIRefreshControl!
    
    // MARK: Layout
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        return layout
    }()
    
    // MARK: UIActivityIndicator
    
    var aiView: UIView?
    
    func showSpinner(){
        aiView = UIView(frame: self.view.bounds)
        aiView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = aiView!.center
        ai.startAnimating()
        aiView?.addSubview(ai)
        self.view.addSubview(aiView!)
    }
    func removeSpinner(){
        aiView?.removeFromSuperview()
        aiView = nil
    }
    // MARK: Private properties
  
    var dataArray = [Datas]()
    
    var page = 0
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        self.refresher = UIRefreshControl()
        self.refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView!.addSubview(refresher!)
        title = "Products"
        self.collectionView.contentInset = UIEdgeInsets(top: 11.0, left: 11.0, bottom: 8.0, right: 11.0)
        collectionView.register(CustomViewCell.self, forCellWithReuseIdentifier: CustomViewCell.identifier)
        collectionView.backgroundColor = UIColor(red: 0.968, green: 0.980, blue: 0.976, alpha: 1)
        collectionView..init(collectionViewLayout: layout)
        

        
        fetchProducts(refresh: true)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: refresh
    
   @objc func refreshData() {
    fetchProducts(refresh: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        
    }

    // MARK: Private

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 10)
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 10)
        layout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    // MARK: Pagination
   
    
    func fetchProducts(refresh: Bool) {
        
        let urlString = "https://gorest.co.in/public-api/products?page=\(page)"
        if refresh {
            refresher?.beginRefreshing()
        }
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return}
            guard let data = data else {return}
            
            guard error == nil else { return}
            do {
                let dataProp = try JSONDecoder().decode(Response.self, from: data)
                self.dataArray.append(contentsOf: dataProp.data)
                DispatchQueue.main.async {
                    if refresh {
                        self.refresher?.endRefreshing()
                    }
                    self.collectionView.reloadData()
                    self.removeSpinner()
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
   
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomViewCell.identifier, for: indexPath) as! CustomViewCell
        cell.setup(
            image: dataArray[indexPath.item].image,
            name: dataArray[indexPath.item].name,
            price: "\(dataArray[indexPath.item].price) $",
            discount: "\(dataArray[indexPath.item].discount_amount) $"            
        )
        cell.layer.cornerRadius = 8
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.imageView = dataArray[indexPath.item].image
        print(dataArray[indexPath.item].image)
        vc.labelName = dataArray[indexPath.item].name
        vc.labelPrice = dataArray[indexPath.item].price
        vc.labelDescription = dataArray[indexPath.item].description
        vc.labelDiscount = dataArray[indexPath.item].discount_amount
        self.navigationController?.pushViewController(vc, animated: true)
    }
   //paging
    override func collectionView(_ collectionView: UICollectionView,
                     willDisplay cell: UICollectionViewCell,
                       forItemAt indexPath: IndexPath) {
        if indexPath.row == dataArray.count - 1 {
            page += 1
            fetchProducts(refresh: false)
        }
   }
}
extension CustomViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CustomViewCell.calculateSize (
            fittingSize: CGSize(width: collectionView.frame.width, height: .greatestFiniteMagnitude),
            image: dataArray[indexPath.item].image,
            name: dataArray[indexPath.item].name,
            price: dataArray[indexPath.item].price,
            discount: dataArray[indexPath.item].discount_amount
        )
    }
}
