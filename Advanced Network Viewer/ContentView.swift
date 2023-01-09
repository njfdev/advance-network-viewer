//
//  ContentView.swift
//  Advanced Network Viewer
//
//  Created by Nicholas Fasching on 1/7/23.
//

import SwiftUI
import Network

extension NWInterface.InterfaceType {
    var stringRepresentation: String {
            switch self {
            case .cellular: return "Cellular"
            case .wiredEthernet: return "Ethernet"
            case .wifi: return "Wi-Fi"
            case .loopback: return "Loopback"
            default: return "Other"
        }
    }
}

class NetworkMonitor: ObservableObject {
    @Published var networkInterfaces: [NWInterface] = []

    init() {
        let monitor = NWPathMonitor()

        monitor.pathUpdateHandler = { [self] (path) in
            if path.status == .satisfied {
                // Get the list of available interfaces
                let interfaces = path.availableInterfaces
                
                DispatchQueue.main.async {
                    self.networkInterfaces = interfaces
                    print(interfaces)
                }
            }
        }
        
        monitor.start(queue: DispatchQueue(label: "Monitor"))
    }
}

struct ContentView: View {
    @ObservedObject private var networkMonitor = NetworkMonitor()
    
    var body: some View {
        VStack {
            ForEach(self.networkMonitor.networkInterfaces, id: \.name) { interface in
                HStack {
                    switch interface.type {
                    case .cellular: Image(systemName: "cellularbars")
                    case .wifi: Image(systemName: "wifi")
                    case .wiredEthernet: Image(systemName: "network")
                    default: Image(systemName: "questionmark.circle")
                    }
                    Text(interface.name)
                }
            }
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
