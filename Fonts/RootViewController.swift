//
//  RootViewController.swift
//  Fonts
//
//  Created by LAURA LUCRECIA SANCHEZ PADILLA on 08/10/15.
//  Copyright © 2015 LAURA LUCRECIA SANCHEZ PADILLA. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    
    private var familyNames : [String]!
    private var cellPointSize : CGFloat!
    private var favoritesList : FavoritesList!
    private let familyCell = "FamilyName"
    private let favoritesCell = "Favorites"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let temp = UIFont.familyNames() as [String]!
        familyNames = temp.sort()
        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize = preferredTableViewFont.pointSize
        favoritesList = FavoritesList.sharedFavoriteList
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return favoritesList.favorites.isEmpty ? 1 : 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return section == 0 ? familyNames.count : 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "All Font Families" : "My Favorite Fonts"
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier(familyCell, forIndexPath: indexPath)
            cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
            cell.textLabel?.text = familyNames[indexPath.row]
            cell.detailTextLabel?.text = familyNames[indexPath.row]
            return cell
        }else{
            return tableView.dequeueReusableCellWithIdentifier(favoritesCell, forIndexPath: indexPath)
        }
    }
    
    func fontForDisplay(atIndexPath indexPath : NSIndexPath) -> UIFont?{
        if indexPath.section == 0{
            let familyName = familyNames[indexPath.row]
            if let fontName = UIFont.fontNamesForFamilyName(familyName).first{
                return UIFont(name: fontName, size: cellPointSize)
            }else{
                return nil
            }
        }else{
            return nil
        }
    }


   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        let listVC = segue.destinationViewController as! FontListViewController
        
        if indexPath?.section == 0{
            let familyName = familyNames[(indexPath?.row)!]
            listVC.fontNames = UIFont.fontNamesForFamilyName(familyName).sort()
            listVC.navigationItem.title = familyName
            listVC.showFavorites = false
        }else{
            listVC.fontNames = favoritesList.favorites
            listVC.navigationItem.title = "Favorites"
            listVC.showFavorites = true
        }
    }
    

}
