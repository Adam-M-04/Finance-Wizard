import SwiftUI
import UIKit

struct ContentView: View {
    @State var currentPageIndex: Int = 0
    
    var body: some View {
        ZStack {
            if UIDevice.current.userInterfaceIdiom == .pad {
                RadialGradient(
                    gradient: Gradient(colors: [.blue, .black]),
                    center: .center,
                    startRadius: 5,
                    endRadius: 1000)
                    .ignoresSafeArea()
            } else {
                RadialGradient(
                    gradient: Gradient(colors: [.blue, .black]),
                    center: .center,
                    startRadius: 1,
                    endRadius: 650)
                    .ignoresSafeArea()
            }
            
            VStack {
                ScrollView {
                    switch currentPageIndex {
                        case 1:
                            Stats()
                        case 2:
                            Saving()
                        case 3:
                            Inflation()
                        default:
                            Homepage()
                    }
                }
                
                HStack {
                    Button("<") {
                        currentPageIndex -= 1
                    }
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .scaleEffect(1.4)
                    .padding()
                    
                    Button(">") {
                        currentPageIndex += 1
                    }
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .scaleEffect(1.4)
                    .padding()
                }
            }
            .foregroundColor(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
