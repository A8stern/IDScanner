//
//  CameraScanner.swift
//  IDScanner
//
//  Created by Kovalev Gleb on 18.09.2024.
//

import SwiftUI

struct CameraScanner: View {
    @State private var showCameraScannerView = true
    @State private var scanResults: String = ""
    @State private var isError: Bool = false
    @State private var isFlashOn: Bool = false
    
    @State var aamvaData: AAMVAData = AAMVAData()
    @State private var age: Int? = nil
    @State private var isExpired: Bool = false
    
    @State private var showSheet: Bool = false
    @State private var showSettings: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    CameraScannerViewController(startScanning: $showCameraScannerView, scanResult: $scanResults, aamvaData: $aamvaData, age: $age, isExpired: $isExpired, isError: $isError, isFlashOn: $isFlashOn)
                        .onDisappear {
                            showCameraScannerView = false // Останавливаем сканер при уходе с экрана
                        }
                        .onAppear {
                            showCameraScannerView = true // Перезапускаем сканер при возвращении
                        }
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                NavigationLink(destination: HistoryView()) {
                                    Image(systemName: "clock.fill")
                                        .foregroundStyle(.white)
                                }
                            }
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    showSettings.toggle()
                                } label: {
                                    Image(systemName: "gear")
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        .interactiveDismissDisabled(true)
                        .ignoresSafeArea()
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        // Кнопка вспышки
                        Button(action: {
                            toggleFlash() // Асинхронно управляем вспышкой
                        }, label: {
                            Image(systemName: isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                                .font(.system(size: 30))
                                .foregroundColor(isFlashOn ? .yellow : .gray)
                                .padding()
                                .background(Circle().foregroundColor(.black).opacity(0.75))
                        })
                        .padding(.bottom, 50)
                        .padding(.trailing, 30)
                    }
                    if !isError && !scanResults.isEmpty {
                        Button(action: { showSheet.toggle() }, label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("NAME")
                                        .font(.caption)
                                        .opacity(0.5)
                                    Text("\(aamvaData.firstName.localizedUppercase.prefix(1)). \(aamvaData.lastName)")
                                        .font(.callout)
                                }
                                Spacer()
                                VStack(alignment: .leading, spacing: 5) {
                                    if let birthDate = age {
                                        Text("AGE")
                                            .font(.caption)
                                            .opacity(0.5)
                                        Text("\(birthDate)")
                                            .font(.callout)
                                    }
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 17.88))
                            }
                            .foregroundStyle(isExpired ? redOpacityText : greenOpacityText)
                            .padding(.horizontal, 16.5)
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(isExpired ? redOpacityBackground : greenOpacityBackground)
                                    .frame(height: 68)
                            }
                            .shadow(radius: 3)
                            .frame(height: 68)
                        })
                    }
                }
            }
        }
        .sheet(isPresented: $showSheet, content: {
            IDInfoView(isExpired: $isExpired, aamvaData: $aamvaData, age: $age)
                .padding()
                .background {
                    LinearGradient(colors: [white, whiteDark], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
                        .ignoresSafeArea()
                }
                .presentationDetents([.medium, .large])
        })
        .sheet(isPresented: $showSettings, content: {
            SettingsView()
        })
    }

    private func toggleFlash() {
        DispatchQueue.main.async {
            isFlashOn.toggle()
        }
    }
}
