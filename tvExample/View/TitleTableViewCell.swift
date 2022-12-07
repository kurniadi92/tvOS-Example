//
//  TitleTableViewCell.swift
//  tvExample
//
//  Created by Kurniadi on 5/12/22.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func setTitle(text: String) {
        titleLabel.text = text
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView == self {
            self.titleLabel.textColor = .black
        } else {
            self.titleLabel.textColor = .white
        }
    }
}
