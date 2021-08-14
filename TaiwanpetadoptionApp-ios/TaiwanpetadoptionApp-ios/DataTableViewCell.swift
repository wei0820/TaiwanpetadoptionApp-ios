//
//  DataTableViewCell.swift
//  TaiwanpetadoptionApp-ios
//
//  Created by mac on 2021/8/10.
//

import Foundation
import UIKit

class DataTableViewCell: UITableViewCell{
    
    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var kindUILabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var createTimeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
