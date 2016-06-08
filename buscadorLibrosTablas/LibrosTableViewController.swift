//
//  LibrosTableViewController.swift
//  buscadorLibrosTablas
//
//  Created by Nicolas Roman Toro on 5/31/16.
//  Copyright © 2016 Nicolas Roman Toro. All rights reserved.
//

import UIKit
import CoreData

class LibrosTableViewController: UITableViewController {
    
    // MARK: Properties
    var libros = [Libro]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Helper method para cargar datos en la tabla
        func loadSampleLibros() {
            let libro1 = Libro(i: "978-84-080-5304-0", t: "Cosmos", a: "Carl Sagan")
            let libro2 = Libro(i: "978-05-821-8655-2", t: "The Hobbit", a: "J. R. R. Tolkien")
            let libro3 = Libro(i: "978-04-511-6771-2", t: "The Godfather", a: "Mario Puzzo")
            
            libros += [libro1, libro2, libro3]
        }

        // Load any sample libros, otherwise load sample data.
        if let savedLibros = loadLibros() {
            libros += savedLibros
        } else {
            // Load the sample data
            loadSampleLibros()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return libros.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "LibroTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! LibroTableViewCell

        // Fetches the appropiate meal for the data  source layout.
        
        let libro = libros[indexPath.row]
        cell.nombreLibroLabel.text = libro.titulo

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            libros.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetailLibro" {
            let libroDetailViewController = segue.destinationViewController as! DetalleLibroViewController
            // Get the cell that generated this segue
            if let selectedLibro = sender as? LibroTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedLibro)
                let selectedLibro = libros[(indexPath?.row)!]
                libroDetailViewController.libroDetalle = selectedLibro
                print("Mostrando libro almacenado: \(selectedLibro.titulo!)")
            }
        } else if segue.identifier == "AgregarLibro" {
            print("Agregando un nuevo libro")
        }
    }
    
    @IBAction func unwindToLibrosList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? BuscarLibroViewController, libroNuevo = sourceViewController.libroNuevo {
            // Agrego nuevo libro.
            let newIndexPath = NSIndexPath(forRow: libros.count, inSection: 0)
            libros.append(libroNuevo)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            
            // Save the libros.
            saveLibros()
        }
    }
    
    // MARK: NSCoding
    
    func saveLibros() {
        // The following method attempts to archive the libros array to a specific location, and returns true if it’s successful
        let isSuccesfulSave = NSKeyedArchiver.archiveRootObject(libros, toFile: Libro.ArchiveURL.path!)

        // Quickly test if Save was succesful
        if !isSuccesfulSave {
            print("Failed to save libros...")
        }
    }
    
    func loadLibros() -> [Libro]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Libro.ArchiveURL.path!) as? [Libro]
        
        /* This method attempts to unarchive the object stored at the path Libro.ArchiveURL.path! and downcast that object to an array of Libro objects.
         This code uses the as? operator so that it can return nil when appropriate.
         Because the array may or may not have been stored, it’s possible that the downcast will fail, in which case the method should return nil.
        */
    }
    
}
