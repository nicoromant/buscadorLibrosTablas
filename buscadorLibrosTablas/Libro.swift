//
//  Libro.swift
//  buscadorLibrosTablas
//
//  Created by Nicolas Roman Toro on 5/31/16.
//  Copyright © 2016 Nicolas Roman Toro. All rights reserved.
//

import Foundation

class Libro: NSObject, NSCoding {
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("libros")
    
    // MARK: Properties
    
    var isbn: String?
    var titulo: String?
    var autores: String?
    
    // MARK: Types
    
    struct PropertyKey {
        static let isbnKey = "isbn"
        static let tituloKey = "titulo"
        static let autoresKey = "autores"
    }
    
    // MARK: Initialization
    
    init(i: String, t: String, a: String) {
        self.isbn = i
        self.titulo = t
        self.autores = a
        
        super.init()
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(isbn, forKey: PropertyKey.isbnKey)
        aCoder.encodeObject(titulo, forKey: PropertyKey.tituloKey)
        aCoder.encodeObject(autores, forKey: PropertyKey.autoresKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let isbn = aDecoder.decodeObjectForKey(PropertyKey.isbnKey) as! String
        let titulo = aDecoder.decodeObjectForKey(PropertyKey.tituloKey) as! String
        let autores = aDecoder.decodeObjectForKey(PropertyKey.autoresKey) as! String
        
        // Must call designated initializer.
        self.init(i: isbn, t: titulo, a: autores)
    }
}