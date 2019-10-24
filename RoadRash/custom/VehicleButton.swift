//
//  Vehicle.swift
//  RoadRash
//
//  Created by yadhukrishnan E on 21/10/19.
//  Copyright © 2019 AYA. All rights reserved.
//

import Cocoa

class VehicleButton: NSImageView {

    var brandName: String
    var modelName: String
    var weight: Int
    var speed: Double
    var fuel: Double
    var economy: Double
    var width: Int
    var height: Int
    var xPoint: Int
    var yPoint: Int
    var currentSpeed: Double
    var vehiclePerformance: Double
    var isFinishingLap: Bool
    var ranking: Int
    var currentRunningLap: Int
    var isFinished: Bool
    
    var onVehicleFinishProtocol: OnVehicleFinishProtocol?

    /**
        This the default contructor
     */
    required init() {
        self.brandName = "Anonym"
        self.modelName = "Anonym"
        self.fuel = 0
        self.speed = 130
        self.weight = 1000
        self.economy = 0.0
        self.width = 50
        self.height = 20
        self.xPoint = 0
        self.yPoint = 0
        self.currentSpeed = 0
        self.vehiclePerformance = 0
        self.isFinishingLap = true
        self.ranking = 0
        self.currentRunningLap = 1
        self.isFinished = false
        super.init(frame: .zero)
        
        self.vehiclePerformance = self.performance()
    }

    /**
       This constructor gets value from the user and sets the value
    */
    required init(brandName: String, modelName: String, maximalSpeed: Double, weight: Int, fuel: Double, economy: Double) {
        self.brandName = brandName
        self.modelName = modelName
        self.fuel = fuel
        self.weight = weight
        self.speed = maximalSpeed
        self.economy = economy
        self.width = 70
        self.height = 20
        self.xPoint = 0
        self.yPoint = 0
        self.currentSpeed = 0
        self.vehiclePerformance = 0
        self.isFinishingLap = true
        self.ranking = 0
        self.currentRunningLap = 1
        self.isFinished = false
        super.init(frame: .zero)
        
        self.vehiclePerformance = self.performance()
    }
    
    /**
        Contructor for button
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
        This method compares the performance of the current vehicle with an another vehicle.
     */
    func isBetter(vehicle: VehicleButton) -> Bool {
        let thisVehiclePerformance = performance(vehicle: self)
        let otherVehiclePerformance = performance(vehicle: vehicle)
        return thisVehiclePerformance > otherVehiclePerformance
    }
    
    /**
        This method calculates the performance of a vehicle
     */
    func performance(vehicle: VehicleButton) -> Double {
        return Double(vehicle.speed / Double(vehicle.weight))
    }
    
    /**
        This method calculates the performance of a vehicle
     */
    func performance() -> Double {
        return Double(self.speed / Double(self.weight))
    }
        
    /**
        This method inits the protocol OnVehicleFinishProtocol
     */
    func setVehicleFinishProtocol( vehicleProtocol: OnVehicleFinishProtocol) {
        self.onVehicleFinishProtocol = vehicleProtocol
    }
    
    /**
        This method moves the button to a apecific location(x, y)
     */
    func move() {
        self.frame = CGRect(x: xPoint, y: yPoint, width: width, height: height)
        setXPoint(xPoint: xPoint)
    }
    
    /**
        This method sets the xPoint and triggers the protocol when the xPoint is greater than or equal to 1000
     */
    private func setXPoint(xPoint x: Int) {
        xPoint = x
        if let onVehicleFinishProtocol = onVehicleFinishProtocol, xPoint >= 1000, isFinishingLap {
            self.isFinished = true
            onVehicleFinishProtocol.onFinished(vehicle: self)
        }
        
        if let onVehicleFinishProtocol = onVehicleFinishProtocol, fuel <= 0 {
            self.isFinished = true
            onVehicleFinishProtocol.onRaceFailed(vehicle: self)
        }
    }
    
    /**
        This method is to print the vehicle details
     */
    func toString() -> String { return ""}

}
