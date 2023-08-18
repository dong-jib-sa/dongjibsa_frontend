//
//  OnboardingImageCell.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/02.
//

import UIKit

class OnboardingImageCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    func configure(_ image: Onboarding) {
        thumbnailImageView.image = UIImage(named: image.imageName)
    }
}
