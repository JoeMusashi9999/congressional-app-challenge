import SwiftUI


struct ContentView: View {
    var body: some View {
        LandmarkList()
            .frame(minWidth: 700, minHeight: 300)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}

// Create a request handler.
let imageRequestHandler = VNImageRequestHandler(cgImage: image,orientation: orientation, options: [:])