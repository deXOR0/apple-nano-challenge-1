//
//  AddPlaceViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 27/04/22.
//

import UIKit

class AddPlaceViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var user: User?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var linktTextField: UITextField!
    @IBOutlet weak var notesTextArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchUser()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let newPlace = Place(context: context)
        
        newPlace.name = nameTextField.text
        newPlace.address = addressTextField.text
        newPlace.link = linktTextField.text
        newPlace.notes = notesTextArea.text
        
        user?.addToBucketList(newPlace)
        
        print(user!.bucketList)
        
        saveData()
        
        performSegue(withIdentifier: "unwind", sender: self)
    }
    
    func saveData() {
        do {
            try self.context.save()
        }
        catch {
            
        }
    }
    
    func fetchUser() {
        do {
            self.user = try context.fetch(User.fetchRequest())[0]
        }
        catch {
            print("error")
        }
    }
    
    @IBAction func unwindToAddPlace(_ sender: UIStoryboardSegue) {}

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
