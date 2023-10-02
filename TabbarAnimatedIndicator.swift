import SwiftUI

struct ContentView: View {
    var body: some View {

        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    // colors as Tabs...
    // use your own tabs here...
    var colors : [Color] = [.red,.blue,.pink,.purple]
    
    // offset...
    @State var offset: CGFloat = 0
    @State var currentInd: Int = 0
    
    var body: some View{
        
        // tabview has problem in ignoring top edge...
        // fix use scrollview...
        ScrollView(.init()){
            
            TabView(selection: $currentInd.animation()) {
                
                ForEach(colors.indices,id: \.self){index in
                    
                    colors[index]

//                    withAnimation(.spring(duration: 0.45, bounce: 0.25, blendDuration: 0.8)) {
//                        EmptyView()
//                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .overlay(
                animatedIndicator
                ,alignment: .bottom
            )
        }
        .ignoresSafeArea()
    }
    
    // getting Offset for Capsule Shape...
    
    func getOffset()->CGFloat {
        return CGFloat(currentInd) * 22
    }
    
    
        
    var animatedIndicator: some View {
        // Animated Indicators...
        HStack(spacing: 15){
            ForEach(colors.indices,id: \.self){index in
                Capsule()
                    .fill(currentInd < index ? Color.gray : Color.white)
                    .frame(width: currentInd == index ? 20 : 7, height: 7)
            }
        }
        // Smooth Sliding Effect...
        .overlay(
            Capsule()
                .fill(Color.white)
                .frame(width: 20, height: 7)
                .offset(x: getOffset())

            ,alignment: .leading
        )
        .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        .padding(.bottom,10)
    }
}

// extending View to get width...

extension View{
    
    func getWidth()->CGFloat{
        return UIScreen.main.bounds.width
    }
}
