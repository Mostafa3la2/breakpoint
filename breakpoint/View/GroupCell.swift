//
//  GroupCell.swift
//  breakpoint
//
//  Created by Mostafa Alaa on 9/5/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    
        
    func configureCell(title:String,description:String,memberCount:Int){
        self.groupDescLbl.text = description
        self.groupTitleLbl.text = title
        self.membersLbl.text = "\(memberCount) members"
    }

}
