//
//  ViewController.swift
//  Lugares
//
//  Created by Felipe Hernandez on 8/7/17.
//  Copyright © 2017 kafecode. All rights reserved.
//


import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var places : [Place] = []
    var fetchResultController : NSFetchedResultsController<Place>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let fetchRequest : NSFetchRequest<Place> = NSFetchRequest(entityName: "Place")
        let sortDescriptor  = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
            
            let context = container.viewContext
            
            self.fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            
            self.fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                self.places = fetchResultController.fetchedObjects!
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        
    }
    
    //esconder el navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
 
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    
    
    //MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = places[indexPath.row]
        let cellID = "placeCell"
        
        //dequeueReusableCell: reutiliza las celdas visibles en la pantalla, a medida que se avanza la primera
        //se destruye y la última se genera
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PlaceCell
        
        cell.thumbnailImageView.image = UIImage(data: place.image! as Data)
        cell.nameLabel.text = place.name
        cell.typeLabel.text = place.type
        cell.locationLabel.text = place.location        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            self.places.remove(at: indexPath.row)
            
        }
        
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let place = self.places[indexPath.row]
        
        //compartir
        let shareAction = UITableViewRowAction(style: .default, title: "Compartir") { (action, indexPath) in
            let shareDeflaultText = "Estoy visitando \(place.name) en la app Lugares"
            
            let activityController = UIActivityViewController(activityItems: [shareDeflaultText, UIImage(data: (place.image! as Data))!], applicationActivities: nil)
            
            self.present(activityController, animated: true, completion: nil)
            
        }
        
        shareAction.backgroundColor = UIColor(red: 30.0/255.0, green: 164.0/255, blue: 253.0/255.0, alpha: 1.0)
        
        //borrar
        let deleteAction = UITableViewRowAction(style: .default, title: "Borrar") { (action, indexPath) in
            if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
                
                let context = container.viewContext
                let placeToDelete = self.fetchResultController.object(at: indexPath)
                
                context.delete(placeToDelete)
                
                do{
                    try context.save()
                }catch{
                    print(error.localizedDescription)
                }
            }

        }
        
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        
        return [shareAction,deleteAction]
    }
    
    
    //MARK: - UITableViewDelegate
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            
            
            if let indexPath = self.tableView.indexPathForSelectedRow{
                
                let selectedPlace = self.places[indexPath.row]
                let destinationViewController = segue.destination as! DetailViewController
                
                destinationViewController.place = selectedPlace
            }
            
        }
    }
    
    @IBAction func unwindToMainViewController(segue: UIStoryboardSegue){
        
        if segue.identifier == "unwindToMainViewController"{
            
            if let addPlaceVC = segue.source as? AddPlaceViewController{
                
                if let newPlace = addPlaceVC.place{
                    self.places.append(newPlace)
                    //self.tableView.reloadData()
                }
                
            }
        }
    }
    
}

//para actualizar la tabla
extension ViewController : NSFetchedResultsControllerDelegate{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case .insert:
            
            if let newIndexPath = newIndexPath{
                self.tableView.insertRows(at: [newIndexPath], with: .fade)
            }
            
        case .delete:
            if let indexPath = indexPath{
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath{
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
            
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath{
                self.tableView.moveRow(at: indexPath, to: newIndexPath)
            }
            
        }
        
        self.places = controller.fetchedObjects as! [Place]
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }

}




