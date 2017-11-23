//
//  ViewControllerVerFotografiaDeAlbum2.swift
//  ProyectoFinalBueno
//
//  Created by Luis Alfonso Rojo Sánchez on 16/11/17.
//  Copyright © 2017 ITESM. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerVerFotografiaDeAlbum2: UIViewController {

    var Nombre : String!
    var Relacion : String!
    var Fecha = Date()
    var Comentarios : String!
    var Imagen = NSData()
    
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var lbRelacion: UILabel!
    @IBOutlet weak var lfFecha: UILabel!
    @IBOutlet weak var tfComentarios: UITextView!
    
    var delegado : ProtocoloRecargaVista!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        lbNombre.text = Nombre
        imagen.image = UIImage(data: Imagen as Data, scale: 1.0)
        lbRelacion.text = Relacion
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myString = formatter.string(from: Fecha)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MMM-yyyy"
        let myStringafd = formatter.string(from: yourDate!)
        lfFecha.text = myStringafd
        
        tfComentarios.text = Comentarios
        // Modal para mostrar la imagen seleccionada
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imagen.isUserInteractionEnabled = true
        imagen.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let imageView = tapGestureRecognizer.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .white
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
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
    
    @IBAction func eliminarFotografia(_ sender: UIButton)
    {
        let realm = try! Realm()
        
        try! realm.write {
            let fotoParaEliminar = realm.objects(FotografiaOtroDeUnAlbum.self).filter("imagen == %@", Imagen)
            
            realm.delete(fotoParaEliminar)
            
            delegado.recargaVista()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
}
