//
//  OnboardingViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 26/04/22.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var name: String = ""
    var users: [User] = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        self.name = nameTextField.text ?? ""
        if self.name != "" {
            createNewUser()
            performSegue(withIdentifier: "unwind", sender: self)
        }
    }
    
    func createNewUser() {
        let newUser = User(context: self.context)
        newUser.username = self.name
        
        do {
            try self.context.save()
        }
        catch {
            
        }
    }
    
    func fetchUser() {
        do {
            self.users = try context.fetch(User.fetchRequest())
        }
        catch {
            
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "gotoMain" {
//            let destinationVC = segue.destination as? ViewController
//            destinationVC?.user = self.users[0]
//        }
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
