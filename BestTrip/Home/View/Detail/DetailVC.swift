//
//  DetailVC.swift
//  BestTrip
//
//  Created by IREM SEVER on 10.12.2024.
//
import UIKit

class DetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = HomeViewModel()
    var detailType: DetailType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadData()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = .zero

        collectionView.collectionViewLayout = layout

        switch detailType {
        case .citySelection:
            collectionView.register(UINib(nibName: "CitySelection", bundle: nil), forCellWithReuseIdentifier: "CitySelection")
        case .dateSelection:
            collectionView.register(UINib(nibName: "DateSelectionCell", bundle: nil), forCellWithReuseIdentifier: "DateSelectionCell")
        case .passengerSelection:
            collectionView.register(UINib(nibName: "PassengerCell", bundle: nil), forCellWithReuseIdentifier: "PassengerCell")
        case .additionalServiceList:
            collectionView.register(UINib(nibName: "AdditionalServiceCell", bundle: nil), forCellWithReuseIdentifier: "AdditionalServiceCell")
        default:
            break
        }
    }
    
    func loadData() {
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch detailType {
        case .citySelection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CitySelection", for: indexPath) as! CitySelection
            return cell
        case .dateSelection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateSelectionCell", for: indexPath) as! DateSelectionCell
            return cell
        case .passengerSelection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PassengerCell", for: indexPath) as! PassengerCell
            return cell
        case .additionalServiceList:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdditionalServiceCell", for: indexPath) as! AdditionalServiceCell
            
            guard let data = viewModel.homeModel?.app[indexPath.section].data[indexPath.item],
                  let detailDataArray = data.detailData else {
                return UICollectionViewCell()
            }
            
            
            cell.configure(with: data)
            return cell
        default:
            fatalError("")
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = collectionView.bounds.width - 20
           let height: CGFloat = 750
     
           return CGSize(width: width, height: height)
       }

}
