//
//  FeedCell.swift
//  breakpoint
//
//  Created by Mostafa Alaa on 9/3/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {


    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    
    func configureCell(profileImage:UIImage,email:String,content:String){
        self.profileImage.image = profileImage
        self.emailLbl.text = email
        self.contentLbl.text = content
    }
    
}
