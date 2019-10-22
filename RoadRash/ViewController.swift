//
//  ViewController.swift
//  RoadRash
//
//   Created by yadhukrishnan E on 18/10/19.
//  Copyright © 2019 AYA. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, OnVehicleFinishProtocol {
    
    private final var SPEED_UNIT: String = " KM/Hr"
    private final var FUEL_UNIT: String = " Lr"
    
    @IBOutlet weak var btnStartRace: NSButton!
    
    @IBOutlet weak var fVehicleName: NSTextField!
    @IBOutlet weak var sVehicleName: NSTextField!
    @IBOutlet weak var tVehicleName: NSTextField!
    @IBOutlet weak var frVehicleName: NSTextFieldCell!
    
    @IBOutlet weak var fVehicleSpeed: NSTextField!
    @IBOutlet weak var sVehicleSpeed: NSTextField!
    @IBOutlet weak var tVehicleSpeed: NSTextField!
    @IBOutlet weak var frVehicleSpeed: NSTextField!
    
    @IBOutlet weak var fVehicleFuel: NSTextField!
    @IBOutlet weak var sVehicleFuel: NSTextField!
    @IBOutlet weak var tVehicleFuel: NSTextField!
    @IBOutlet weak var frVehicleFuel: NSTextField!
    
    @IBOutlet weak var fVehicleDistance: NSTextField!
    @IBOutlet weak var sVehicleDistance: NSTextField!
    @IBOutlet weak var tVehicleDistance: NSTextField!
    @IBOutlet weak var frVehicleDistance: NSTextField!
    
    @IBOutlet weak var fVehicleFinished: NSTextField!
    @IBOutlet weak var sVehicleFinished: NSTextField!
    @IBOutlet weak var tVehicleFinished: NSTextField!
    @IBOutlet weak var frVehicleFinished: NSTextField!
    
    var fCar: CarButton!
    var sCar: CarButton!
    var tCar: CarButton!
    var frCar: CarButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fCar = CarButton()
        sCar = CarButton()
        tCar = CarButton()
        frCar = CarButton()
        initFinishState()
        createVehicle()
        displayVehicleDetails()
    }

    
    @IBAction func onStartClicked(_ sender: NSButton) {
        
        btnStartRace.isHidden = true
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.94) {
            self.moveLabel(self.fCar, 1)
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.94) {
            self.moveLabel(self.sCar, 1)
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.94) {
            self.moveLabel(self.tCar, 1)
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.94) {
            self.moveLabel(self.frCar, 1)
        }
    }
    
    func initFinishState() {
        fVehicleFinished.isHidden = true
        sVehicleFinished.isHidden = true
        tVehicleFinished.isHidden = true
        frVehicleFinished.isHidden = true
    }
    
    func createVehicle() {
        self.fCar.title = "BMW"
        fCar.yPoint = 0
        fCar.speed = 150
        fCar.setVehicleFinishProtocol(vehicleProtocol: self)
        self.view.addSubview(fCar)
        fCar.move()
        
        sCar.title = "Audi"
        sCar.yPoint = 25
        sCar.speed = 140
        sCar.setVehicleFinishProtocol(vehicleProtocol: self)
        self.view.addSubview(sCar)
        sCar.move()
        
        tCar.title = "Bugatti"
        tCar.yPoint = 50
        tCar.speed = 380
        tCar.setVehicleFinishProtocol(vehicleProtocol: self)
        self.view.addSubview(tCar)
        tCar.move()
        
        frCar.title = "Lamborgini"
        frCar.yPoint = 75
        frCar.speed = 300
        frCar.setVehicleFinishProtocol(vehicleProtocol: self)
        self.view.addSubview(frCar)
        frCar.move()
    }
    
    
    func displayVehicleDetails() {
        self.fVehicleName.stringValue = self.fCar.title
        self.sVehicleName.stringValue = self.sCar.title
        self.tVehicleName.stringValue = self.tCar.title
        self.frVehicleName.stringValue = self.frCar.title
        
        self.fVehicleSpeed.stringValue = String(self.fCar.speed) + SPEED_UNIT
        self.sVehicleSpeed.stringValue = String(self.sCar.speed) + SPEED_UNIT
        self.tVehicleSpeed.stringValue = String(self.tCar.speed) + SPEED_UNIT
        self.frVehicleSpeed.stringValue = String(self.frCar.speed) + SPEED_UNIT
        
        self.fVehicleFuel.stringValue = String(self.fCar.fuel) + FUEL_UNIT
        self.sVehicleFuel.stringValue = String(self.sCar.fuel) + FUEL_UNIT
        self.tVehicleFuel.stringValue = String(self.tCar.fuel) + FUEL_UNIT
        self.frVehicleFuel.stringValue = String(self.frCar.fuel) + FUEL_UNIT
    }
    
    
    func moveLabel(_ label: VehicleButton, _ turn: Int) {
        if label.xPoint >= 1000 {
            return
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            label.xPoint += Int(label.speed * 1000)/3600
            DispatchQueue.main.async {
                label.move()
                print("\(label.title) moved \(label.xPoint)")
            }
            
            self.moveLabel(label, turn)
        }
    }
    
    
    func onFinished(vehicle v: VehicleButton) {
        if v == fCar {
            fVehicleFinished.isHidden = false
        } else if v == sCar {
            sVehicleFinished.isHidden = false
        } else if v == tCar {
            tVehicleFinished.isHidden = false
        } else if v == frCar {
            frVehicleFinished.isHidden = false
        }
    }
}



