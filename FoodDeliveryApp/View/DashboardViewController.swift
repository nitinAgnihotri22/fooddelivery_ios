//
//  DashboardViewController.swift
//  FoodDeliveryApp
//
//  Created by Nitin Agnihotri on 28/03/21.
//  
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var fdPageControll: UIPageControl!
    let collectionViewFlowLayout = SnapCenterLayout()
    private var currentImageIndex = 0
    private var totalItemsInCollection = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        startAutoScroll()
        fdPageControll.numberOfPages = totalItemsInCollection
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    // MARK: - UIScrollViewDelegate methods

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }

    // MARK: - Properties
    var presenter: ViewToPresenterDashboardProtocol?
    
}

extension DashboardViewController: PresenterToViewDashboardProtocol {
    // TODO: Implement View Output Methods
}

extension DashboardViewController: UITableViewDelegate,UITableViewDataSource {
    
    // MARK: - UITableViewDataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
}

extension DashboardViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func setupCollectionView() {
        let collectionViewSize = collectionView.frame.size
        let screenSize = UIScreen.main.bounds.size
        
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.itemSize = CGSize(width: screenSize.width, height: collectionViewSize.height)
        collectionViewFlowLayout.minimumLineSpacing = 0.0
        collectionViewFlowLayout.minimumInteritemSpacing = 0.0
        
        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItemsInCollection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as! HeaderCollectionViewCell
            cell.backgroundImage.image = #imageLiteral(resourceName: "HeaderImage")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if fdPageControll.currentPage == indexPath.row {
            guard let visible = collectionView.visibleCells.first else { return }
            guard let index = collectionView.indexPath(for: visible)?.row else { return }
            fdPageControll.currentPage = index
            currentImageIndex = index
        }
    }
    
    @objc
    func scrollToNextCell() {
        
        if currentImageIndex >= totalItemsInCollection-1 {
            collectionView.scrollToItem(at: IndexPath.init(item: 0, section: 0), at: UICollectionView.ScrollPosition.left, animated: true)
        }
        //get current content Offset of the Collection view
        let contentOffset = collectionView.contentOffset;
        //scroll to next cell
        let cellSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height);

        collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
    }

    /**
     Invokes Timer to start Automatic Animation with repeat enabled
     */
    func startAutoScroll() {

        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true)
    }

}
