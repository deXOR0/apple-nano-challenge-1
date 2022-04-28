//
//  ViewMemoryViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 28/04/22.
//

import UIKit

class ViewMemoryViewController: UIViewController {
    
    var trip: Trip?
    var friends: [Friend]?
    var places: [Place]?

    @IBOutlet weak var tripNameTextField: UITextField!
    @IBOutlet weak var tripDateTextField: UITextField!
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var placesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
        
        placesTableView.dataSource = self
        placesTableView.delegate = self

        friendsTableView.separatorStyle = .none
        placesTableView.separatorStyle = .none
    }
    
    @IBAction func viewMemoryButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoViewJournal", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tripNameTextField.text = trip!.name
        tripDateTextField.text = dateToString(date: trip!.date!)
        
        self.friends = trip!.friends
        self.places = trip!.destinations?.array as! [Place]
        
        reloadTables()
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    func reloadTables() {
        DispatchQueue.main.async {
            self.friendsTableView.reloadData()
            self.placesTableView.reloadData()
        }
    }
    
    @IBAction func unwindToViewMemory(_ sender: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoViewJournal" {
            let viewPlaceVC = segue.destination as? ViewJournalViewController
            viewPlaceVC?.trip = self.trip
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

extension ViewMemoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == friendsTableView {
            return self.friends?.count ?? 0
        }
        return self.places?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == friendsTableView {
            let cell = friendsTableView.dequeueReusableCell(withIdentifier: "friendCell") as! ViewTripFriendTableViewCell
            cell.friendImageView.image = self.friends?[indexPath.row].getImageThumbnail()
            cell.friendNameLabel.text = self.friends?[indexPath.row].name as! String
            
            return cell
        }
        let cell = placesTableView.dequeueReusableCell(withIdentifier: "placeCell") as! ViewTripPlaceTableViewCell
        
        cell.placeNameLabel.text = self.places?[indexPath.row].name as! String
        
        return cell
    }
    
}

extension ViewMemoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}
