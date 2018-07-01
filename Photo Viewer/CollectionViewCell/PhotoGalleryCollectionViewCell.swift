//
//  PhotoGalleryCollectionViewCell.swift
//  Photo Viewer
//
//  Created by cdn68 on 29/06/18.
//  Copyright © 2018 cdn. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoGalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imgPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgPhoto.sd_setShowActivityIndicatorView(true)
        self.imgPhoto.sd_setIndicatorStyle(.gray)
    }
    
    func styleCollectionViewCell(mediaItem: MediaData) {
        self.imgPhoto.sd_setImage(with: URL(string: mediaItem.images.thumbnail.url), placeholderImage: #imageLiteral(resourceName: "no-image"))
    }
}
