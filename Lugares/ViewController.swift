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
    var searchResults : [Place] = []
    var fetchResultController : NSFetchedResultsController<Place>!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //barra de búsqueda
        self.searchController = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Buscar Lugares"
        self.searchController.searchBar.tintColor = UIColor.white
        self.searchController.searchBar.barTintColor = UIColor.darkGray
        
        
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
        
        //TODO:Cargar la info por defecto
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: "hasLoadedDefaultInfo"){
            //CArgar la info por defecto
            loadDefaultData()
            
            defaults.set(true, forKey: "hasLoadedDefaultInfo")
        }
        
        
    }
    
    func loadDefaultData(){
        //TODO: data por defecto de la app
    }
    
    
    //esconder el navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //compruebo si el tutorial fue visto
        let defaults = UserDefaults.standard
        let hasViewedTutorial = defaults.bool(forKey: "hasViewedTutorial")
        
        if hasViewedTutorial{
            return
        }
        
        if let pageVC = storyboard?.instantiateViewController(withIdentifier: "WalkthroughController") as? TutorialViewController {
            
            self.present(pageVC, animated: true, completion: nil)
            
        }
    }
    
    //TODO: agregar botón omitir
    //TODO: crear botón ver tutorial

 
    
    
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
        
        //si la búsqueda está activa, devuelvo el numero de elementos del searchresult
        if self.searchController.isActive{
            return self.searchResults.count
        }else{
            return self.places.count
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let place : Place!
        
        if self.searchController.isActive{
            place = self.searchResults[indexPath.row]
        }else{
            place = places[indexPath.row]
        }
        
        
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
    
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            self.places.remove(at: indexPath.row)
            
        }
        
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }*/
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let place : Place!
        
        if self.searchController.isActive{
            place = self.searchResults[indexPath.row]
        }else{
            place = places[indexPath.row]
        }
        
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
                
                let place : Place!
                
                if self.searchController.isActive{
                    place = self.searchResults[indexPath.row]
                }else{
                    place = places[indexPath.row]
                }
                let destinationViewController = segue.destination as! DetailViewController
                
                destinationViewController.place = place
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
    
    //implementar la barra de busqueda del tableView
    func filterContentFor(textToSearch: String){
        self.searchResults = self.places.filter({ (place) -> Bool in
            let nameToFind = place.name.range(of: textToSearch, options: NSString.CompareOptions.caseInsensitive)
            return nameToFind != nil
            
        })
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

//implementar la búsqueda
extension ViewController: UISearchResultsUpdating{

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            self.filterContentFor(textToSearch: searchText)
            
            self.tableView.reloadData()
        }
    }
}




