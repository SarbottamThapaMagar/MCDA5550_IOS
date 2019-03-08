//
//  SearchResultsViewController.swift
//  GetGoingClass
//
//  Created by Alla Bondarenko on 2019-01-23.
//  Copyright © 2019 SMU. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var segmentButtonSort: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

//    @IBOutlet weak var segementButton: UISegmentedControl!
//    //MARK: - Properties

    var places: [PlaceDetails]!

    @IBAction func segmentActionSort(_ sender: UISegmentedControl) {
        
        reloadData()
    }
    
    // MARK: - View Controller

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        let nib = UINib(nibName: "SearchResultTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SearchResultTableViewCell")
        places.sort(by: {$0.name ?? "" < $1.name ?? ""})
    }
    
    



    func reloadData(){

        if(segmentButtonSort.selectedSegmentIndex == 0){
            places.sort(by: {$0.name ?? "" < $1.name ?? ""})
        }else if(segmentButtonSort.selectedSegmentIndex == 1){
            places.sort(by: {$0.rating ?? 0.0 > $1.rating  ?? 0.0})
        }
        tableView.reloadData()
    }

}
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as? SearchResultTableViewCell else { return UITableViewCell() }
        let place = places[indexPath.row]
        cell.nameLabel.text = place.name
        cell.vicinityLabel.text = place.address
        if let placeRating = place.rating {
            cell.rating.rating = Int(placeRating.rounded(.down))
        }
        guard let iconStr = place.icon,
            let iconURL = URL(string: iconStr),
            let imageData = try? Data(contentsOf: iconURL) else {
                cell.iconImageView.image = UIImage(named: "StarEmpty")
                return cell
        }
        cell.iconImageView.image = UIImage(data: imageData)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row was selected at \(indexPath.section) \(indexPath.row)")
        
        print(places[indexPath.row].placeid ?? "what is this")
        let placeid = places[indexPath.row].placeid
        

        if placeid == nil {
            
            DispatchQueue.main.async {
                self.showErrorAlert(message: "No such result found")
            }
            return
        }
        GooglePlacesAPI.requestPlaceDetails(placeid!) { (status, json) in
            print(json ?? "")
           print("inside Google API")
            print(json)
            guard let jsonObj = json else { return }
            print(jsonObj)
            let result = APIParser.parsePlaceDetails(jsonObj: jsonObj)
            if result != nil {
                print("controller called")

                 self.displayPlaceDetails(placeDetails: result!)
            } else {
                print("result nil")
                DispatchQueue.main.async {
                    self.showErrorAlert(message: "No results found")
                }
            }
        }
    }
    
    
    
    func displayPlaceDetails(placeDetails: PlaceDetails) {
        
        print("DetailsViewController")
        guard let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        
        detailsViewController.placeDetails = placeDetails
        
        DispatchQueue.main.async {
            print("NavigationController")
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
    
    func showErrorAlert(title: String = "Error", message: String?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okButtonAction = UIAlertAction(title: "Ok",
                                           style: .default,
                                           handler: nil)
        alert.addAction(okButtonAction)
        present(alert, animated: true)
    }
    
 
}
