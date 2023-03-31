import SwiftUI

struct ContentView: View {
    @State var currentPageIndex: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [.blue, .black]),
                center: .center,
                startRadius: 2,
                endRadius: 650)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                switch currentPageIndex {
                case 1:
                    Stats()
                case 2:
                    Inflation()
                default:
                    Homepage()
                }
                
                Spacer()
                
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
