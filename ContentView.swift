import SwiftUI

struct ContentView: View {
    @State var currentPageIndex: Int = 1
    @State var timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    GradientBackground()
                        .ignoresSafeArea()
                    
                    TabView (selection: $currentPageIndex) {
                        Homepage(currentTab: $currentPageIndex, timer: $timer).tag(1)
                        Stats().tag(2)
                        Saving().tag(3)
                        Investing().tag(4)
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
