//
//  StartingViewHolder.swift
//  RoadRash
//
//  Created by yadhukrishnan E on 22/10/19.
//  Copyright © 2019 AYA. All rights reserved.
//

import Cocoa

class StartingViewController: NSViewController {

    @IBOutlet weak var brandName: NSTextField!
    @IBOutlet weak var modelName: NSTextField!
    @IBOutlet weak var speed: NSTextField!
    @IBOutlet weak var weight: NSTextField!
    @IBOutlet weak var fuel: NSTextField!
    @IBOutlet weak var economy: NSTextField!
    @IBOutlet weak var car: NSButton!
    @IBOutlet weak var moto: NSButton!
    @IBOutlet weak var raceOrTouringOrSideCar: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onAddClicked(_ sender: NSButton) {
            print("Add Clicked")
    }
    
    @IBAction func onMotoClicked(_ sender: NSButton) {
        car.state = false
            print("Add moto Clicked")
    }

    @IBAction func onCarClicked(_ sender: NSButton) {
        moto.state = offState
               print("Add moto Clicked")
       }
}
