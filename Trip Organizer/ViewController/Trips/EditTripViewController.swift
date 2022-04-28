//
//  EditTripViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 28/04/22.
//

import UIKit
import Contacts
import ContactsUI

class EditTripViewController: UIViewController, CNContactPickerDelegate {

    var trip: Trip?
    var friends: [Friend]?
    var places: [Place]?
    var bucketList: [Place]?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var tripNameTextField: UITextField!
    @IBOutlet weak var tripDateTextField: UITextField!
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var placesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tripNameTextField.text = trip!.name
        tripDateTextField.text = dateToString(date: trip!.date!)
        
        self.friends = trip!.friends
        self.places = trip!.destinations?.array as! [Place]
        self.bucketList = trip!.creator?.bucketList?.array as! [Place]
        
        let date = Date()
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 250)
        tripDateTextField.inputView = datePicker
        
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
        
        placesTableView.dataSource = self
        placesTableView.delegate = self

        friendsTableView.separatorStyle = .none
        placesTableView.separatorStyle = .none
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTables()
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        tripDateTextField.text = dateToString(date: sender.date)
        tripDateTextField.endEditing(true)
    }
    
    func stringToDate(str: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.date(from: str) ?? Date()
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    @IBAction func saveChangesButtonTapped(_ sender: UIButton) {
        self.trip!.name = tripNameTextField.text
        self.trip!.date = stringToDate(str: tripDateTextField.text ?? "01 Jan 2022")
        self.trip?.removeFromDestinations((self.trip?.destinations)!) // delete current destination
        self.trip?.addToDestinations(NSOrderedSet(array: self.places!))
        self.trip?.friends = self.friends
        
        // TODO: save trip places
        
        saveData()
        
        performSegue(withIdentifier: "unwind", sender: self)
    }
    
    @IBAction func addFriendButtonTapped(_ sender: UIButton) {
        let contactPickerVC = CNContactPickerViewController()
        contactPickerVC.delegate = self
        present(contactPickerVC, animated: true)
    }
    
    @IBAction func addPlaceButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoPickPlaces", sender: self)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let newParticipant = Friend(source: contact)
        self.friends?.append(newParticipant)
        reloadTables()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwind" {
            let destinationVC = segue.destination as? ViewTripViewController
            destinationVC?.trip = self.trip
        }
        else if segue.identifier == "gotoPickPlaces" {
            let destinationVC = segue.destination as? PickPlacesViewController
            destinationVC?.selectedPlaces = self.places
            destinationVC?.places = self.bucketList
            destinationVC?.sourceViewController = "EditTripViewController"
        }
    }
    
    func reloadTables() {
        DispatchQueue.main.async {
            self.friendsTableView.reloadData()
            self.placesTableView.reloadData()
        }
    }
    
    func saveData() {
        do {
            try self.context.save()
        }
        catch {
            
        }
    }
    
    @IBAction func unwindFromPickPlaces(_ sender: UIStoryboardSegue) {}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EditTripViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == friendsTableView {
            return self.friends?.count ?? 0
        }
        return self.places?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == friendsTableView {
            let cell = friendsTableView.dequeueReusableCell(withIdentifier: "friendCell") as! EditTripFriendTableViewCell
            cell.friendNameLabel.text = self.friends?[indexPath.row].name ?? "Default"
            cell.friendImageView.image = self.friends?[indexPath.row].getImageThumbnail()
            return cell
        }
        let cell = placesTableView.dequeueReusableCell(withIdentifier: "placeCell") as! EditTripPlaceTableViewCell
        cell.placeNameLabel.text = places?[indexPath.row].name
        return cell
    }
    
}

extension EditTripViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            if tableView == self.friendsTableView {
                self.friends!.remove(at: indexPath.row)
            }
            else {
                
                let placeToBeRemoved = self.places![indexPath.row]
                
                placeToBeRemoved.selected = false
                
                self.places!.remove(at: indexPath.row)
                
            }
            
            self.reloadTables()
            
        }

        return UISwipeActionsConfiguration(actions: [action])
        
    }
}
