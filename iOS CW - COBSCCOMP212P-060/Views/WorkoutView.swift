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
    private var duration: Int = 60
    private var repsCount: Int = 0
    private let timerLabel = UILabel()
    private let repsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        assignVal(for: duration)
        configureUI()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureUI()
        addConstraints()
    }
    
    private func configureUI() {
        backgroundColor = UIColor(named: "Black")
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.font = UIFont.systemFont(ofSize: 26)
        timerLabel.text = "0 sec"
        timerLabel.textAlignment = .center
        timerLabel.textColor = UIColor(named: "Green")
        
        repsLabel.translatesAutoresizingMaskIntoConstraints = false
        repsLabel.font = UIFont.systemFont(ofSize: 26)
        repsLabel.text = "Reps: 0"
        repsLabel.textAlignment = .center
        repsLabel.textColor = UIColor(named: "Green")
        
        addSubview(timerLabel)
        addSubview(repsLabel)
    }
    
    func assignVal(for duration: Int){
        self.duration = duration
    }
    
    private func addConstraints() {
        let constraints = [
            timerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            timerLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            repsLabel.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor),
//            repsLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            repsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func startWorkout() {
        timer?.invalidate() // Invalidate any existing timer
        counter = 0
        repsCount = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        counter += 1
        timerLabel.text = "\(counter) sec"
        
        if counter > duration {
            stopWorkout()
        } else if counter % 4 == 0 {
            repsCount += 1
            repsLabel.text = "Reps: \(repsCount)"
            
            if repsCount >= 15 {
                stopWorkout()
            }
        }
    }
    
    func stopWorkout() {
        timer?.invalidate()
        timer = nil
    }
}
