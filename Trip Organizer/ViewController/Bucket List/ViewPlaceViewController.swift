//
//  ViewPlaceViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 28/04/22.
//

import UIKit

class ViewPlaceViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var notesTextArea: UITextView!

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var place: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameTextField.text = place!.name
        addressTextField.text = place!.address
        linkTextField.text = place!.link
        notesTextArea.text = place!.notes
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "gotoEditPlace", sender: self)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete \(self.place?.name ?? "Default")", message: "Are you sure you want to delete \(self.place?.name ?? "Default")? This action cannot be undone!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.context.delete(self.place!)
            self.saveData()
            self.performSegue(withIdentifier: "unwind", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func unwindToViewPlace(_ sender: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoEditPlace" {
            let viewPlaceVC = segue.destination as? EditPlaceViewController
            viewPlaceVC?.place = self.place
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
