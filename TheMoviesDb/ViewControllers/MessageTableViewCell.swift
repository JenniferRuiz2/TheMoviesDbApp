//
//  MessageTableViewCell.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 21/06/21.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameTF: UILabel!
    @IBOutlet weak var messageTF: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        backView.layer.masksToBounds = false
        backView.layer.cornerRadius = 9
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 0.5
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 5
    }
    
}
