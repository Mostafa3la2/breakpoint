//
//  GroupFeedCell.swift
//  breakpoint
//
//  Created by Mostafa Alaa on 9/5/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

   
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
   
    @IBOutlet weak var contentLbl: UILabel!
    
    func configureCell(profileImg:UIImage,email:String,content:String){
        
        self.profileImg.image = profileImg
        self.emailLbl.text = email
        self.contentLbl.text = content
    }
}
