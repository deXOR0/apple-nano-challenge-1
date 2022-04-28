//
//  InitialLoadViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 26/04/22.
//

import UIKit
import CoreData

class InitialLoadViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var users:[User] = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkIfUserExisted()
    }
    
    func checkIfUserExisted() {
        
        do {
            self.users = try context.fetch(User.fetchRequest())
            if self.users.isEmpty {
                performSegue(withIdentifier: "gotoOnboarding", sender: self)
            }
            else {
                performSegue(withIdentifier: "gotoMain", sender: self)
            }
        }
        catch {
            print("error")
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "gotoMain" {
//            let destinationVC = segue.destination as? ViewController
//            destinationVC?.user = self.user
//            print(destinationVC?.user?.username)
//        }
//    }
    
    @IBAction func unwindToInitialLoad(_ sender: UIStoryboardSegue) {}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
