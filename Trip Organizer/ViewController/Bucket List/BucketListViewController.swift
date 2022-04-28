//
//  BucketListViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 27/04/22.
//

import UIKit

class BucketListViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var places: [Place]?
    var placeToView: Place?
    
    @IBOutlet weak var placesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        placesTableView.dataSource = self
        placesTableView.delegate = self
        
        placesTableView.separatorStyle = .none
        placesTableView.showsVerticalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func fetchData() {
        
        do {
            let user = try context.fetch(User.fetchRequest())[0]
            self.places = user.bucketList?.array as! [Place]
            self.places = self.places?.filter { !$0.selected }
            print(self.places)
        }
        catch {
            print("error")
        }
        DispatchQueue.main.async {
            self.placesTableView.reloadData()
        }
    }
    
    @IBAction func addPlaceTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "gotoAddPlace", sender: self)
    }
    
    @IBAction func unwindToBucketList(_ sender: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoViewPlace" {
            let viewPlaceVC = segue.destination as? ViewPlaceViewController
            viewPlaceVC?.place = self.placeToView
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

extension BucketListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = placesTableView.dequeueReusableCell(withIdentifier: "placeCell") as! BucketListPlaceTableViewCell
        
        cell.placeNameLabel.text = self.places?[indexPath.row].name as! String
        cell.addressLabel.text = self.places?[indexPath.row].address as! String
        
        return cell
    }
    
}

extension BucketListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.placeToView = self.places![indexPath.row]
        performSegue(withIdentifier: "gotoViewPlace", sender: self)
    }
    
}
