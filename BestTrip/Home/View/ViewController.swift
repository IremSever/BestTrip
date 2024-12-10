//
//  ViewController.swift
//  BestTrip
//
//  Created by IREM SEVER on 3.12.2024.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
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
        collectionView.register(UINib(nibName: "CampaignCell", bundle: nil), forCellWithReuseIdentifier: "CampaignCell")
        collectionView.register(UINib(nibName: "FlightCell", bundle: nil), forCellWithReuseIdentifier: "FlightCell")
        collectionView.register(UINib(nibName: "AdditionalServiceCell", bundle: nil), forCellWithReuseIdentifier: "AdditionalServiceCell")
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return viewModel.homeModel?.app.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.homeModel?.app[section].type
        
        if sectionType == .flights {
            return 1
        } else {
            return viewModel.homeModel?.app[section].data.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = viewModel.homeModel?.app[indexPath.section].type else {
            fatalError("Section type not found")
        }
        switch sectionType {
        case .campaign:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CampaignCell", for: indexPath) as! CampaignCell
            guard let data = viewModel.homeModel?.app[indexPath.section].data[indexPath.item] else { return UICollectionViewCell() }
         
            cell.configure(with: data)
            return cell
        case .flights:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlightCell", for: indexPath) as! FlightCell
            guard let data = viewModel.homeModel?.app[indexPath.section].data[indexPath.item] else { return UICollectionViewCell() }
            cell.applyShadow()
            cell.configure(with: data)
            return cell
        case .additionalService:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdditionalServiceCell", for: indexPath) as! AdditionalServiceCell
            guard let data = viewModel.homeModel?.app[indexPath.section].data[indexPath.item] else { return UICollectionViewCell() }
            cell.configure(with: data)
            cell.applyShadow()
            return cell
        case .bestOppotunity:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CampaignCell", for: indexPath) as! CampaignCell
            guard let data = viewModel.homeModel?.app[indexPath.section].data[indexPath.item] else { return UICollectionViewCell() }
            cell.configure(with: data)
            cell.applyShadow()
            return cell
        }
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
                    contentInsets: NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                )
            case .additionalService:
                return createSection(
                    itemSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(78)),
                    groupSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(78)),
                    orthogonalBehavior: .none,
                    footerHeight: 0,
                    contentInsets: NSDirectionalEdgeInsets(top: 19, leading: 16, bottom: 0, trailing: 16)
                )
            case .bestOppotunity:
                return createSection(
                    itemSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(180)),
                    groupSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(180)),
                    orthogonalBehavior: .none,
                    contentInsets: NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16)
                )
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
        
        if let footerHeight = footerHeight {
            let footer = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(footerHeight)),
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom
            )
            section.boundarySupplementaryItems.append(footer)
        }
        
        return section
    }
}

extension UIView {
    func applyShadow(
        color: UIColor = .black,
        opacity: Float = 0.1,
        offset: CGSize = CGSize(width: 0, height: 2),
        radius: CGFloat = 4,
        cornerRadius: CGFloat = 8
    ) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false

        // Köşe yumuşatma (opsiyonel)
        self.layer.cornerRadius = cornerRadius
    }
}

