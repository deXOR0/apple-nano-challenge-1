//
//  ViewJournalViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 28/04/22.
//

import UIKit

class ViewJournalViewController: UIViewController {
    
    @IBOutlet weak var tripNameTextField: UITextField!
    @IBOutlet weak var tripDateTextField: UITextField!
    @IBOutlet weak var tripJournalTextArea: UITextView!
    
    var trip: Trip?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tripNameTextField.text = trip!.name
        self.tripDateTextField.text = dateToString(date: trip!.date!)
        self.tripJournalTextArea.text = trip!.journal
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
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
