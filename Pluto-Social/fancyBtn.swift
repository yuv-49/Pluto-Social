//
//  fancyBtn.swift
//  Pluto-Social
//
//  Created by yuvraj singh on 17/09/16.
//  Copyright © 2016 Pluto Inc. All rights reserved.
//

import UIKit

class fancyBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
    
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: SHADOW_GRAY).cgColor
        layer.shadowOpacity = 0.0
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    


}
