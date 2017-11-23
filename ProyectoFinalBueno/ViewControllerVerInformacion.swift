//
//  ViewControllerVerInformacion.swift
//  ProyectoFinalBueno
//
//  Created by Luis Alfonso Rojo Sánchez on 11/11/17.
//  Copyright © 2017 ITESM. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerVerInformacion: UIViewController, ProtocoloEditarInformacion {
    
    //  Outlets de los elementos para la visualización de información de la persona que usa la aplicación
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var lbFechaNacimiento: UILabel!
    @IBOutlet weak var tfInformacion: UITextView!
    @IBOutlet weak var imgImagen: UIImageView!
    
    //  Variables para consultar la información guardada en el arreglo de perfiles creados
    var Nombre = [String]()
    var Fecha = [String]()
    var Comentarios = [String]()
    var Imagenes = [NSData]()
    
    
    //  Variable para la persona a última a mostrar su información
    var titular = Persona()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Información"
        
        obtenerUltimaPersona()
        
        //  Colocar el nombre en la vista
        lbNombre.text = titular.nombreCompleto
        
        //  Colocar la fecha en la vista
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myString = formatter.string(from: titular.fechaNacimiento)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MMM-yyyy"
        let myStringafd = formatter.string(from: yourDate!)
        lbFechaNacimiento.text = myStringafd
        
        //  Colocar los comentarios en la vista
        tfInformacion.text = titular.informacionAdicional
        
        //  Colocar la imagen en la vista
        imgImagen.image = UIImage(data: titular.imagen as Data, scale: 1.0)
        
        // Expander vista de imagen en nuevo modal
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgImagen.isUserInteractionEnabled = true
        imgImagen.addGestureRecognizer(tapGestureRecognizer)
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //  Mandar la información del último titular creado para simular que es la información está en la vista de editar
        let vistaEditar = segue.destination as! ViewControllerEditarInformacion
        
        
        vistaEditar.delegado = self
        vistaEditar.prueba = 1
        vistaEditar.nombreVar = titular.nombreCompleto
        vistaEditar.comentariosVar = titular.informacionAdicional
        vistaEditar.fechaVar = titular.fechaNacimiento
        vistaEditar.imagenVar = titular.imagen
        
    }
    
    //  MARK - Método de Protocolo
    func editarInformacion(nombre : String, nacimiento : String, comentarios : String, imagen : NSData)
    {
        
        lbNombre.text = titular.nombreCompleto
        lbFechaNacimiento.text = String(describing: titular.fechaNacimiento)
        tfInformacion.text = titular.nombreCompleto
        imgImagen.image = UIImage(data: titular.imagen as Data, scale: 1.0)
    }
    
    func obtenerUltimaPersona()
    {
        let realm = try! Realm()
        
        let allTitulares = realm.objects(Persona.self)
        
        var contador = 0
        
        for person in allTitulares
        {
            contador = contador + 1
        }
        
        if(contador > 0){
            titular.nombreCompleto = allTitulares[contador - 1].nombreCompleto
            titular.fechaNacimiento = allTitulares[contador - 1].fechaNacimiento
            titular.informacionAdicional = allTitulares[contador - 1].informacionAdicional
            titular.imagen = allTitulares[contador - 1].imagen
        }
        
    }
    
    func test()
    {
        obtenerUltimaPersona()
        
        lbNombre.text = titular.nombreCompleto
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myString = formatter.string(from: titular.fechaNacimiento)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MMM-yyyy"
        let myStringafd = formatter.string(from: yourDate!)
        lbFechaNacimiento.text = myStringafd
        
        tfInformacion.text = titular.informacionAdicional
        imgImagen.image = UIImage(data: titular.imagen as Data, scale: 1.0)
    }
    
    @IBAction func unwindTitular(unwindSegue : UIStoryboardSegue)
    {
        obtenerUltimaPersona()
        
        lbNombre.text = titular.nombreCompleto
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myString = formatter.string(from: titular.fechaNacimiento)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MMM-yyyy"
        let myStringafd = formatter.string(from: yourDate!)
        lbFechaNacimiento.text = myStringafd
        
        tfInformacion.text = titular.informacionAdicional
        imgImagen.image = UIImage(data: titular.imagen as Data, scale: 1.0)
    }
    
    @IBAction func handleSingleTap (sender : UIGestureRecognizer) {
        
    }
    
}
