//
//  ContentView.swift
//  Temperature Converter
//
//  Created by Lyu Hiroyama on 2023/08/15.
//

import SwiftUI

struct ContentView: View {
    
    @State private var temp: Double = 0
    @State private var inputTypeSelected = UnitTemperature.fahrenheit
    @State private var outputTypeSelected = UnitTemperature.fahrenheit
    @FocusState private var tempIsFocused: Bool
    
    var units: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]

    let formatter: MeasurementFormatter
    
    var outputTemp: String {

        let inputTemp = Measurement(value: temp, unit: inputTypeSelected)
        let outputTemp = inputTemp.converted(to: outputTypeSelected)
        
        return formatter.string(from: outputTemp)
    }

    var body: some View {

        NavigationView {
            Form {
                
                Section {
                    
                    Picker("Select Type: ", selection: $inputTypeSelected) {
                        ForEach(units, id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }

                    
                    TextField("Yomama", value: $temp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($tempIsFocused)
                    
                } header: {
                    Text("Enter Inuput Temperature:")
                }
                
                
                Section {
                    
                    Picker("Select Type: ", selection: $outputTypeSelected) {
                        ForEach(units, id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }

                    
                } header: {
                    Text("Select output type:")
                }
                
                
                
                Section {
                    Text(outputTemp)
                } header: {
                    Text("Output:")
                }
                
                
            }
            .navigationBarTitle("Temperature Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        tempIsFocused = false
                    }
                }
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
