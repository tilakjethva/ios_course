//
//  ProjectsCell.swift
//  Practice
//
//  Created by Tilak Jethva on 18/08/2020.
//  Copyright © 2020 Tilak Jethva. All rights reserved.
//

import UIKit

class ProjectsCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblProjectName: UILabel!
    @IBOutlet weak var lblProjectLang: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgView.layer.cornerRadius = imgView.frame.size.height/2
        imgView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
