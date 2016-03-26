//
//  MasterViewController.swift
//  voices-test
//
//  Created by Ilya Nikokoshev on 26.03.16.
//  Copyright © 2016 ilya n. All rights reserved.
//

import UIKit
import AVFoundation

// po (Array(Set(Set(objects.map {$0.language}).map {($0 as NSString).substringToIndex(2)})) as NSArray).description

class MasterViewController: UITableViewController, UISearchResultsUpdating {
    
    let all_objects = AVSpeechSynthesisVoice.speechVoices()
    var objects: [AVSpeechSynthesisVoice]!
    let locale = NSLocale.currentLocale()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func describe(voice: AVSpeechSynthesisVoice) -> String {
        let code = voice.language
        return locale.displayNameForKey(NSLocaleIdentifier, value: code) ?? code
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objects = all_objects
        
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let voice = objects[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                
                controller.voice = voice
                
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let voice = objects[indexPath.row]
        cell.textLabel!.text = voice.name
        
        cell.detailTextLabel?.text = describe(voice)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        
        objects = all_objects.filter { voice in
            text == "" || voice.language.containsString(text) || describe(voice).containsString(text)
        }
        
        tableView.reloadData()
    }
}

