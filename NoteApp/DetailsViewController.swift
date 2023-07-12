//
//  DetailsViewController.swift
//  NoteApp
//
//  Created by Utku Güzel on 11.07.2023.
//

import UIKit
import CoreData

let appDelegete = UIApplication.shared.delegate as! AppDelegate

class DetailsViewController: UIViewController {
    
    var notes = [Notepad]()
    var indexPath = 0
    var selectedtTitle = ""
    var selectedContent = ""
    
    let context = appDelegete.persistentContainer.viewContext
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        titleTextField.text = selectedtTitle
        contentTextView.text = selectedContent
       
    }
    

    

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        let note = Notepad(context: context)
        
        note.id = UUID()
        note.title = titleTextField.text!
        note.note = contentTextView.text!
        
        appDelegete.saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    

}
