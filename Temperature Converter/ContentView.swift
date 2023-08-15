//
//  ContentView.swift
//  Temperature Converter
//
//  Created by Lyu Hiroyama on 2023/08/15.
//

import SwiftUI

struct ContentView: View {
    
    @State private var temp: Double = 0
    @State private var inputTypeSelected = "Farenheit"
    @State private var outputTypeSelected = "Farenheit"
    @FocusState private var tempIsFocused: Bool
    
    var tempTypes = ["Celcius", "Farenheit", "Kelvin"]
    
    var outputTemp: String {
        var inputToCelcius: Double
        var celciusToOutput: Double
        
        switch inputTypeSelected {
        case "Farenheit":
            inputToCelcius = (temp - 32) * (5/9)
        case "Kelvin":
            inputToCelcius = temp - 273.15
        default:
            inputToCelcius = temp
        }
        
        switch outputTypeSelected {
        case "Farenheit":
            celciusToOutput = (inputToCelcius * (9/5)) + 32
        case "Kelvin":
            celciusToOutput = inputToCelcius + 273.15
        default:
            celciusToOutput = inputToCelcius * 1
        }
        
        let outputValue = round(celciusToOutput * 100) / 100.0
        
        return "\(outputValue)  \(outputTypeSelected)"
        
    }

    var body: some View {

        NavigationView {
            Form {
                
                Section {
                    
                    Picker("Select Type: ", selection: $inputTypeSelected) {
                        ForEach(tempTypes, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Yomama", value: $temp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($tempIsFocused)
                    
                } header: {
                    Text("Enter Inuput Temperature:")
                }
                
                
                Section {
                    
                    Picker("Select Type: ", selection: $outputTypeSelected) {
                        ForEach(tempTypes, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(.segmented)
                    
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
