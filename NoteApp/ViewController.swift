//
//  ViewController.swift
//  NoteApp
//
//  Created by Utku Güzel on 11.07.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var notes = [Notepad]()
    
    let context = appDelegete.persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getNotes()
    }

    @IBAction func addNoteButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToDetailVC", sender: nil)
    }
    
    
    func getNotes() {
        do {
            notes = try context.fetch(Notepad.fetchRequest())
            tableView.reloadData()
        } catch {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let index = sender as? Int else { return }
        
        if segue.identifier == "goToDetailVC" {
            let destinationVC = segue.destination as! DetailsViewController
            
            destinationVC.selectedtTitle = notes[index].title ?? "Unknown"
            destinationVC.selectedContent = notes[index].note ?? "Unknown"

        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.font = UIFont(name: "Chalkduster", size: CGFloat.pi*6)
        cell.textLabel?.text = notes[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetailVC", sender: indexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let note = notes[indexPath.row]
            context.delete(note)
            
            appDelegete.saveContext()
            
            getNotes()
            tableView.reloadData()
        }

    }

    


}

