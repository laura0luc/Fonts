//
//  FavoritesList.swift
//  Fonts
//
//  Created by LAURA LUCRECIA SANCHEZ PADILLA on 08/10/15.
//  Copyright © 2015 LAURA LUCRECIA SANCHEZ PADILLA. All rights reserved.
//

import Foundation
import UIKit

class FavoritesList{
    class var sharedFavoriteList : FavoritesList{
        struct Singleton {
            static let instance = FavoritesList()
        }
        return Singleton.instance
    }
    
    private(set) var favorites:[String]
    
    init(){
        let defaults = NSUserDefaults.standardUserDefaults()
        let storedFavorites = defaults.objectForKey("favorites") as? [String]
        favorites = storedFavorites != nil ? storedFavorites! : []
    }
    
    func addFavorite(fontName : String){
        if !favorites.contains(fontName){
            favorites.append(fontName)
            saveFavorites()
        }
    }
    
    func removeFavorites(fontName : String){
        if let index = favorites.indexOf(fontName){
            favorites.removeAtIndex(index)
            saveFavorites()
        }
    }
    
    private func saveFavorites(){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(favorites, forKey: "favorites")
        defaults.synchronize()
    }
    
    func moveItem(fromIndex from: Int, toIndex to: Int){
        let item = favorites[from]
        favorites.removeAtIndex(from)
        favorites.insert(item, atIndex: to)
        saveFavorites()
    }
}