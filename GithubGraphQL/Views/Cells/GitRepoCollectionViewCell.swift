//
//  GitRepoCollectionViewCell.swift
//  GithubGraphQL
//
//  Created by Jake Haslam on 5/18/22.
//  Copyright © 2022 test. All rights reserved.
//

import UIKit

class GitRepoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var avatarImageView: AsyncImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.avatarImageView.image = nil
        self.nameLabel.text = nil
        self.starCountLabel.text = nil
    }
    
}
