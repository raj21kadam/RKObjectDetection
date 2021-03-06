//
//  ViewController.swift
//  RKObjectDetection
//
//  Created by Raj on 15/09/17.
//  Copyright © 2017 Raj Kadam. All rights reserved.
//

import UIKit
import Vision
import AVFoundation
//import AVKit

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    var previewLayer:AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // set up the camera session
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {return}
        guard let captureInput = try? AVCaptureDeviceInput(device: captureDevice) else {return}
        
        captureSession.addInput(captureInput)
        captureSession.startRunning()
        
     previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer!)
        previewLayer!.frame = self.view.frame
        
        let captureDataOutput = AVCaptureVideoDataOutput()
        
        captureDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "video"))
        captureSession.addOutput(captureDataOutput)
        

    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        
        guard let myMLModel = try? VNCoreMLModel(for: Resnet50().model) else {return}
        
        let request = VNCoreMLRequest(model: myMLModel) { (finishedRequest, error) in
            
//            print(finishedRequest.results?.capacity)
            
            guard let results = finishedRequest.results as? [VNClassificationObservation] else {return}
            
            guard let firstObservation = results.first else {return}
            print("\(firstObservation.identifier)")
            print("\(firstObservation.confidence)")
        }
        
        
        
       
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

