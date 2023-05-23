//
//  DetailsCollectionViewCell.swift
//  Sports
//
//  Created by Fatma_Hassan on 22/05/2023.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var firstImage: UIImageView!
    
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var secondImage: UIImageView!
    
    @IBOutlet weak var secondName: UILabel!
    
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var dateMatch: UILabel!
    
    @IBOutlet weak var timeMatch: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
