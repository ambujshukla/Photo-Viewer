
//
//  PhotoGalleryDetailCollectionViewCell.swift
//  Photo Viewer
//
//  Created by Ambuj Shukla on 30/06/18.
//  Copyright © 2018 cdn. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoGalleryDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imgPhoto: UIImageView!
    
    func styleCollectionViewCell(image: UIImage) {
        self.imgPhoto.image = image
    }
}
