//
//  ScannerView.swift
//  IDScanner
//
//  Created by Kovalev Gleb on 18.09.2024.
//

import SwiftUI
import VisionKit
import AVFoundation

struct CameraScannerViewController: UIViewControllerRepresentable {
    
    @Binding var startScanning: Bool
    @Binding var scanResult: String
    @Binding var aamvaData: AAMVAData
    @Binding var age: Int?
    @Binding var isExpired: Bool
    @Binding var isError: Bool
    @Binding var isFlashOn: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let recognizedDataTypes: Set<DataScannerViewController.RecognizedDataType> = [.barcode()]
        let scannerViewController = DataScannerViewController(recognizedDataTypes: recognizedDataTypes,
                                                              qualityLevel: .accurate,
                                                              recognizesMultipleItems: false,
                                                              isHighFrameRateTrackingEnabled: false,
                                                              isHighlightingEnabled: true)
        scannerViewController.delegate = context.coordinator
        
        scannerViewController.view.frame = CGRect(x: 50, y: 200, width: 300, height: 100)
        return scannerViewController
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        if startScanning {
            try? uiViewController.startScanning()
        } else {
            uiViewController.stopScanning()
        }
        
        // Включение/выключение вспышки в основном потоке
        DispatchQueue.main.async {
            if let device = AVCaptureDevice.default(for: .video), device.hasTorch {
                do {
                    try device.lockForConfiguration()
                    device.torchMode = isFlashOn ? .on : .off
                    device.unlockForConfiguration()
                } catch {
                    print("Не удалось настроить вспышку: \(error)")
                }
            }
        }
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: CameraScannerViewController
        
        init(_ parent: CameraScannerViewController) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
            case .barcode(let barcode):
                if let qrCodeValue = barcode.payloadStringValue {
                    DispatchQueue.main.async {
                        self.parent.scanResult = qrCodeValue
                        self.parent.isError = false
                        self.parent.aamvaData = parseAAMVAData(qrCodeValue)
                        self.parent.age = calculateAge(from: self.parent.aamvaData.birthDate)
                        self.parent.isExpired = isDocumentExpired(expirationDate: self.parent.aamvaData.expirationDate)
                        CoreDataManager.shared.createModel(aamvaData: self.parent.aamvaData)
                    }
                }
            default:
                DispatchQueue.main.async {
                    self.parent.isError = true
                }
            }
        }
    }
}
