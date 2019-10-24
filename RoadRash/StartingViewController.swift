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
    @IBOutlet weak var touringOption: NSButton!
    @IBOutlet weak var racingOption: NSButton!
    @IBOutlet weak var participants: NSTextField!
    
    lazy var grandPrix = GrandPrix()
    
    var formatedParticipants: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = " Rally 🚗🏆🏍️ "
        initRadioButtonState(false)
        participants.stringValue = ""
        
    }
    
    
    @IBAction func onAddClicked(_ sender: NSButton) {
        getTextFromFields()
    }
    
    
    @IBAction func onMotoClicked(_ sender: NSButton) {
        moto.state = NSControl.StateValue.on
        car.state = NSControl.StateValue.off
        setupForClickedMoto()
        initRadioButtonState(true)
    }

    
    @IBAction func onCarClicked(_ sender: NSButton) {
        moto.state = NSControl.StateValue.off
        car.state = NSControl.StateValue.on
        setupForClickedCar()
        initRadioButtonState(true)
    }
    
    
    @IBAction func onTouringClicked(_ sender: NSButton) {
        touringOption.state = NSControl.StateValue.on
        racingOption.state = NSControl.StateValue.off
    }
    
    
    @IBAction func onRacingClicked(_ sender: NSButton) {
        touringOption.state = NSControl.StateValue.off
        racingOption.state = NSControl.StateValue.on
    }
    
    
    @IBAction func onProceedToRaceClicked(_ sender: NSButton) {
        if grandPrix.canConductRace() {
            let randomParticipants = grandPrix.selectParticipants()
            if grandPrix.isAllCar(randomParticipants) {
                if grandPrix.checkAllVehiclesAreCar(randomParticipants) {
                    goToRunWindow(randomParticipants)
                } else {
//                  grandPrix.vehicles = []
                    Util.showAlert(message: "Sorry, Not grand prix")
                }
            } else {
                if grandPrix.checkAllVehiclesAreMoto(randomParticipants) {
                    goToRunWindow(randomParticipants)
                } else {
//                  grandPrix.vehicles = []
                    Util.showAlert(message: "Sorry, Not grand prix")
                }
            }
        } else {
            Util.showAlert(message: "Sorry, Minimum of four participants required")
        }
    }
    
    
    func initRadioButtonState(_ state: Bool) {
        if state {
           touringOption.isHidden = false
           racingOption.isHidden = false
        } else {
            touringOption.isHidden = true
            racingOption.isHidden = true
        }
        
        touringOption.state = NSControl.StateValue.off
        racingOption.state = NSControl.StateValue.off
    }
 
    
    func setupForClickedCar() {
        touringOption.title = "Touring"
        racingOption.title = "Racing"
    }
    
    
    func setupForClickedMoto() {
        touringOption.title = "SideCar"
        racingOption.title = "Moto"
    }
    
    
    private func getTextFromFields() {
        let brandValue = brandName.stringValue
        let modelValue = modelName.stringValue
        let speedValue = speed.stringValue
        let weightValue = weight.stringValue
        let fuelValue = fuel.stringValue
        let economyValue = economy.stringValue
        
        var vehicleType: Int!
        var subOption: CarType!
        var isSideCarAvailable: Bool!
        if car.state.rawValue == 1 {
            vehicleType = Constants.CAR
            if touringOption.state.rawValue == 1 {
                subOption = CarType.TOURING
            } else {
                subOption = CarType.RACE
            }
        } else {
            vehicleType = Constants.MOTOCYCLE
            if touringOption.state.rawValue == 1 {
                isSideCarAvailable = true
            } else {
                isSideCarAvailable = false
            }
        }
        
        if !validateField() {
            return
        }
        
        if vehicleType == Constants.CAR {
            let carInstance = CarButton(brandName: brandValue, modelName: modelValue, maximalSpeed: Double(speedValue)!, weight: Int(weightValue)!, fuel: Double(fuelValue)!, economy: Double(economyValue)!, category: subOption)
            grandPrix.addVehicles(vehicle: carInstance)
            participants.stringValue += "\n \(carInstance.toString())"
            clearFields()
            Util.showAlert(message: "New car added")
        } else {
            let motoInstance = Motorcycle(brandName: brandValue, modelName: modelValue, maximalSpeed: Double(speedValue)!, weight: Int(weightValue)!, fuel: Double(fuelValue)!, economy: Double(economyValue)!, isSideCarAvail: isSideCarAvailable)
            grandPrix.addVehicles(vehicle: motoInstance)
            participants.stringValue += "\n \(motoInstance.toString())"
            clearFields()
            Util.showAlert(message: "New motocycle added")
        }
        
    }

    func goToRunWindow(_ vehicles: [VehicleButton]) {
        let viewController = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("viewController"))
                as! NSViewController
        let v = viewController as? ViewController
        v?.grandPrix = self.grandPrix
        self.view.window?.contentViewController = v
    }
    
    func clearFields() {
        brandName.stringValue = ""
        modelName.stringValue = ""
        speed.stringValue = ""
        fuel.stringValue = ""
        weight.stringValue = ""
        economy.stringValue = ""
        
        car.state = NSControl.StateValue.off
        moto.state = NSControl.StateValue.off
    
        initRadioButtonState(false)
    }
    
    func validateField() -> Bool {
        let brandValue = brandName.stringValue
        let modelValue = modelName.stringValue
        let speedValue = speed.stringValue
        let weightValue = weight.stringValue
        let fuelValue = fuel.stringValue
        let economyValue = economy.stringValue
        
        if brandValue.isEmpty {
            Util.showAlert(message: "Enter valid brand name")
            return false
        } else if modelValue.isEmpty {
            Util.showAlert(message: "Enter valid model name")
            return false
        } else if speedValue.isEmpty || !Util.isNumber(text: speedValue) || speedValue.count > 3 {
            Util.showAlert(message: "Enter valid speed")
            return false
        } else if  weightValue.isEmpty || !Util.isNumber(text: weightValue) || weightValue.count > 4 {
            Util.showAlert(message: "Enter valid weight")
            return false
        }  else if  fuelValue.isEmpty || !Util.isNumber(text: fuelValue) || fuelValue.count > 2 {
                   Util.showAlert(message: "Enter valid fuel")
                   return false
        } else if  economyValue.isEmpty || !Util.isNumber(text: economyValue) || economyValue.count > 2 {
                   Util.showAlert(message: "Enter valid economy")
                   return false
        }
        
        return true
        
    }
    
}
