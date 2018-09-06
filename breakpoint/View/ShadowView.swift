//
//  ShadowView.swift
//  breakpoint
//
//  Created by Mostafa Alaa on 8/31/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowView: UIView {

    func setupView(){
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
    }
    override func prepareForInterfaceBuilder() {
        super.awakeFromNib()
        setupView()
    }
}
