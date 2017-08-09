//
//  DetailViewController.swift
//  Mis Recetas
//
//  Created by Felipe Hernandez on 08-07-17.
//  Copyright © 2017 kafecode. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet var ratingButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var placeImageView: UIImageView!
    var place : Place!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = place.name

        self.placeImageView.image = self.place.image
        
        //modificar la apariencia de la tabla
        self.tableView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.25)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.75)
        
        //celda autoajustable, sirve para autoajusta el tamaño de la celda segun el contenido
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let image = UIImage(named: self.place.rating)
        self.ratingButton.setImage(image, for: .normal)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        
        if let reviewVC = segue.source as? ReviewViewController{
            if let rating = reviewVC.ratingSelected {
                
                self.place.rating = rating
                
                let image = UIImage(named: self.place.rating)
                self.ratingButton.setImage(image, for: .normal)
            }
        }
    
    }

}

extension DetailViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceDetailViewCell", for: indexPath) as! PlaceDetailViewCell
        
        cell.backgroundColor = UIColor.clear
        
        
            
            switch indexPath.row {
            case 0:
                cell.keyLabel.text = "Nombre: "
                cell.valueLabel.text = self.place.name
                
            case 1:
                cell.keyLabel.text = "Tipo: "
                cell.valueLabel.text = self.place.type
                
            case 2:
                cell.keyLabel.text = "Localización: "
                cell.valueLabel.text = self.place.location
                
            case 3:
                cell.keyLabel.text = "Teléfono: "
                cell.valueLabel.text = self.place.telephone
                
            case 4:
                cell.keyLabel.text = "Sitio Web: "
                cell.valueLabel.text = self.place.website
                
            default:
                break
            }
            
        
        
        return cell
        
        
    }
    
    //pasar informacion a traves del segua al view controller del mapa
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destinationViewController = segue.destination  as! MapViewController
            destinationViewController.place = self.place
        }
    }
    
}

extension DetailViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            //se selecciono el geo localización
            //llamo al segue
            self.performSegue(withIdentifier: "showMap", sender: nil)
            
        default:
            break
        }
    }

}
