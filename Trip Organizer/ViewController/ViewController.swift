//
//  ViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 26/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var user: User?
    var trips: [Trip]?

    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var upcomingTripTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUser()
        upcomingTripTableView.dataSource = self
        upcomingTripTableView.delegate = self
        greetingsLabel.text = "Welcome, \(user?.username ?? "User")"
    }
    
    func fetchUser() {
        
        do {
            self.user = try context.fetch(User.fetchRequest())[0]
            self.trips = self.user?.trips?.array as! [Trip]
            self.trips = self.trips!.filter { !$0.completed }
            self.trips?.sort{ $0.date! < $1.date! }
        }
        catch {
            print("error")
        }
        DispatchQueue.main.async {
            self.upcomingTripTableView.reloadData()
        }
        
    }

    func getDate(dateStr: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.date(from: dateStr) ?? Date()
    }
    
    
    @IBAction func tripsButtonTapped(_ sender: UIButton) {
        print("Click")
        performSegue(withIdentifier: "gotoTrips", sender: self)
    }
    
    @IBAction func bucketListButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoBucketList", sender: self)
    }
    
    @IBAction func memoriesButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoMemories", sender: self)
    }
    
    @IBAction func settingsButtonTaped(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoSettings", sender: self)
    }
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {}

    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trips!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = upcomingTripTableView.dequeueReusableCell(withIdentifier: "tripCell") as! MainTripTableViewCell
        
        cell.tripNameLabel.text = self.trips![indexPath.row].name as! String
        cell.tripDateLabel.text = self.dateToString(date: self.trips![indexPath.row].date!)
        cell.participantCountLabel.text = "\(self.trips![indexPath.row].friends!.count + 1 ?? 1)"
        cell.locationCountLabel.text = "\(self.trips![indexPath.row].destinations?.count ?? 1)"
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79.0
    }
    
}



