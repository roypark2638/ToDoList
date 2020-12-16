//
//  IconImage.swift
//  ToDoList
//
//  Created by Roy Park on 12/15/20.
//

import Foundation

struct IconImage {        
    var iconImages: [String]
    
    init() {
        self.iconImages = etcIcons + workIcon + trasfortationIcon + weatherIcon + foodIcons + peopleIcon + animalIcons + dirctionIcons + logoIcons + serviceIcon + sportsIcon
    }
    
    let etcIcons = [
        "icons8-bookmark-500", "icons8-calendar-500", "icons8-document-500", "icons8-heart-500",
        "icons8-love-500", "icons8-fire-500", "icons8-address-500", "icons8-shopping-cart-500",
        "icons8-key-500", "icons8-mailbox-500", "icons8-menu-500", "icons8-money-500",
        "icons8-packaging-500", "icons8-picture-500", "icons8-pokeball-500", "icons8-pricing-500",
        "icons8-rent-500", "icons8-bridge-500", "icons8-trash-can-500"
    ]
    
    let workIcon = [
        "icons8-account-500", "icons8-decline-500", "icons8-america-500",
        "icons8-bitcoin-500", "icons8-document-500", "icons8-microsoft-excel-500",
        "icons8-new-york-500", "icons8-organization-500", "icons8-powerpoint-500",
        "icons8-school-500","icons8-search-500", "icons8-toolbox-500",
        "icons8-windows-10-500", "icons8-work-500"
    ]
    
    let trasfortationIcon = [
        "icons8-airport-500", "icons8-bicycle-500", "icons8-driver-500", "icons8-motorbike-helmet-500", "icons8-sedan-500", "icons8-truck-500"
    ]
    
    let weatherIcon = [
        "icons8-autumn-500", "icons8-spring-500", "icons8-summer-500", "icons8-winter-500"
    ]
    
    let foodIcons = [
        "icons8-bar-500", "icons8-bread-500", "icons8-cafe-500", "icons8-french-fries-500",
        "icons8-hamburger-500", "icons8-hot-dog-500", "icons8-meal-500", "icons8-pizza-500",
        "icons8-prawn-500", "icons8-sandwich-500", "icons8-taco-500"
    ]
    
    let peopleIcon = [
        "icons8-baby-bottle-500", "icons8-babys-room-500", "icons8-boy-500",
        "icons8-boy-stroller-500", "icons8-family-500-2", "icons8-family-500", "icons8-girl-500"
    ]
    
    let animalIcons = [
        "bird", "cat", "chicken", "clownfish", "corgi", "dog-park", "unicorn"
    ]
    
    let dirctionIcons = [
        "down-arrow", "drag", "left-arrow", "resize-horizontal", "resize-vertical", "right-arrow", "sort-down", "sort-left", "sort-right", "sort-up", "sort", "up-arrow"
    ]

    
    let logoIcons = [
        "icons8-apple-logo-500", "icons8-dropbox-500", "icons8-google-500",
        "icons8-netflix-desktop-app-500", "icons8-youtube-500"
    ]
    

    
    let serviceIcon = [
        "icons8-ambulance-500", "icons8-barbershop-500", "icons8-barbershop-501",
        "icons8-big-drop-500", "icons8-circus-tent-500", "icons8-clinic-500",
        "icons8-communication-500", "icons8-customer-support-500", "icons8-hospital-bed-500",
        "icons8-movie-ticket-500", "icons8-music-500", "icons8-nails-500", "icons8-palace-500",
        "icons8-pill-500", "icons8-taxi-500", "icons8-theme-park-500", "icons8-tooth-500",
        "icons8-water-park-500"
    ]
    
    let sportsIcon = [
        "icons8-badminton-player-500", "icons8-bowling-500", "icons8-canoe-500", "icons8-corner-500", "icons8-dancing-500", "icons8-fishing-500", "icons8-gymnastics-500", "icons8-horseback-riding-500", "icons8-skateboard-500", "icons8-skiing-500", "icons8-soccer-player-500", "icons8-swimming-500", "icons8-table-tennis-500", "icons8-tennis-player-500", "icons8-trekking-500"
    ]
    

    

}
