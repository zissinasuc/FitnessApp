//
//  WorkoutsView.swift
//  FitnessApp
//
//  Created by Robert Basamac on 27.04.2022.
//

import SwiftUI

struct WorkoutsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var dateModel: DateModel
    
    var body: some View {
        LazyVStack {
            if let workouts = workoutManager.getWorkouts(for: dateModel.extractDate(date: dateModel.currentDay, format: "dd/MM/yyy")) {
                ForEach(workouts) { workout in
                    Text("\(workout.title)")
                        .font(.system(size: 16))
                }
            } else {
                Text("No workouts assigned.")
                    .font(.system(size: 16))
            }
        }
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
            .environmentObject(WorkoutManager())
            .environmentObject(DateModel())
            .environmentObject(ViewRouter())
    }
}
