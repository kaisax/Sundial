//
//  ContentView.swift
//  Sundial
//
//  Main view for the Photography Times app
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                if locationManager.isAuthorized {
                    PhotographyTimesView(
                        location: locationManager.location,
                        date: selectedDate
                    )
                    
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .padding()
                } else {
                    VStack(spacing: 20) {
                        Image(systemName: "location.circle.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.blue)
                        
                        Text("Location Access Required")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Please enable location services to see accurate photography times for your area.")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                        
                        Button("Enable Location") {
                            locationManager.requestPermission()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }
            }
            .navigationTitle("Sundial")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ContentView()
}
