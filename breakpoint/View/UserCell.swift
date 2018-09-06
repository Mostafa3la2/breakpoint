//
//  UserCell.swift
//  breakpoint
//
//  Created by Mostafa Alaa on 9/4/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var checkMarkImg: UIImageView!
    
    @IBOutlet weak var emailLbl: UILabel!
    
    var showToggle = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(profileImage:UIImage,email:String,isSelected:Bool){
        self.profileImage.image = profileImage
        self.emailLbl.text = email
        self.checkMarkImg.isHidden = !isSelected
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            if !showToggle{
                checkMarkImg.isHidden = false
                showToggle = true
            }else{
                checkMarkImg.isHidden = true
                showToggle = false
            }
        }
    }

}
