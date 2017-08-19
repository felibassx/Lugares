//
//  DetailViewController.swift
//  Mis Recetas
//
//  Created by Felipe Hernandez on 08-07-17.
//  Copyright © 2017 kafecode. All rights reserved.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController {
    
    
    @IBOutlet var ratingButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var placeImageView: UIImageView!
    var place : Place!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = place.name

        self.placeImageView.image = UIImage(data: self.place.image! as Data)
        
        //modificar la apariencia de la tabla
        self.tableView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.25)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.75)
        
        //celda autoajustable, sirve para autoajusta el tamaño de la celda segun el contenido
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let image = UIImage(named: self.place.rating!)
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
                
                let image = UIImage(named: self.place.rating!)
                self.ratingButton.setImage(image, for: .normal)
                
                
                //persistir en coredata
                if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
                    let context = container.viewContext
                    
                    do {
                        try context.save()
                    } catch {
                        print("Error: \(error)")
                    }
                }
                
            }
        }
    
    }
    
    //LLamar por teléfono
    func callNumber(phoneNumber:String) {
        
        //print(phoneNumber)
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func sendSmsNumber(phoneNumber:String, messageText:String){
        if MFMessageComposeViewController.canSendText(){
            
            let msgVC = MFMessageComposeViewController()
            msgVC.body = messageText
            msgVC.recipients = [phoneNumber]
            msgVC.messageComposeDelegate = self
            
            self.present(msgVC, animated: true, completion: nil)
        }
    }
    
    func openWebSiteUrl(urlToOpen:String){
        
        if let webSiteUrl = URL(string: urlToOpen){
            let app = UIApplication.shared
            if app.canOpenURL(webSiteUrl){
                app.open(webSiteUrl, options: [:], completionHandler: nil)
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
        case 3:
            //self.callNumber(phoneNumber: self.place.telephone!)
            let alertController = UIAlertController(title: "Contactar con \(self.place.name)", message: "¿Cómo quieres contactar con el número \(self.place.telephone!)?", preferredStyle: .actionSheet)
            
            //llamar
            let callAction = UIAlertAction(title: "Llamar", style: .default, handler: { (action) in
                
                self.callNumber(phoneNumber: self.place.telephone!)
                
            })
            alertController.addAction(callAction)
            
            //enviar sms
            let smsAction = UIAlertAction(title: "Mensaje", style: .default, handler: { (action) in
                
                let msg = "Hola te escribimos desde la app Lugares."
                self.sendSmsNumber(phoneNumber: self.place.telephone!, messageText: msg)
            })
            alertController.addAction(smsAction)
            
            
            //cancelar
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        case 4:
            //abrir página web
            self.openWebSiteUrl(urlToOpen: self.place.website!)

            
        default:
            break
        }
    }

}

extension DetailViewController : MFMessageComposeViewControllerDelegate{

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        controller.dismiss(animated: true, completion: nil)
        
    }
}
