//
//  ViewControllerAgregarAlbumFamiliar.swift
//  ProyectoFinalBueno
//
//  Created by Luis Alfonso Rojo Sánchez on 12/11/17.
//  Copyright © 2017 ITESM. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerAgregarAlbumFamiliar: UIViewController {
    
    @IBOutlet weak var tfNombreDelAlbum: UITextField!
    
    @IBAction func btCrearAlbum(_ sender: UIButton)
    {
        if tfNombreDelAlbum.text != ""{
            let albumTemporal = AlbumFamiliar()
            
            albumTemporal.nombre = tfNombreDelAlbum.text!
            
            let realm = try! Realm()
            
            try! realm.write{
                realm.add(albumTemporal)
                print("Added \(albumTemporal.nombre) to the database.")
                navigationController?.popViewController(animated: true)
                
            }
        }
        else
        {
            //print("No se guardo el album")
            let alertController = UIAlertController(title: "Nombre del álbum vacío", message: "Ingresa un nombre para el álbum", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Cerrar", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Nuevo álbum familiar"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(quitaTeclado))
        view.addGestureRecognizer(tap)
    }
    
    @objc func quitaTeclado(){
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
