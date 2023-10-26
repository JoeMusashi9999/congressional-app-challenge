import SwiftUI


struct ContentView: View {
    var body: some View {
        LandmarkList().frame(minWidth: 700, minHeight: 300)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ModelData())
    }
}

// Create a request handler.
let imageRequestHandler = VNImageRequestHandler(cgImage: image,orientation: orientation, options: [:])
lazy var rectangleDetectionRequest: VNDetectRectanglesRequest = {
    let rectDetectRequest = VNDetectRectanglesRequest(completionHandler: self.handleDetectedRectangles)
    // Customize & configure the request to detect only certain rectangles.
    rectDetectRequest.maximumObservations = 8 // Vision currently supports up to 16.
    rectDetectRequest.minimumConfidence = 0.6 // Be confident.
    rectDetectRequest.minimumAspectRatio = 0.3 // height / width
    return rectDetectRequest
}()
// Send the requests to the request handler.
DispatchQueue.global(qos: .userInitiated).async {
    do {
        try imageRequestHandler.perform(requests)
    } catch let error as NSError {
        print("Failed to perform image request: \(error)")
        self.presentAlert("Image Request Failed", error: error)
        return
    }
}
CATransaction.begin()
for observation in faces {
    let faceBox = boundingBox(forRegionOfInterest: observation.boundingBox, withinImageBounds: bounds)
    let faceLayer = shapeLayer(color: .yellow, frame: faceBox)
    
    // Add to pathLayer on top of image.
    pathLayer?.addSublayer(faceLayer)
}
CATransaction.commit()
