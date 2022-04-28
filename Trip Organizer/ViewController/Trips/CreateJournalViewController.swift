//
//  CreateJournalViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 28/04/22.
//

import UIKit

class CreateJournalViewController: UIViewController {
    
    var trip: Trip?

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var tripNameTextField: UITextField!
    @IBOutlet weak var tripDateTextField: UITextField!
    @IBOutlet weak var tripJournalTextArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tripNameTextField.text = trip!.name
        tripDateTextField.text = dateToString(date: trip!.date!)
        
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        self.trip?.journal = tripJournalTextArea.text
        self.trip?.completed = true
        
        saveData()
        
        performSegue(withIdentifier: "gotoMemories", sender: self)
        
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
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
