//
//  PhotoGalleryViewController.swift
//  Photo Viewer
//
//  Created by Ambuj Shukla on 29/06/18.
//  Copyright © 2018 cdn. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class PhotoGalleryViewController: UIViewController {
    
    //MARK: Private
    @IBOutlet private weak var collectionView: UICollectionView!
    private var photoGalleryViewModel = PhotoGalleryViewModel()
    private let lineSpacing = 20
    private let cellSize = UIScreen.main.bounds.size.width/3
    
    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.styleUI()
        self.configureInitialParameters()
        self.getInstagramMedia()
        self.styleNavigationBar()
    }
    
    //MARK: Private Methods
    
    private func styleUI() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.collectionView!.collectionViewLayout = layout
        
        self.collectionView.showsHorizontalScrollIndicator = false
    }
    //This method is used to configure the inital variable or the relevant methods to set before the use of the controls.
    private func configureInitialParameters() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //This enables the collectionview to confirm the Empty data set and if the collectionview have no data to show, then the relevant message would be shown in the view.
        self.collectionView.emptyDataSetSource = self
        self.collectionView.emptyDataSetDelegate = self
    }
    
    //This is the method used to style the navigation bar. Bar button designing is defined in the CommonUtility class.
    private func styleNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = appColor()
        self.title = NSLocalizedString("title.instagram.feeds", comment: "Title of the media feeds view.")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: FONT_SIZE_25)]
        
        CommonUtility.createCustomRightButton(self, navBarItem: self.navigationItem, strImage: "retry", select: #selector(getInstagramMedia))
        CommonUtility.createCustomLeftButton(self, navBarItem: self.navigationItem, strImage: "logout", select: #selector(logout))
    }
    
    //This method is used to call the view model to get the photos from the server in a list and reload the collectionView.
    @objc private func getInstagramMedia() {
        self.photoGalleryViewModel.access_token  = UserDefaults.standard.value(forKey: UserDefaultsKeys.AuthToken) as! String
        self.photoGalleryViewModel.getInstagramMediaList { (modelData) in
            self.photoGalleryViewModel.userMediaItemList = modelData
            self.collectionView.reloadData()
        }
    }
    
    @objc private func logout() {
        self.photoGalleryViewModel.logout(navC: self.navigationController!)
    }
}

//MARK: extensions
extension PhotoGalleryViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let mediaItems = self.photoGalleryViewModel.userMediaItemList else {
            return 0
        }
        return mediaItems.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoGalleryCollectionViewCell
        guard let mediaItem = self.photoGalleryViewModel.userMediaItemList?.data[indexPath.row] else {
            return cell
        }
        cell.styleCollectionViewCell(mediaItem: mediaItem)
        return cell
    }
}

//CollectionView Delegate method, used when the user tap on the photo in the gallery, then it would be pass the data to PhotoGalleryDetailViewController.
extension PhotoGalleryViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PhotoGalleryDetailViewController") as! PhotoGalleryDetailViewController
        vc.imageConfigInfo = self.photoGalleryViewModel.userMediaItemList?.data[indexPath.row].images.standard_resolution
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PhotoGalleryViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width : cellSize , height : cellSize)
    }
}

//MARK: EmptyDataSource and Delegates
//These the delegate, datasource methods of the EmptyDataSet, which are used to represent the empty tableview or collectionview.
extension PhotoGalleryViewController: EmptyDataSetSource, EmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return CommonUtility.dzEmptySetTitle(title: NSLocalizedString("title.error.nodata", comment: "This string shows when there is no data found."))
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        if self.photoGalleryViewModel.userMediaItemList != nil {
            return true
        }
        return false
    }
}
