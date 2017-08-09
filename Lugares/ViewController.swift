//
//  ViewController.swift
//  Lugares
//
//  Created by Felipe Hernandez on 8/7/17.
//  Copyright © 2017 kafecode. All rights reserved.
//


import UIKit

class ViewController: UITableViewController {
    
    var places : [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        //esconder el navigation bar
        //navigationController?.hidesBarsOnSwipe = true
        
        var place = Place(name: "Alexanderplatz", type: "Plaza", location: "Alexanderplatz 1 10178, Berlin Germany", telephone: "4534123", website: "http://www.google.com", image: #imageLiteral(resourceName: "alexanderplatz"))
        self.places.append(place)
        
        place = Place(name: "Atonium", type: "Museo", location: "Boomstraat 8 1000, Brussels Belgium",telephone: "5555555", website: "http://www.google.com", image: #imageLiteral(resourceName: "atomium"))
        self.places.append(place)
        
        place = Place(name: "Big ben", type: "Monumento", location: "London SW1A 0AA, England", telephone: "5555555", website: "http://www.google.com",image: #imageLiteral(resourceName: "bigben"))
        self.places.append(place)
        
        place = Place(name: "Cristo Redentor", type: "Monumento", location: "Parque Nacional da Tijuca - Alto da Boa Vista, Rio de Janeiro - RJ, Brasil",telephone: "5555555", website: "http://www.google.com", image: #imageLiteral(resourceName: "cristoredentor"))
        self.places.append(place)
        
        place = Place(name: "Torre Eiffel", type: "Monumento", location: "5 Avenue Anatole France 75007 Paris France",telephone: "5555555", website: "http://www.google.com", image: #imageLiteral(resourceName: "torreeiffel"))
        self.places.append(place)
        
        place = Place(name: "Gran Muralla China", type: "Monumento", location: "Great Wall, Mutianyu Beijing China",telephone: "5555555", website: "http://www.google.com", image: #imageLiteral(resourceName: "murallachina"))
        self.places.append(place)
        
        place = Place(name: "Torre Pizza", type: "Monumento", location: "Leaning Tower of Pisa 56126 Pisa, Province of Pisa Italy",telephone: "5555555", website: "http://www.google.com",image: #imageLiteral(resourceName: "torrepisa"))
        self.places.append(place)
        
        place = Place(name: "Catedral de Mallorca", type: "Iglesia", location: "La Seu Plaza de la Seu 5 07001 Palma de Mallorca Balearic Isles, Spain",telephone: "5555555", website: "http://www.google.com", image: #imageLiteral(resourceName: "mallorca"))
        self.places.append(place)



        
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
        
        cell.thumbnailImageView.image = place.image
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
            
            let activityController = UIActivityViewController(activityItems: [shareDeflaultText, place.image], applicationActivities: nil)
            
            self.present(activityController, animated: true, completion: nil)
            
        }
        
        shareAction.backgroundColor = UIColor(red: 30.0/255.0, green: 164.0/255, blue: 253.0/255.0, alpha: 1.0)
        
        //borrar
        let deleteAction = UITableViewRowAction(style: .default, title: "Borrar") { (action, indexPath) in
            self.places.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
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
        
    }
    
    
}

