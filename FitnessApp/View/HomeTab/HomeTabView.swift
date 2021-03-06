//
//  HomeView.swift
//  FitnessApp
//
//  Created by Robert Basamac on 18.04.2022.
//

import SwiftUI

struct HomeTabView: View {   
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var dateModel: DateModel
        
    @Environment(\.colorScheme) var colorScheme
    
    @State private var weekViewTransitionDirection: WeekTransition = .previous
    
    enum WeekTransition: Identifiable, CaseIterable {
        var id: Self { self }
        
        case previous
        case next
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section {
                        updateWeekSection
                        
                        swipeableWeekView
                        
                        todayWorkoutsSection
                    } header: {
                        headerSection
                    }
                }
                .padding(.horizontal, 4)
                .onAppear {
                    dateModel.showCurrentWeek()
                }
            }
            .frame(maxHeight: .infinity)
        }
        .clipped()
    }
}

//MARK: - Content Views

extension HomeTabView {
    
    private var headerSection: some View {
        
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 15) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                
                Text(dateModel.extractDate(date: Date(), format: "EEEE"))
                    .font(.largeTitle.bold())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                
            } label: {
                Image("Profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background {
            Color(uiColor: .systemBackground)
        }
    }
    
    private var updateWeekSection: some View {
        
        HStack {
            Button {
                weekViewTransitionDirection = .previous
                
                withAnimation {
                    dateModel.showPreviousWeek()
                }
            } label: {
                Image(systemName: "chevron.left")
                    .padding(.horizontal)
            }
            
            Button {
                    dateModel.showCurrentWeek()
            } label: {
                Text("Today")
                    .padding(.horizontal)
            }
                        
            Button {
                weekViewTransitionDirection = .next
                
                withAnimation {
                    dateModel.showNextWeek()
                }
            } label: {
                Image(systemName: "chevron.right")
                    .padding(.horizontal)
            }
        }
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
    }
    
    private var swipeableWeekView: some View {
        
        ZStack {
            ForEach(dateModel.displayedWeeks, id: \.self) { week in
                if week == dateModel.currentWeek {
                    WeekView(week: week)
                        .padding(.horizontal, 4)
                        .transition(getTransition())
                }
            }
        }
    }
    
    private var todayWorkoutsSection: some View {
        
        LazyVStack {
            if let workouts = workoutManager.getWorkouts(for: dateModel.extractDate(date: dateModel.selectedDay, format: "dd/MM/yyy")) {
                ForEach(workouts) { workout in
                    Text("\(workout.title)")
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity)
                }
            } else {
                Text("No workouts assigned.")
                    .font(.system(size: 16))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

//MARK: - Helper Methods

extension HomeTabView {
    
    private func getTransition() -> AnyTransition {
        switch weekViewTransitionDirection {
        case .previous:
            return AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))
        case .next:
            return AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
            .environmentObject(WorkoutManager())
            .environmentObject(DateModel())
            .environmentObject(ViewRouter())
    }
}
