//
//  MotionManager.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 19/02/25.
//


import CoreMotion
import Combine

class MotionManager: ObservableObject {
    private var motionManager = CMMotionManager()
    private var updateInterval = 1.0 / 60.0  
    
    @Published var roll: Double = 0.0
    @Published var pitch: Double = 0.0
    @Published var yaw: Double = 0.0

    init() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = updateInterval
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
                guard let motion = motion, error == nil else { return }
                
                self?.roll = motion.attitude.roll
                self?.pitch = motion.attitude.pitch
                self?.yaw = motion.attitude.yaw
            }
        }
    }
}
