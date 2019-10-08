//
//  ArticleViewCell.swift
//  newsr
//
//  Created by Rahul Shirphule on 2019/10/08.
//  Copyright © 2019 Bryn Divey. All rights reserved.
//

import UIKit

class ArticleViewCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    @IBOutlet var lblArticle: UILabel!
    @IBOutlet var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
