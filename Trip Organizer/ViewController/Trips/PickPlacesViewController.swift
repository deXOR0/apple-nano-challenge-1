//
//  PickPlacesViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 28/04/22.
//

import UIKit

class PickPlacesViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var places: [Place]?
    var selectedPlaces: [Place]?
    var sourceViewController: String?
    
    @IBOutlet weak var placesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        places = places?.filter { !$0.selected }
        
        placesTableView.dataSource = self
        placesTableView.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwind" {
            if self.sourceViewController == "AddTripViewController" {
                let destinationVC = segue.destination as? AddTripViewController
                destinationVC?.places = self.selectedPlaces
                destinationVC?.bucketList = self.places
            }
            else {
                let destinationVC = segue.destination as? EditTripViewController
                destinationVC?.places = self.selectedPlaces
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PickPlacesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = placesTableView.dequeueReusableCell(withIdentifier: "placeCell") as! PickPlaceTableViewCell
        
        print(self.places?[indexPath.row].name)
        print(self.places?[indexPath.row].address)
        
        cell.placeNameLabel.text = self.places?[indexPath.row].name as! String
        cell.addressLabel.text = self.places?[indexPath.row].address as! String
        
        return cell
    }
    
}

extension PickPlacesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlace = self.places![indexPath.row]
        selectedPlace.selected = true
        self.selectedPlaces!.append(selectedPlace)
        performSegue(withIdentifier: "unwind", sender: self)
    }
    
}

