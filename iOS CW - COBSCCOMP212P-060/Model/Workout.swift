//
//  Workout.swift
//  iOS CW - COBSCCOMP212P-060
//
//  Created by Isini Bandara on 2023-05-18.
//

import Foundation
import UIKit

struct Workout {
    let title: String
    let description: String
    let image: UIImage
}

let workouts: [Workout] = [
    Workout(title: "Wake Up Call", description: "| 04 Workouts  for Beginner", image: UIImage(named: "workout1")!),
    Workout(title: "Full Body Goal Crusher", description: "| 07 Workouts  for Beginner", image: UIImage(named: "workout2")!),
    Workout(title: "Lower Body Strength", description: "| 05 Workouts  for Beginner", image: UIImage(named: "workout3")!),
    Workout(title: "Workout 4", description: "Description 4", image: UIImage(named: "workout4")!),
    Workout(title: "Workout 5", description: "Description 5", image: UIImage(named: "workout5")!),
    Workout(title: "Workout 6", description: "Description 6", image: UIImage(named: "workout6")!),
    Workout(title: "Workout 7", description: "Description 7", image: UIImage(named: "workout7")!)
]

struct WorkoutMainList {
    let ID: Int
    let burn_cal: String
    let covered_area: String
    let duration: String
    let interval: String
    let title: String
    let url: String
}

struct WorkoutList {
    let ID: Int
    let body_part: String
    let duration: Int
    let instruction: String
    let muscel: String
    let title: String
    let video_url: String
}
