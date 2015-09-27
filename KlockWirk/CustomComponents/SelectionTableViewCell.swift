//
//  SelectionTableViewCell.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/27/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        selectedImageView.hidden = true
        selectionStyle = .None
  
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    func setIsImageViewHidden(isHidden: Bool){
        
        selectedImageView.hidden = isHidden
    }
    
    
    func bindCellDetails(lblValue: String){
        
        cellLabel.text = lblValue
    }
    
}
