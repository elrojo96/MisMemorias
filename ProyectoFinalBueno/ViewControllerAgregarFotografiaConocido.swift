//
//  ViewControllerAgregarFotografiaConocido.swift
//  ProyectoFinalBueno
//
//  Created by Luis Alfonso Rojo Sánchez on 11/11/17.
//  Copyright © 2017 ITESM. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerAgregarFotografiaConocido: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @IBOutlet weak var tfNombre: UITextField!
        @IBOutlet weak var tfRelacion: UITextField!
        @IBOutlet weak var fechaBirthday: UIDatePicker!
        @IBOutlet weak var tfComentarios: UITextView!
        @IBOutlet weak var myImageView: UIImageView!
        
        @IBAction func tomarFotografia(_ sender: UIButton)
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
        
        @IBAction func agregarFotografia(_ sender: UIButton)
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
                myImageView.image = image
            }
            else
            {
                //Error message
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        
        @IBAction func btGuardar(_ sender: UIButton)
        {
            if tfNombre.text != nil && tfRelacion.text != nil && tfComentarios.text != nil && myImageView.image != nil
            {
                let fotoTemporal = FotografiaConocido()
                
                fotoTemporal.nombreCompleto = tfNombre.text!
                fotoTemporal.relacion = tfRelacion.text!
                fotoTemporal.birthday = fechaBirthday.date
                fotoTemporal.informacionAdicional = tfComentarios.text!
                let imagen = NSData(data: UIImageJPEGRepresentation(myImageView.image!,0.9)!)
                fotoTemporal.imagen = imagen
                
                let realm = try! Realm()
                
                try! realm.write {
                    realm.add(fotoTemporal)
                    print("Added \(fotoTemporal.nombreCompleto) to Realm Database of memories")
                    navigationController?.popViewController(animated: true)
                }
            }
            else
            {
                let alert = UIAlertController(title: "Datos incompletos", message: "Ingresa información en todos los campos", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
            
            self.title = "Agrega una fotografía"
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(quitaTeclado))
            view.addGestureRecognizer(tap)
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            myImageView.isUserInteractionEnabled = true
            myImageView.addGestureRecognizer(tapGestureRecognizer)
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
        
}
