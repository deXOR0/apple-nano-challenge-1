//
//  EditPlaceViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 28/04/22.
//

import UIKit

class EditPlaceViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var place: Place?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var notesTextArea: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextField.text = place!.name
        addressTextField.text = place!.address
        linkTextField.text = place!.link
        notesTextArea.text = place!.notes
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func saveChangesButtonTapped(_ sender: UIButton) {
        
        self.place!.name = nameTextField.text
        self.place!.address = addressTextField.text
        self.place!.link = linkTextField.text
        self.place!.notes = notesTextArea.text
        
        saveData()
        
        performSegue(withIdentifier: "unwind", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwind" {
            let destinationVC = segue.destination as? ViewPlaceViewController
            destinationVC?.place = self.place
        }
    }
    
    func saveData() {
        do {
            try self.context.save()
        }
        catch {
            
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
