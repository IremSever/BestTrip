//
//  CitySelection.swift
//  BestTrip
//
//  Created by IREM SEVER on 10.12.2024.
//

import UIKit

class CitySelection: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewSearchTo: UIView!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var collectionViewSearch: UICollectionView!
    var viewModel = HomeViewModel()
    
    private var searchBar: UISearchBar!
    private var isSeaching = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        loadData()
        setupSearchBar()
        addSearchGesture()
    }
    
    func configure(with data: App) {
      
    }
    
}

extension CitySelection: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupCollectionView() {
        collectionViewSearch.delegate = self
        collectionViewSearch.dataSource = self
        collectionViewSearch.showsVerticalScrollIndicator = false
        registerCell()
    }
    
    func registerCell() {
        collectionViewSearch.register(UINib(nibName: "CitiesCell", bundle: nil), forCellWithReuseIdentifier: "CitiesCell")
    }
    
    func loadData() {
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.collectionViewSearch.reloadData()
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.homeModel?.app.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.homeModel?.app[section].type
        
        if sectionType == .city {
            return viewModel.homeModel?.app[section].data.count ?? 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = viewModel.homeModel?.app[indexPath.section].type,
              let data = viewModel.homeModel?.app[indexPath.section].data[indexPath.item] else {
            fatalError("Section type or data not found")
        }
        
        switch sectionType {
        case .campaign, .flights, .additionalService, .bestOppotunity:
            return UICollectionViewCell()
        case .city:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CitiesCell", for: indexPath) as! CitiesCell
            cell.configure(with: data)
            return cell
          }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height: CGFloat = 48
        return CGSize(width: width, height: height)
    }
}

extension CitySelection: UISearchBarDelegate {
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Make a Selection"
        searchBar.isHidden = true
        self.addSubview(searchBar)
    
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func addSearchGesture() {
        let searchTapGesture = UITapGestureRecognizer(target: self, action: #selector(showSearchBar))
        viewSearch.addGestureRecognizer(searchTapGesture)
        let searchTapGestureTo = UITapGestureRecognizer(target: self, action: #selector(showSearchBar))
        viewSearchTo.addGestureRecognizer(searchTapGestureTo)
    }
    
    @objc private func showSearchBar() {
        searchBar.isHidden = false
        searchBar.becomeFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        lblFrom.text = searchText
        lblTo.text = searchText
        isSeaching = !searchText.isEmpty
        collectionViewSearch.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSeaching = false
        searchBar.text = ""
        lblFrom.text = ""
        lblTo.text = ""
        searchBar.resignFirstResponder()
        searchBar.isHidden = true
        collectionViewSearch.reloadData()
    }
}
