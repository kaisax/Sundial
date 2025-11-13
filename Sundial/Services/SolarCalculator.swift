//
//  SolarCalculator.swift
//  Sundial
//
//  Calculates solar events and photography times
//  Based on NOAA Solar Calculator algorithms
//

import Foundation
import CoreLocation

class SolarCalculator {
    let location: CLLocation
    let date: Date
    
    private let calendar = Calendar.current
    
    init(location: CLLocation, date: Date) {
        self.location = location
        self.date = date
    }
    
    // MARK: - Public Properties
    
    var sunrise: Date? {
        calculateSolarEvent(angle: 90.833, rising: true)
    }
    
    var sunset: Date? {
        calculateSolarEvent(angle: 90.833, rising: false)
    }
    
    var solarNoon: Date? {
        guard let jd = julianDay else { return nil }
        let tz = TimeZone.current.secondsFromGMT(for: date)
        let eqTime = equationOfTime(julianDay: jd)
        let solarNoonOffset = 720.0 - (location.coordinate.longitude * 4.0) - eqTime
        let noonLocal = solarNoonOffset + Double(tz) / 60.0
        
        let hours = Int(noonLocal / 60.0)
        let minutes = Int(noonLocal.truncatingRemainder(dividingBy: 60.0))
        let seconds = Int((noonLocal * 60.0).truncatingRemainder(dividingBy: 60.0))
        
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        components.hour = hours
        components.minute = minutes
        components.second = seconds
        components.timeZone = TimeZone.current
        
        return calendar.date(from: components)
    }
    
    // Golden Hour: approximately 1 hour after sunrise and 1 hour before sunset
    var morningGoldenHourEnd: Date? {
        guard let sunrise = sunrise else { return nil }
        return calendar.date(byAdding: .hour, value: 1, to: sunrise)
    }
    
    var eveningGoldenHourStart: Date? {
        guard let sunset = sunset else { return nil }
        return calendar.date(byAdding: .hour, value: -1, to: sunset)
    }
    
    // Blue Hour: when sun is between 4° and 6° below horizon
    var morningBlueHourStart: Date? {
        calculateSolarEvent(angle: 96.0, rising: true)
    }
    
    var morningBlueHourEnd: Date? {
        calculateSolarEvent(angle: 94.0, rising: true)
    }
    
    var eveningBlueHourStart: Date? {
        calculateSolarEvent(angle: 94.0, rising: false)
    }
    
    var eveningBlueHourEnd: Date? {
        calculateSolarEvent(angle: 96.0, rising: false)
    }
    
    // MARK: - Private Calculation Methods
    
    private var julianDay: Double? {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        guard let year = components.year,
              let month = components.month,
              let day = components.day else { return nil }
        
        let a = (14 - month) / 12
        let y = year + 4800 - a
        let m = month + 12 * a - 3
        
        let jdn = day + (153 * m + 2) / 5 + 365 * y + y / 4 - y / 100 + y / 400 - 32045
        return Double(jdn)
    }
    
    private func julianCentury(julianDay: Double) -> Double {
        return (julianDay - 2451545.0) / 36525.0
    }
    
    private func geometricMeanLongitudeSun(julianCentury: Double) -> Double {
        var l0 = 280.46646 + julianCentury * (36000.76983 + julianCentury * 0.0003032)
        l0 = l0.truncatingRemainder(dividingBy: 360.0)
        return l0
    }
    
    private func geometricMeanAnomalySun(julianCentury: Double) -> Double {
        return 357.52911 + julianCentury * (35999.05029 - 0.0001537 * julianCentury)
    }
    
    private func eccentricityEarthOrbit(julianCentury: Double) -> Double {
        return 0.016708634 - julianCentury * (0.000042037 + 0.0000001267 * julianCentury)
    }
    
    private func equationOfTime(julianDay: Double) -> Double {
        let jc = julianCentury(julianDay: julianDay)
        let epsilon = obliquityCorrection(julianCentury: jc)
        let l0 = geometricMeanLongitudeSun(julianCentury: jc)
        let e = eccentricityEarthOrbit(julianCentury: jc)
        let m = geometricMeanAnomalySun(julianCentury: jc)
        
        var y = tan(epsilon.degreesToRadians / 2.0)
        y *= y
        
        let sin2l0 = sin(2.0 * l0.degreesToRadians)
        let sinm = sin(m.degreesToRadians)
        let cos2l0 = cos(2.0 * l0.degreesToRadians)
        let sin4l0 = sin(4.0 * l0.degreesToRadians)
        let sin2m = sin(2.0 * m.degreesToRadians)
        
        let etime = y * sin2l0 - 2.0 * e * sinm + 4.0 * e * y * sinm * cos2l0 - 0.5 * y * y * sin4l0 - 1.25 * e * e * sin2m
        
        return etime.radiansToDegrees * 4.0
    }
    
    private func obliquityCorrection(julianCentury: Double) -> Double {
        let e0 = meanObliquityOfEcliptic(julianCentury: julianCentury)
        let omega = 125.04 - 1934.136 * julianCentury
        return e0 + 0.00256 * cos(omega.degreesToRadians)
    }
    
    private func meanObliquityOfEcliptic(julianCentury: Double) -> Double {
        let seconds = 21.448 - julianCentury * (46.8150 + julianCentury * (0.00059 - julianCentury * 0.001813))
        return 23.0 + (26.0 + (seconds / 60.0)) / 60.0
    }
    
    private func sunDeclination(julianDay: Double) -> Double {
        let jc = julianCentury(julianDay: julianDay)
        let e = obliquityCorrection(julianCentury: jc)
        let lambda = sunApparentLongitude(julianCentury: jc)
        
        let sint = sin(e.degreesToRadians) * sin(lambda.degreesToRadians)
        let theta = asin(sint)
        return theta.radiansToDegrees
    }
    
    private func sunApparentLongitude(julianCentury: Double) -> Double {
        let o = sunTrueLongitude(julianCentury: julianCentury)
        let omega = 125.04 - 1934.136 * julianCentury
        return o - 0.00569 - 0.00478 * sin(omega.degreesToRadians)
    }
    
    private func sunTrueLongitude(julianCentury: Double) -> Double {
        let l0 = geometricMeanLongitudeSun(julianCentury: julianCentury)
        let c = sunEquationOfCenter(julianCentury: julianCentury)
        return l0 + c
    }
    
    private func sunEquationOfCenter(julianCentury: Double) -> Double {
        let m = geometricMeanAnomalySun(julianCentury: julianCentury)
        let mrad = m.degreesToRadians
        let sinm = sin(mrad)
        let sin2m = sin(mrad * 2.0)
        let sin3m = sin(mrad * 3.0)
        
        let c = sinm * (1.914602 - julianCentury * (0.004817 + 0.000014 * julianCentury)) +
                sin2m * (0.019993 - 0.000101 * julianCentury) +
                sin3m * 0.000289
        return c
    }
    
    private func calculateSolarEvent(angle: Double, rising: Bool) -> Date? {
        guard let jd = julianDay else { return nil }
        
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        let declination = sunDeclination(julianDay: jd)
        let hourAngle = calculateHourAngle(latitude: lat, declination: declination, angle: angle)
        
        guard !hourAngle.isNaN else { return nil }
        
        let tz = TimeZone.current.secondsFromGMT(for: date)
        let eqTime = equationOfTime(julianDay: jd)
        
        var timeOffset: Double
        if rising {
            timeOffset = 720.0 - (4.0 * lon) - (4.0 * hourAngle) - eqTime
        } else {
            timeOffset = 720.0 - (4.0 * lon) + (4.0 * hourAngle) - eqTime
        }
        
        let timeLocal = timeOffset + Double(tz) / 60.0
        
        let hours = Int(timeLocal / 60.0)
        let minutes = Int(timeLocal.truncatingRemainder(dividingBy: 60.0))
        let seconds = Int((timeLocal * 60.0).truncatingRemainder(dividingBy: 60.0))
        
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        components.hour = hours
        components.minute = minutes
        components.second = seconds
        components.timeZone = TimeZone.current
        
        return calendar.date(from: components)
    }
    
    private func calculateHourAngle(latitude: Double, declination: Double, angle: Double) -> Double {
        let latRad = latitude.degreesToRadians
        let decRad = declination.degreesToRadians
        let angleRad = angle.degreesToRadians
        
        let cosH = (cos(angleRad) / (cos(latRad) * cos(decRad))) - tan(latRad) * tan(decRad)
        
        guard cosH >= -1.0 && cosH <= 1.0 else { return .nan }
        
        return acos(cosH).radiansToDegrees
    }
}

// MARK: - Helper Extensions

private extension Double {
    var degreesToRadians: Double { self * .pi / 180.0 }
    var radiansToDegrees: Double { self * 180.0 / .pi }
}
