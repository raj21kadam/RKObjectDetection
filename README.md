# RKObjectDetection
Detect object using Vision Kit

## Compatibility

> iOS 11 and above

> Vision framework requires an iOS 11 and above

##  Getting started


1. Create AVCaptureSession
```
let captureSession = AVCaptureSession()
captureSession.sessionPreset = .photo

guard let captureDevice = AVCaptureDevice.default(for: .video) else {return}
guard let captureInput = try? AVCaptureDeviceInput(device: captureDevice) else {return}
```

3. Add captureInput to AVCaptureSession and Run session

4. Now Add Camera usage description Privacy key in Info.plist


5. Add your **MlModel** into project and create object for the same.
```
let model: VNCoreMLModel = try! VNCoreMLModel(for: STYLABS_Face_CNN_v1().model)
```

6. Now create **VNCoreMLRequest** with your model and use **VNImageRequestHandler** to perform your coreMl request.(Look into captureOutput() method)


7. As a result you will get the array of **VNClassificationObservation**




## Version: 1.0


