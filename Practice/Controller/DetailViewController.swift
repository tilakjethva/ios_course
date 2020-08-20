//
//  DetailViewController.swift
//  Practice
//
//  Created by Tilak Jethva on 19/08/2020.
//  Copyright © 2020 Tilak Jethva. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblURL : UILabel!
    @IBOutlet weak var lblProjectName : UILabel!
    @IBOutlet weak var lblProjectURL : UILabel!
    @IBOutlet weak var lblForkURL : UILabel!
    @IBOutlet weak var lblSize : UILabel!
    @IBOutlet weak var lblLanguage : UILabel!
    @IBOutlet weak var lblIssues : UILabel!
    
    var project: Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgView.layer.cornerRadius = imgView.frame.size.height/2
        imgView.layer.masksToBounds = true
        
        if let pro = project {
            setValues(project: pro)
        }
    }
    
    func setValues(project: Project?) {
        imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgView.sd_setImage(with: URL(string: project?.owner.avatarURL ?? ""), placeholderImage: UIImage(named: "user"))
        lblURL.text = project?.owner.url ?? "NOT AVAILABLE"
        lblUserName.text = project?.owner.login ?? "NOT AVAILABLE"
        lblProjectName.text = project?.name ?? "NOT AVAILABLE"
        lblProjectURL.text = project?.url ?? "NOT AVAILABLE"
        lblForkURL.text = project?.forksURL ?? "NOT AVAILABLE"
        lblSize.text = "\(project?.size ?? 0)"
        lblLanguage.text = project?.language ?? "NOT AVAILABLE"
        lblIssues.text = "\(project?.openIssuesCount ?? 0)"
    }

}
