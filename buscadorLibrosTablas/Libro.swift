//
//  Libro.swift
//  buscadorLibrosTablas
//
//  Created by Nicolas Roman Toro on 5/31/16.
//  Copyright © 2016 Nicolas Roman Toro. All rights reserved.
//

import Foundation

class Libro {
    var isbn: String?
    var titulo: String?
    var autores: String?
    
    init(i: String, t: String, a: String) {
        self.isbn = i
        self.titulo = t
        self.autores = a
    }
}