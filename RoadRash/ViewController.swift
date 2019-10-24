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
    
    @IBOutlet weak var turnBox: NSComboBox!
    @IBOutlet weak var lapBox: NSComboBox!
    
    var fCar: VehicleButton!
    var sCar: VehicleButton!
    var tCar: VehicleButton!
    var frCar: VehicleButton!
    
    var grandPrix: GrandPrix!
    
    var turnPoints: [(Int, VehicleButton)]!
    
    var noOfLaps: Int = 2
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = " Rally 🚗🏆🏍️ "
        fCar = CarButton()
        sCar = CarButton()
        tCar = CarButton()
        frCar = CarButton()
        
        turnBox.selectItem(at: 0)
        turnPoints = []
        
        initFinishState()
        createVehicle()
        displayVehicleDetails()
    }
    
    @IBAction func onStartClicked(_ sender: NSButton) {
        
        
        let noOfTurns = turnBox.indexOfSelectedItem
        if noOfTurns < 2 {
            Util.showAlert(message: "Select no of turns required, It is mandatory")
            return
        }
        
        noOfLaps = lapBox.indexOfSelectedItem
        if (noOfLaps == 0) {
            Util.showAlert(message: "Select no of laps required, It is mandatory")
            return
        }
        
        btnStartRace.isHidden = true
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.94) {
            self.fCar.isFinishingLap = (self.fCar.currentRunningLap == self.noOfLaps)
            self.moveLabel(self.fCar, 1)
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.94) {
            self.sCar.isFinishingLap = (self.sCar.currentRunningLap == self.noOfLaps)
            self.moveLabel(self.sCar, 1)
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.94) {
            self.tCar.isFinishingLap = (self.tCar.currentRunningLap  == self.noOfLaps)
            self.moveLabel(self.tCar, 1)
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.94) {
            self.frCar.isFinishingLap = (self.frCar.currentRunningLap  == self.noOfLaps)
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
        guard let grandPrix = grandPrix else {
            print("User dont have any vehicle details")
            return
        }
        
        let vehicles = grandPrix.vehicles
        fCar = vehicles[0]
        fCar.yPoint = 0
        fCar.image = (fCar is CarButton ? NSImage(named: "carThree")! : NSImage(named: "motoOne")!)
        fCar.setVehicleFinishProtocol(vehicleProtocol: self)
        self.view.addSubview(fCar)
        fCar.move()
        
        
        sCar = vehicles[1]
        sCar.yPoint = 25
        sCar.image = (sCar is CarButton ? NSImage(named: "carTwo")! : NSImage(named: "motoTwo")!)
        sCar.setVehicleFinishProtocol(vehicleProtocol: self)
        self.view.addSubview(sCar)
        sCar.move()
        
        
        tCar = vehicles[2]
        tCar.yPoint = 50
        tCar.image = (tCar is CarButton ? NSImage(named: "car")! : NSImage(named: "motoThree")!)
        tCar.setVehicleFinishProtocol(vehicleProtocol: self)
        self.view.addSubview(tCar)
        tCar.move()
        
        frCar = vehicles[3]
        frCar.yPoint = 75
        frCar.image = (tCar is CarButton ? NSImage(named: "carFour")! : NSImage(named: "motoFour")!)
        frCar.setVehicleFinishProtocol(vehicleProtocol: self)
        self.view.addSubview(frCar)
        frCar.move()
        
        grandPrix.updatePerformance()
    }
    
    
    func displayVehicleDetails() {
        self.fVehicleName.stringValue = self.fCar.brandName
        self.sVehicleName.stringValue = self.sCar.brandName
        self.tVehicleName.stringValue = self.tCar.brandName
        self.frVehicleName.stringValue = self.frCar.brandName
        
        self.fVehicleSpeed.stringValue = String(self.fCar.speed) + SPEED_UNIT
        self.sVehicleSpeed.stringValue = String(self.sCar.speed) + SPEED_UNIT
        self.tVehicleSpeed.stringValue = String(self.tCar.speed) + SPEED_UNIT
        self.frVehicleSpeed.stringValue = String(self.frCar.speed) + SPEED_UNIT
        
        setFuel()
        setLap()
    }
    
    func setFuel() {
        self.fVehicleFuel.stringValue = String(self.fCar.fuel) + FUEL_UNIT
        self.sVehicleFuel.stringValue = String(self.sCar.fuel) + FUEL_UNIT
        self.tVehicleFuel.stringValue = String(self.tCar.fuel) + FUEL_UNIT
        self.frVehicleFuel.stringValue = String(self.frCar.fuel) + FUEL_UNIT
    }
    
    func setLap() {
        self.fVehicleDistance.stringValue = "\(self.fCar.currentRunningLap)"
        self.sVehicleDistance.stringValue = "\(self.sCar.currentRunningLap)"
        self.tVehicleDistance.stringValue = "\(self.tCar.currentRunningLap)"
        self.frVehicleDistance.stringValue = "\(self.frCar.currentRunningLap)"
    }
    
    
    func moveLabel(_ label: VehicleButton, _ turn: Int) {
        if label.xPoint >= 1000 {
            if label.currentRunningLap >= noOfLaps {
                label.isFinishingLap = true
                return
            } else {
                label.currentRunningLap += 1
                label.isFinishingLap = false
                label.xPoint = 0
            }
        } else if label.fuel <= 0 {
            return
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.50) {
            let speed = label.speed
            for (key, _) in self.turnPoints {
                switch label.xPoint {
                    case (key - 30)...(key + 30):
                        label.currentSpeed = (label.speed / 10)
                        label.fuel -= 0.5
                    default:
                        label.currentSpeed = label.currentSpeed + (speed / 10)
                }
            }
            
            if label.currentSpeed >= speed {
                label.currentSpeed = speed
            }
            
            label.xPoint += Int(label.currentSpeed * 1000)/(3600)
            DispatchQueue.main.async {
                label.move()
                self.setFuel()
                self.setLap()
            }
            
            self.moveLabel(label, turn)
        }
    }
    
    
    func onFinished(vehicle v: VehicleButton) {
        if v == fCar {
            fVehicleFinished.stringValue = "Finished"
            fVehicleFinished.isHidden = false
        } else if v == sCar {
            sVehicleFinished.stringValue = "Finished"
            sVehicleFinished.isHidden = false
        } else if v == tCar {
            tVehicleFinished.stringValue = "Finished"
            tVehicleFinished.isHidden = false
        } else if v == frCar {
            frVehicleFinished.stringValue = "Finished"
            frVehicleFinished.isHidden = false
        }
    }
    
    func onRaceFailed(vehicle v: VehicleButton) {
           if v == fCar {
                fVehicleFinished.stringValue = "Failed"
                fVehicleFinished.isHidden = false
           } else if v == sCar {
                sVehicleFinished.stringValue = "Failed"
                sVehicleFinished.isHidden = false
           } else if v == tCar {
                tVehicleFinished.stringValue = "Failed"
                tVehicleFinished.isHidden = false
           } else if v == frCar {
                frVehicleFinished.stringValue = "Failed"
                frVehicleFinished.isHidden = false
           }
    }
       
       
    
    
    @IBAction func onItemSelect(_ sender: Any) {
        guard  turnBox.indexOfSelectedItem == 0, turnBox.indexOfSelectedItem == 1 else {
            for (_, value) in turnPoints {
                value.removeFromSuperview();
            }
            return setTurns()
        }
    }
    
    func setTurns() {
        let turn = Int(turnBox.stringValue)!
        var i = 0
        var point = 1000 / (turn + 1)
        while i < turn {
            let turnXPoint = point
            let turnButton = CarButton()
            turnButton.xPoint = turnXPoint
            turnButton.yPoint = 105
            turnButton.width = 20
            turnButton.height = 20
            turnButton.image = NSImage(named: "turn")!
            self.view.addSubview(turnButton)
            turnButton.move()
            turnPoints.append((turnXPoint, turnButton))
            i += 1
            point += point
            if point >= 800 {
                break
            }
        }
    }
    
    @IBAction func onLapItemSelect(_ sender: Any) {
        guard  lapBox.indexOfSelectedItem == 0 else {
            noOfLaps = lapBox.indexOfSelectedItem
            return
        }
    }
}



