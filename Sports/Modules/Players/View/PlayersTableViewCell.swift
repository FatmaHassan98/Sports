//
//  PlayersTableViewCell.swift
//  Sports
//
//  Created by Fatma_Hassan on 25/05/2023.
//

import UIKit

class PlayersTableViewCell: UITableViewCell {

    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!
    
    
    @IBOutlet weak var playerType: UILabel!
    
    
    @IBOutlet weak var playerNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}
