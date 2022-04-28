//
//  UserDataViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 28/04/22.
//

import UIKit

class UserDataViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetUserDataButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Delete User Data", message: "Are you sure you want to delete user data? This action cannot be undone!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            var persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
            let storeContainer = persistentContainer.persistentStoreCoordinator
            
            self.performSegue(withIdentifier: "unwind", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
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
