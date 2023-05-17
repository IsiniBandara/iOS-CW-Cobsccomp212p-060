//
//  WorkoutView.swift
//  iOS CW - COBSCCOMP212P-060
//
//  Created by Isini Bandara on 2023-05-17.
//

import UIKit

class WorkoutView: UIView {
    private var timer: Timer?
    private var counter: Int = 0
    private var repsCount: Int = 0
    private let timerLabel = UILabel()
    private let repsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureUI()
        addConstraints()
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.font = UIFont.systemFont(ofSize: 40)
        timerLabel.textAlignment = .center
        timerLabel.textColor = UIColor(named: "Green")
        
        repsLabel.translatesAutoresizingMaskIntoConstraints = false
        repsLabel.font = UIFont.systemFont(ofSize: 20)
        repsLabel.textAlignment = .center
        repsLabel.textColor = UIColor(named: "Green")
        
        addSubview(timerLabel)
        addSubview(repsLabel)
    }
    
    private func addConstraints() {
        let constraints = [
            timerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            repsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            repsLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func startWorkout() {
        timer?.invalidate() // Invalidate any existing timer
        
        counter = 0
        repsCount = 0
        
        timerLabel.text = "0"
        repsLabel.text = "Reps: 0"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        counter += 1
        timerLabel.text = "\(counter)"
        
        if counter > 60 {
            stopWorkout()
        } else if counter % 4 == 0 {
            repsCount += 1
            repsLabel.text = "Reps: \(repsCount)"
            
            if repsCount >= 15 {
                stopWorkout()
            }
        }
    }
    
    private func stopWorkout() {
        timer?.invalidate()
        timer = nil
    }
}
