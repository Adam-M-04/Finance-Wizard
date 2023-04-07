import SwiftUI

struct ContentView: View {
    @State var currentPageIndex: Int = 0
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    GradientBackground()
                        .ignoresSafeArea()
                    
                    TabView {
                        Homepage()
                        Stats()
                        Saving()
                        Investing()
                    }
                    .foregroundColor(.white)
                    .tabViewStyle(.page)
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .padding(.bottom, -5)
                }
            }
        } else {
            Text("iOS 15 or below not supported :(")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
