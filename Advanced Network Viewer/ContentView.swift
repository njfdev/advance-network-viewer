//
//  ContentView.swift
//  Advanced Network Viewer
//
//  Created by Nicholas Fasching on 1/7/23.
//

import SwiftUI
import Network

struct ContentView: View {
    init() {
        let monitor = NWPathMonitor()

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("The device is connected to the network.")
                
                // Get the list of available interfaces
                let interfaces = path.availableInterfaces
                for interface in interfaces {
                    // Print the interface type (e.g. "Wi-Fi", "Ethernet", etc.)
                    print(interface.type)
                    
                    // Print the interface name (e.g. "en0", "en1", etc.)
                    print(interface.name)
                }
            }
            else {
                print("The device is not connected to the network.")
            }
        }

        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)

    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
