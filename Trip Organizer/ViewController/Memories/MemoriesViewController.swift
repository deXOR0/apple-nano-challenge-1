//
//  MemoriesViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 28/04/22.
//

import UIKit

class MemoriesViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var user: User?
    var trips: [Trip]?
    var tripToView: Trip?
    
    
    @IBOutlet weak var tripsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fetchData()
        
        tripsTableView.dataSource = self
        tripsTableView.delegate = self
        
        tripsTableView.separatorStyle = .none
        tripsTableView.showsVerticalScrollIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }
    
    func fetchData() {
        
        do {
            self.user = try context.fetch(User.fetchRequest())[0]
            self.trips = self.user?.trips?.array as! [Trip]
            self.trips = self.trips?.filter { $0.completed }
        }
        catch {
            print("error")
        }
        DispatchQueue.main.async {
            self.tripsTableView.reloadData()
        }
        
    }
    
    @IBAction func unwindToMemories(_ sender: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoViewMemory" {
            let viewPlaceVC = segue.destination as? ViewMemoryViewController
            viewPlaceVC?.trip = self.tripToView
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
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }

}

extension MemoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trips?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tripsTableView.dequeueReusableCell(withIdentifier: "tripCell") as! MemoriesTripTableViewCell
        
        cell.tripNameLabel.text = self.trips?[indexPath.row].name as! String
        cell.tripDateLabel.text = self.dateToString(date:  self.trips?[indexPath.row].date ?? Date())
        cell.tripFriendsCountLabel.text = "\(self.trips![indexPath.row].friends!.count + 1 ?? 1)"
        cell.tripPlacesCountLabel.text = "\(self.trips?[indexPath.row].destinations?.count ?? 1)"
        
        return cell
    }
    
}

extension MemoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tripToView = self.trips![indexPath.row]
        performSegue(withIdentifier: "gotoViewMemory", sender: self)
    }
    
}
