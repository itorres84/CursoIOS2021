//
//  ViewController.swift
//  ManageTask
//
//  Created by Isrrael Torres Alvarado on 10/12/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var tasks = [NSManagedObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getTaks()
        
    }
    
    func getTaks() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
                
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            tasks = results as [NSManagedObject]
            self.tableView.reloadData()
            
        } catch {
            
            print("No es posible cargar las tareas: \(error.localizedDescription)")
            
        }
    
    }

    @IBAction func addTask(_ sender: Any) {
        
        let alert = UIAlertController(title: "Nueva Tarea",
                                      message: "Añade una nueva tarea",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Guardar", style: .default) { _ in
            
            guard let textField = alert.textFields?.first,
            let textSave = textField.text else { return }
            
            self.saveTask(nameTask: textSave)

        }
            
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addTextField { textField in
            textField.placeholder = "Escribe una tarea"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveTask(nameTask: String) {
     
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)
        let task = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        task.setValue(nameTask, forKey: "name")
        
        do {
            
            try managedContext.save()
            tasks.append(task)
            tableView.reloadData()
            
        } catch {
            print("No ha sido posible guardar \(error.localizedDescription)")
        }
    
    }
    
    func updateTask(oldNameTask: String, nameTask: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fechRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fechRequest.predicate = NSPredicate(
            format: "name LIKE %@", oldNameTask.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        
        do {
            
            let objects = try managedContext.fetch(fechRequest)
            
            if let firtObject = objects.first {
                firtObject.setValue(nameTask, forKey: "name")
            }
                
            try managedContext.save()
            
            self.getTaks()
        
        } catch {
            print("No ha sido posible modificar \(error.localizedDescription)")
        }
        
    }
    
}

//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let task = tasks[indexPath.row]
        cell!.textLabel?.text = task.value(forKey: "name") as? String
        
        return cell!
    }

}

//MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                    
        if editingStyle == .delete {
                    
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let task = tasks[indexPath.row]
            let name = task.value(forKey: "name") as! String
            
            let fechRequest: NSFetchRequest<Task> = Task.fetchRequest()
            fechRequest.predicate = NSPredicate(
                format: "name LIKE %@", name
            )
            
            do {
                
                let objects = try managedContext.fetch(fechRequest)
                
                _ = objects.map({
                    managedContext.delete($0)
                })
                
                try managedContext.save()
                
                tasks.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                
            } catch {
                print(error.localizedDescription)
            }
    
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
        let task = tasks[indexPath.row]
        let name = task.value(forKey: "name") as! String
        
        let alert = UIAlertController(title: "Modifica Tarea",
                                      message: "Modificar una tarea",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Modificar", style: .default) { _ in
            
            guard let textField = alert.textFields?.first,
            let textSave = textField.text else { return }
            
            self.updateTask(oldNameTask: name, nameTask: textSave)

        }
            
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addTextField { textField in
            textField.text = name
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
}

