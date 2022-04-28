//
//  AddTripViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 27/04/22.
//

import UIKit
import Contacts
import ContactsUI

class AddTripViewController: UIViewController, CNContactPickerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var newTrip: Trip?
    var user: User?
    var places: [Place]?
    var bucketList: [Place]?

    @IBOutlet weak var placeTableView: UITableView!
    @IBOutlet weak var participantTableView: UITableView!
    @IBOutlet weak var tripDateTextField: UITextField!
    @IBOutlet weak var tripNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchData()
        newTrip = Trip(context: context)
        newTrip?.friends = [Friend]()
        places = [Place]()
        let date = Date()
        
        tripDateTextField.text = dateToString(date: date)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 250)
        tripDateTextField.inputView = datePicker
        
        participantTableView.dataSource = self
        placeTableView.dataSource = self
        
        participantTableView.delegate = self
        placeTableView.delegate = self
        
        participantTableView.separatorStyle = .none
        placeTableView.separatorStyle = .none
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTables()
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        tripDateTextField.text = dateToString(date: sender.date)
        tripDateTextField.endEditing(true)
    }
    
    @IBAction func addParticipantTapped(_ sender: UIButton) {
        let contactPickerVC = CNContactPickerViewController()
        contactPickerVC.delegate = self
        present(contactPickerVC, animated: true)
        
    }
    
    @IBAction func addPlaceTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoPickPlaces", sender: self)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let newParticipant = Friend(source: contact)
        newTrip?.friends?.append(newParticipant)
        reloadTables()
    }
    
    func fetchData() {
        
        do {
            self.user = try context.fetch(User.fetchRequest())[0]
            self.bucketList = self.user!.bucketList?.array as! [Place]
        }
        catch {
            print("error")
        }
        reloadTables()
    }
    
    func reloadTables() {
        DispatchQueue.main.async {
            self.participantTableView.reloadData()
            self.placeTableView.reloadData()
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        self.newTrip!.name = tripNameTextField.text
        self.newTrip!.date = stringToDate(str: tripDateTextField.text ?? "01 Jan 2022")
        self.newTrip?.addToDestinations(NSOrderedSet(array: self.places!))
        self.user!.addToTrips(self.newTrip!)
        // TODO: save trip places
        
        saveData()
        
        performSegue(withIdentifier: "unwind", sender: self)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoPickPlaces" {
            let destinationVC = segue.destination as? PickPlacesViewController
            destinationVC?.selectedPlaces = self.places
            destinationVC?.places = self.bucketList
            destinationVC?.sourceViewController = "AddTripViewController"
        }
    }
    
    func saveData() {
        do {
            try self.context.save()
        }
        catch {
            
        }
        fetchData()
    }
    
    @IBAction func unwindToAddTrip(_ sender: UIStoryboardSegue) {}
    
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

extension AddTripViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == participantTableView {
            return self.newTrip?.friends?.count ?? 0
        }
        return self.places?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == participantTableView {
            let cell = participantTableView.dequeueReusableCell(withIdentifier: "participantCell") as! AddTripFriendTableViewCell
            cell.participantNameLabel.text = self.newTrip?.friends?[indexPath.row].name ?? "Default"
            cell.participantImageView.image = self.newTrip?.friends?[indexPath.row].getImageThumbnail()
            return cell
        }
        let cell = placeTableView.dequeueReusableCell(withIdentifier: "placeCell") as! AddTripPlaceTableViewCell
        cell.placeNameLabel.text = places?[indexPath.row].name
        return cell
    }
    
}

extension AddTripViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            if tableView == self.participantTableView {
                self.newTrip!.friends!.remove(at: indexPath.row)
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
