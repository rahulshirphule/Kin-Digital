//
//  NewsTitleCell.swift
//  newsr
//
//  Created by Rahul Shirphule on 2019/10/07.
//  Copyright © 2019 Bryn Divey. All rights reserved.
//

import UIKit

class NewsTitleCell: UITableViewCell {

    @IBOutlet var imgNews: UIImageView!
    
    @IBOutlet var lblDescription: UILabel!
    
    @IBOutlet var containerView: UIView!
    private var shadowLayer: CAShapeLayer!
    private var fillColor: UIColor = .clear // the color applied to the shadowLayer, rather than the view's backgroundColor
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
         layer.rasterizationScale = 1

    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
