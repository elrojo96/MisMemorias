//
//  Persona.swift
//  ProyectoFinalBueno
//
//  Created by Luis Alfonso Rojo Sánchez on 11/11/17.
//  Copyright © 2017 ITESM. All rights reserved.
//

import UIKit
import RealmSwift

class Persona: Object {
    @objc dynamic var imagen = NSData()
    @objc dynamic var nombreCompleto = ""
    @objc dynamic var fechaNacimiento = Date()
    @objc dynamic var informacionAdicional = ""
}
