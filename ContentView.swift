import SwiftUI

struct ContentView: View {
    @State var currentPageIndex: Int = 1
    @State var pagesOpacity: [Double] = [1, 0, 0, 0]
    @State var timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    GradientBackground()
                        .ignoresSafeArea()
                    
                    TabView (selection: $currentPageIndex) {
                        Homepage(currentTab: $currentPageIndex, timer: $timer, bgOpacity: pagesOpacity[0]).tag(1)
                        Stats(bgOpacity: pagesOpacity[1]).tag(2)
                        Saving(bgOpacity: pagesOpacity[2]).tag(3)
                        Investing(bgOpacity: pagesOpacity[3]).tag(4)
                    }
                    .preferredColorScheme(.dark)
                    .foregroundColor(.white)
                    .tabViewStyle(.page)
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .padding(.bottom, -5)
                    .onChange(of: currentPageIndex) { newVal in
                        withAnimation(.easeInOut(duration: 0.4)) {
                            for i in 0...3 {
                                pagesOpacity[i] = 0
                            }
                            pagesOpacity[newVal - 1] = 1
                        }
                    }
                }
            }
            .colorScheme(.light)
        } else {
            Text("iOS 15 or lower not supported 🙁")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
