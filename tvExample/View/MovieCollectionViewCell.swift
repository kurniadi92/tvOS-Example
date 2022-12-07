//
//  MovieCollectionViewCell.swift
//  tvExample
//
//  Created by Kurniadi on 5/12/22.
//

import UIKit

struct Content {
    let title: String
    let imageName: String
    let isMovie: Bool
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieIcon: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setItem(content: Content) {
        movieIcon.isHidden = !content.isMovie
        imageView.image = UIImage(named: content.imageName)
        titleLabel.text = content.title
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView == self {
            coordinator.addCoordinatedAnimations({ () -> Void in
                self.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }, completion: nil)
        } else if context.previouslyFocusedView == self {
            coordinator.addCoordinatedAnimations({ () -> Void in
                self.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }, completion: nil)
        }
    }
}
