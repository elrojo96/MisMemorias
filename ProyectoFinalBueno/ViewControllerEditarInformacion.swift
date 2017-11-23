//
//  ViewControllerEditarInformacion.swift
//  ProyectoFinalBueno
//
//  Created by Luis Alfonso Rojo Sánchez on 11/11/17.
//  Copyright © 2017 ITESM. All rights reserved.
//

import UIKit
import RealmSwift

protocol ProtocoloEditarInformacion
{
    func editarInformacion(nombre : String, nacimiento : String, comentarios : String, imagen : NSData) -> Void
    func test()
}

class ViewControllerEditarInformacion: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //  Outlets de la información a guardar
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tfComentarios: UITextView!
    @IBOutlet weak var imagenDeLaPersona: UIImageView!
    
    var prueba : Int!
    var fecha = Date()
    var sFecha : String!
    let formateador = DateFormatter()
    var delegado : ProtocoloEditarInformacion!
    
    //  Variables para recibir la información
    var nombreVar : String!
    var comentariosVar : String!
    var fechaVar = Date()
    var imagenVar = NSData()
    
    @IBAction func btGuardar(_ sender: UIButton)
    {
        fecha = datePicker.date
        formateador.dateFormat = "dd ' de ' MM ' de ' yyyy"
        sFecha = formateador.string(from:fecha)
        print(sFecha)
        let nom = tfNombre.text!
        let com = tfComentarios.text!
        var fec: String!
        fec = sFecha
        
        if nom != " " && com != "" && fec != "" && imagenDeLaPersona.image != nil
        {
            let PersonaTemporal = Persona()
            
            PersonaTemporal.nombreCompleto = tfNombre.text!
            PersonaTemporal.fechaNacimiento = fecha
            PersonaTemporal.informacionAdicional = tfComentarios.text!
            
            PersonaTemporal.imagen = NSData(data: UIImageJPEGRepresentation(imagenDeLaPersona.image!,0.9)!)
            
            let realm = try! Realm()
            
            try! realm.write {
                //realm.add(PersonaTemporal)
                realm.add(PersonaTemporal)
                print("Added \(PersonaTemporal.nombreCompleto) to Realm Database of memories")
                delegado.test()
                navigationController!.popViewController(animated: true)
            }
        }
        else
        {
            //  Crear aquí alerta por que no se ingresaron correctamente los valores
            let alertController = UIAlertController(title: "Datos incompletos", message: "Ingrese información en todos los campos", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Cerrar", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Editar"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(quitaTeclado))
        view.addGestureRecognizer(tap)
        
        tfNombre.text = nombreVar
        datePicker.date = fechaVar
        tfComentarios.text = comentariosVar
        imagenDeLaPersona.image = UIImage(data: imagenVar as Data, scale: 1.0)
        
        // Funcion para expandir la vista de la foto.
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imagenDeLaPersona.isUserInteractionEnabled = true
        imagenDeLaPersona.addGestureRecognizer(tapGestureRecognizer)
        
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
    
    
    @IBAction func btTomarFotografia(_ sender: UIButton)
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            
            imagePicker.allowsEditing = false
            
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            
            self.present(imagePicker, animated: false, completion: nil)
        }else{
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            
            imagePicker.allowsEditing = false
            
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            self.present(imagePicker, animated: false, completion: nil)
        }
    }
    
    
    @IBAction func btSeleccionarFotografia(_ sender: UIButton)
    {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imagenDeLaPersona.image = image
        }
        else
        {
            //Error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
