//
//  DetailsViewController.swift
//  GetGoingClass
//
//  Created by MCDA5550 on 2019-02-08.
//  Copyright © 2019 SMU. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var placeDetails: PlaceDetails!
    
    func showActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        websiteLabel.text = placeDetails.websiteLabel ?? ""
        phoneLabel.text = placeDetails.formatterPhoneNumber ?? ""
        activityIndicator.isHidden = true
      
    }
    

    

}
