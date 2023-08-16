//
//  ContentView.swift
//  Temperature Converter
//
//  Created by Lyu Hiroyama on 2023/08/15.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputvalue: Double = 0
    @State private var selectedUnits = 0
    @State private var inputTypeSelected: Dimension = UnitLength.meters
    @State private var outputTypeSelected: Dimension = UnitLength.yards
    @FocusState private var inputIsFocused: Bool
    
    let conversions = ["Distance", "Mass","Temperature", "Time"]
    let unitTypes = [
        [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
    ]

    let formatter: MeasurementFormatter
    
    var outputTemp: String {

        let inputTemp = Measurement(value: inputvalue, unit: inputTypeSelected)
        let outputTemp = inputTemp.converted(to: outputTypeSelected)
        
        return formatter.string(from: outputTemp)
    }

    var body: some View {

        NavigationView {
            Form {
                
                Section {
                    TextField("0", value: $inputvalue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Amount to convert:")
                }
                
                Section {
                    
                    Picker("Conversion", selection: $selectedUnits) {
                        ForEach(0..<conversions.count) {
                            Text(conversions[$0])
                        }
                    }
                    Picker("Convert from", selection: $inputTypeSelected) {
                        ForEach(unitTypes[selectedUnits], id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                    
                    Picker("Convert to", selection: $outputTypeSelected) {
                        ForEach(unitTypes[selectedUnits], id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                    
                }
                
                
                Section {
                    Text(outputTemp)
                } header: {
                    Text("Output:")
                }
                
                
            }
            .navigationBarTitle("Unit Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        inputIsFocused = false
                    }
                }
            }
            .onChange(of: selectedUnits) { newSelection in
                let units = unitTypes[newSelection]
                inputTypeSelected = units[0]
                outputTypeSelected = units[1]
            }

        }
        
    }
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
