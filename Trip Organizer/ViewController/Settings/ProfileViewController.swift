//
//  ProfileViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 28/04/22.
//

import UIKit

class ProfileViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var user: User?
    
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchUser()
        usernameTextField.text = user!.username
        
        hideKeyboardWhenTappedAround()
    }
    
    func fetchUser() {
        
        do {
            self.user = try context.fetch(User.fetchRequest())[0]
        }
        catch {
            print("error")
        }
        
    }
    
    func saveData() {
        do {
            try self.context.save()
        }
        catch {
            
        }
    }
    
    @IBAction func saveChangesButtonTapped(_ sender: UIButton) {
        self.user?.username = self.usernameTextField.text
        saveData()
        performSegue(withIdentifier: "unwind", sender: self)
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
