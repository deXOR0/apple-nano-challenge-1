//
//  SettingsViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 28/04/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let settings = [
        "Profile",
        "User Data",
        "About"
    ]
    
    @IBOutlet weak var settingsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
    }
    
    @IBAction func unwindToSettings(_ sender: UIStoryboardSegue) {}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        
        cell.textLabel?.text = settings[indexPath.row]
        
        return cell
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "gotoProfile", sender: self)
        case 1:
            performSegue(withIdentifier: "gotoUserData", sender: self)
        case 2:
            performSegue(withIdentifier: "gotoAbout", sender: self)
        default:
            break
        }
        
//        performSegue(withIdentifier: "gotoViewMemory", sender: self)
    }
    
}
