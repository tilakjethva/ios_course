//
//  ViewController.swift
//  Practice
//
//  Created by Tilak Jethva on 18/08/2020.
//  Copyright © 2020 Tilak Jethva. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SDWebImage

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    var arrProjects: [Project]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Projects"
        
        arrProjects = [Project]()
        
        self.tblView.delegate = self
        self.tblView.dataSource = self
        
        fetchProjects(url: REPO_USER1_URL)
        fetchProjects(url: REPO_USER2_URL)
    }
    
    func fetchProjects(url: String) {
        
        genericGET(urlString: url) { (projects: [Project]?) in
            if let pros = projects {
                self.arrProjects?.append(contentsOf: pros)
                self.tblView.reloadData()
            }
        }
    }
    
    
    func genericGET<T: Decodable>(urlString: String, completion: @escaping (T?) -> ()) {
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        AF.request(urlString).responseJSON { response in
            // check for errors
            switch response.result {
            case .success(_):
                UIViewController.removeSpinner(spinner: sv)
                do {
                    let obj = try JSONDecoder().decode(T.self, from: response.data!)
                    completion(obj)
                } catch let jsonErr {
                    print("Failed to decode json:", jsonErr)
                }
                
                break
                
            case .failure(_):
                UIViewController.removeSpinner(spinner: sv)
                completion(nil)
                break
            }
        }
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProjects!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "ProjectsCell", for: indexPath) as! ProjectsCell
        
        if let x = arrProjects?[indexPath.row] {
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: x.owner.avatarURL), placeholderImage: UIImage(named: "user"))
            cell.lblProjectName.text = x.name
            cell.lblProjectLang.text = x.language
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.project = arrProjects?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }

        return spinnerView
    }

    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

