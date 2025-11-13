//
//  PhotographyTimesView.swift
//  Sundial
//
//  View displaying photography golden hours and blue hours
//

import SwiftUI
import CoreLocation

struct PhotographyTimesView: View {
    let location: CLLocation?
    let date: Date
    
    @State private var photographyTimes: [PhotographyTime] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let location = location {
                    locationInfoCard(location: location)
                    
                    ForEach(photographyTimes) { time in
                        photographyTimeCard(time: time)
                    }
                } else {
                    Text("Getting your location...")
                        .foregroundStyle(.secondary)
                        .padding()
                }
            }
            .padding()
        }
        .onChange(of: location) { _, _ in
            updatePhotographyTimes()
        }
        .onChange(of: date) { _, _ in
            updatePhotographyTimes()
        }
        .onAppear {
            updatePhotographyTimes()
        }
    }
    
    private func locationInfoCard(location: CLLocation) -> some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: "location.fill")
                    .foregroundStyle(.blue)
                Text("Current Location")
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                Text("Lat: \(location.coordinate.latitude, specifier: "%.4f")")
                Spacer()
                Text("Lon: \(location.coordinate.longitude, specifier: "%.4f")")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    private func photographyTimeCard(time: PhotographyTime) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: time.icon)
                    .font(.title2)
                    .foregroundStyle(time.color)
                
                Text(time.name)
                    .font(.headline)
                
                Spacer()
            }
            
            Divider()
            
            if let start = time.startTime, let end = time.endTime {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Start")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(start, style: .time)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("End")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(end, style: .time)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                }
                
                if let duration = time.duration {
                    Text("Duration: \(Int(duration / 60)) minutes")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } else {
                Text("Not available on this date")
                    .foregroundStyle(.secondary)
                    .italic()
            }
            
            Text(time.description)
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.top, 4)
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [time.color.opacity(0.1), time.color.opacity(0.05)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(time.color.opacity(0.3), lineWidth: 1)
        )
    }
    
    private func updatePhotographyTimes() {
        guard let location = location else {
            photographyTimes = []
            return
        }
        
        let calculator = SolarCalculator(location: location, date: date)
        photographyTimes = [
            PhotographyTime(
                name: "Morning Blue Hour",
                description: "The period of twilight before sunrise when the sun is between 4° and 6° below the horizon. Perfect for capturing cool, blue-toned images.",
                icon: "moon.stars.fill",
                color: .blue,
                startTime: calculator.morningBlueHourStart,
                endTime: calculator.morningBlueHourEnd
            ),
            PhotographyTime(
                name: "Morning Golden Hour",
                description: "The first hour after sunrise when the light is soft, warm, and directional. Ideal for portraits and landscapes.",
                icon: "sunrise.fill",
                color: .orange,
                startTime: calculator.sunrise,
                endTime: calculator.morningGoldenHourEnd
            ),
            PhotographyTime(
                name: "Solar Noon",
                description: "When the sun reaches its highest point in the sky. Light is harsh and creates strong shadows.",
                icon: "sun.max.fill",
                color: .yellow,
                startTime: calculator.solarNoon,
                endTime: calculator.solarNoon
            ),
            PhotographyTime(
                name: "Evening Golden Hour",
                description: "The last hour before sunset when the light is soft, warm, and directional. Perfect for photography.",
                icon: "sunset.fill",
                color: .orange,
                startTime: calculator.eveningGoldenHourStart,
                endTime: calculator.sunset
            ),
            PhotographyTime(
                name: "Evening Blue Hour",
                description: "The period of twilight after sunset when the sun is between 4° and 6° below the horizon. Great for cityscapes and architecture.",
                icon: "moon.stars.fill",
                color: .blue,
                startTime: calculator.eveningBlueHourStart,
                endTime: calculator.eveningBlueHourEnd
            )
        ]
    }
}

#Preview {
    PhotographyTimesView(
        location: CLLocation(latitude: 37.7749, longitude: -122.4194),
        date: Date()
    )
}
