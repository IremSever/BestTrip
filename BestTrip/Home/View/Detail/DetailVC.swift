//
//  DetailVC.swift
//  BestTrip
//
//  Created by IREM SEVER on 10.12.2024.
//

import UIKit

class DetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        registerCell()
    }
    
    func registerCell() {
        collectionView.register(UINib(nibName: "AdditionalSeviceCell", bundle: nil), forCellWithReuseIdentifier: "AdditionalServiceCell")
        collectionView.register(UINib(nibName: "DateSelectionCell", bundle: nil), forCellWithReuseIdentifier: "DateSelectionCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.homeModel?.app[section].data[section].detailData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdditionalServiceCell", for: indexPath) as! AdditionalServiceCell
      
            return cell
    }
}
