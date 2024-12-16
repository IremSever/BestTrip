//
//  ViewController.swift
//  BestTrip
//
//  Created by IREM SEVER on 3.12.2024.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, FlightCellDelegate, AdditionalServiceCellDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadData()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        navigationController?.isNavigationBarHidden = true
        collectionView.showsVerticalScrollIndicator = false
        self.collectionView.collectionViewLayout = self.createLayout()
        registerCell()
    }
    
    func loadData() {
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func registerCell() {
        let cells = [
            "CampaignCell",
            "FlightCell",
            "AdditionalServiceCell"
        ]
        
        for cell in cells {
            collectionView.register(UINib(nibName: cell, bundle: nil), forCellWithReuseIdentifier: cell)
        }
    }
    
    func flightCellDidRequestShowDetail(_ cell: FlightCell, detailType: DetailType) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else {
            return
        }
        
        detailVC.detailType = detailType
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    func additionalServiceCellDidRequestShowDetail(_ cell: AdditionalServiceCell, detailType: DetailType) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else {
            return
        }
        
        detailVC.detailType = detailType
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.homeModel?.app.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.homeModel?.app[section].type
        
        if sectionType == .city {
            return 0
        } else if sectionType == .flights {
            return 1
        } else {
            return viewModel.homeModel?.app[section].data.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = viewModel.homeModel?.app[indexPath.section].type,
              let data = viewModel.homeModel?.app[indexPath.section].data[indexPath.item] else {
            fatalError("Section type or data not found")
        }
        
        let cell: UICollectionViewCell
        
        switch sectionType {
        case .campaign:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CampaignCell", for: indexPath) as! CampaignCell
        case .flights:
            let flightCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlightCell", for: indexPath) as! FlightCell
            flightCell.delegate = self
            cell = flightCell
        case .additionalService:
            let serviceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdditionalServiceCell", for: indexPath) as! AdditionalServiceCell
            serviceCell.delegate = self
            cell = serviceCell
        case .bestOppotunity:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CampaignCell", for: indexPath) as! CampaignCell
        case .city:
              return UICollectionViewCell()
          }
        
        configureCellAppearance(cell, for: sectionType)
        if let configurableCell = cell as? ConfigurableCell {
            configurableCell.configure(with: data)
        }
        
        return cell
    }
    
    private func configureCellAppearance(_ cell: UICollectionViewCell, for sectionType: Template) {
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = sectionType == .flights ? 0.3 : 0.2
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = sectionType == .flights ? 10 : 5
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = (sectionType == .flights || sectionType == .additionalService || sectionType == .bestOppotunity) ? 20 : 0
    }
}

extension ViewController {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            let sectionType = self.viewModel.homeModel?.app[sectionIndex].type
            switch sectionType {
            case .campaign:
                return createSection(
                    itemSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400)),
                    groupSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400)),
                    orthogonalBehavior: .paging,
                    contentInsets: NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: -20, trailing: 0)
                )
            case .flights:
                return createSection(
                    itemSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(373)),
                    groupSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(373)), orthogonalBehavior: .none,
                    contentInsets: NSDirectionalEdgeInsets(top: 0, leading: 11, bottom: 0, trailing: 11)
                )
            case .additionalService:
                return createSection(
                    itemSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(78)),
                    groupSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(78)),
                    orthogonalBehavior: .none,
                    footerHeight: 0,
                    contentInsets: NSDirectionalEdgeInsets(top: 19, leading: 16, bottom: -3, trailing: 16)
                )
            case .bestOppotunity:
                return createSection(
                    itemSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(180)),
                    groupSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(180)),
                    orthogonalBehavior: .none,
                    headerHeight: 50,
                    contentInsets: NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16)
                )
            case .city:
                return nil
            case .none:
                return nil
            }
        }
        return layout
    }
    
    func createSection(
        itemSize: NSCollectionLayoutSize,
        groupSize: NSCollectionLayoutSize,
        orthogonalBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
        headerHeight: CGFloat? = nil,
        footerHeight: CGFloat? = nil,
        contentInsets: NSDirectionalEdgeInsets = .zero) -> NSCollectionLayoutSection {
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = contentInsets
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = orthogonalBehavior
            
            if let headerHeight = headerHeight {
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(headerHeight)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                section.boundarySupplementaryItems.append(header)
            }
            return section
        }
}

