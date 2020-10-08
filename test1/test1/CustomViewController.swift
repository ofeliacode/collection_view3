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
        let layout = UICollectionViewFlowLayout()
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
        collectionView.register(CustomViewCell.self, forCellWithReuseIdentifier: CustomViewCell.identifier)
        collectionView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        collectionView.collectionViewLayout = layout
        fetchProducts(refresh: true)
       
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
            name: "name: \(dataArray[indexPath.item].name + dataArray[indexPath.item].name)",
            price: "price: \(dataArray[indexPath.item].price)",
            description: "description: \(dataArray[indexPath.item].description)",
            image: dataArray[indexPath.item].image
        )
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.labelName = dataArray[indexPath.item].name
        vc.labelPrice = dataArray[indexPath.item].price
        vc.labelDescription = dataArray[indexPath.item].description
       // vc.imageView = dataArray[indexPath.item].image
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
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CustomViewCell.calculateSize(
            fittingSize: CGSize(width: collectionView.frame.width, height: .greatestFiniteMagnitude),
            name: "name: \(dataArray[indexPath.item].name + dataArray[indexPath.item].name)",
            price: "price: \(dataArray[indexPath.item].price)",
            description: "description: \(dataArray[indexPath.item].description)"
           // image: dataArray[indexPath.item].image
        )
    }
}
