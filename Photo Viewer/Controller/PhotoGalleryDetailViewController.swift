//
//  PhotoGalleryDetailViewController.swift
//  Photo Viewer
//
//  Created by cdn68 on 29/06/18.
//  Copyright © 2018 cdn. All rights reserved.
//

import UIKit
import SDWebImage
import CoreImage

class PhotoGalleryDetailViewController: UIViewController {
    
    var imageConfigInfo: ImageConfigurations!
    @IBOutlet private weak var imgPhoto: UIImageView!
    @IBOutlet private weak var collectionView: UICollectionView!
    private var filteredImageList = [UIImage]()
    
    private var CIFilterNames = [
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CISepiaTone"
    ]
    
    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.styleUI()
        self.styleNavigationBar()
        self.configureInitialParameters()
    }
    
    private func styleUI() {
        self.imgPhoto.sd_setShowActivityIndicatorView(true)
        self.imgPhoto.sd_setIndicatorStyle(.gray)
        self.imgPhoto.sd_setImage(with: URL(string: self.imageConfigInfo.url), placeholderImage: #imageLiteral(resourceName: "no-image"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            if error == nil {
                self.imgPhoto.image = image
                self.createFilteredImages()
            }
        })
    }
    
    private func styleNavigationBar() {
        CommonUtility.createCustomLeftButton(self, navBarItem: self.navigationItem, strImage: "back", select: #selector(popView))
    }
    
    @objc private func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureInitialParameters() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func createFilteredImages() {
        for filter in CIFilterNames {
            let ciContext = CIContext(options: nil)
            let coreImage = CIImage(image: self.imgPhoto.image!)
            let filter = CIFilter(name: filter )
            filter!.setDefaults()
            filter!.setValue(coreImage, forKey: kCIInputImageKey)
            let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
            let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
             self.filteredImageList.append(UIImage(cgImage: filteredImageRef!))
        }
        self.collectionView.reloadData()
    }
}

extension PhotoGalleryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count -- \(self.filteredImageList.count)")
        return self.filteredImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoGalleryDetailCollectionViewCell
        cell.styleCollectionViewCell(image: self.filteredImageList[indexPath.row])
        return cell
    }
}

extension PhotoGalleryDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.imgPhoto.image = self.filteredImageList[indexPath.row]
    }
}
