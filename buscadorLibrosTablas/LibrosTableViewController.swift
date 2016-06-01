//
//  LibrosTableViewController.swift
//  buscadorLibrosTablas
//
//  Created by Nicolas Roman Toro on 5/31/16.
//  Copyright © 2016 Nicolas Roman Toro. All rights reserved.
//

import UIKit

class LibrosTableViewController: UITableViewController {
    
    // MARK: Properties
    var libros = [Libro]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Helper method para cargar datos en la tabla
        func loadSampleLibros() {
            let libro1 = Libro(i: "ISBN1", t: "El Padrino", a: "M. Puzzo")
            let libro2 = Libro(i: "ISBN2", t: "El Hobbit", a: "J. Tolkien")
            let libro3 = Libro(i: "ISBN3", t: "Resource Revolution", a: "R. Heck")
            
            libros += [libro1, libro2, libro3]
        }
        
        // Load the sample data
        loadSampleLibros()

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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToLibrosList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? BuscarLibroViewController, libroNuevo = sourceViewController.libroNuevo {
            // Agrego nuevo libro.
            let newIndexPath = NSIndexPath(forRow: libros.count, inSection: 0)
            libros.append(libroNuevo)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }


}
