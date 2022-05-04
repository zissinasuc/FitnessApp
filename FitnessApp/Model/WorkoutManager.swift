//
//  WorkoutManager.swift
//  FitnessApp
//
//  Created by Robert Basamac on 27.04.2022.
//

import Foundation

class WorkoutManager: ObservableObject {
    @Published private var schedule: [String: [Workout]] = [
        "02/05/2022": [Workout(title: "Bench press"), Workout(title: "Leg press")],
        "04/05/2022": [Workout(title: "Bench press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press"), Workout(title: "Leg press")],
        "05/05/2022": [Workout(title: "Bench press"), Workout(title: "Leg press")],
        "07/05/2022": [Workout(title: "Bench press"), Workout(title: "Leg press")],
        "08/05/2022": [Workout(title: "Shoulder press"), Workout(title: "Abs")]
        ]
    
    func hasWorkouts(for day: String) -> Bool {
        return schedule.keys.contains(day)
    }
    
    func addWorkout(_ workout: Workout, for day: String) {
        if var mergedWorkouts = schedule[day] {
            mergedWorkouts.append(workout)
            schedule.updateValue(mergedWorkouts, forKey: day)
        } else {
            schedule.updateValue([workout], forKey: day)
        }
    }
    
    func getWorkouts(for day: String) -> [Workout]? {
        return schedule[day]
    }
}
