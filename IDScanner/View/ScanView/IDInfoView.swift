//
//  IDInfoView.swift
//  IDScanner
//
//  Created by Kovalev Gleb on 30.09.2024.
//

import SwiftUI

struct IDInfoView: View {
    
    @Binding var isExpired: Bool
    @Binding var aamvaData: AAMVAData
    @Binding var age: Int?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 68)
                    .foregroundStyle(isExpired ? redBad : greenApproval)
                    .padding(.horizontal, 16)
                    .overlay {
                        HStack {
                            Spacer()
                            Text(isExpired ? "Expired ID" : "Active ID")
                                .foregroundColor(.white)
                                .font(.title2)
                            Spacer()
                        }
                    }
                
                VStack(alignment: .leading, spacing: 20) {
                    cellForInfo(firstText: "Document number:", secondText: "-")
                    
                    Divider()
                    
                    cellForInfo(firstText: "Full name:", secondText: "\(aamvaData.firstName.localizedUppercase.prefix(1)). \(aamvaData.lastName)")
                    
                    Divider()
                    
                    cellForInfo(firstText: "Gender:", secondText: aamvaData.gender == "1" ? "Male" : "Female")
                    
                    Divider()
                    
                    cellForInfo(firstText: "Age:", secondText: "\(age ?? 0)")
                    
                    Divider()
                    
                    cellForInfo(firstText: "Date of birth:", secondText: aamvaData.formatDate(aamvaData.birthDate))
                    
                    Divider()
                    
                    cellForInfo(firstText: "Expires:", secondText: aamvaData.formatDate(aamvaData.expirationDate))
                }
                .padding(.horizontal, 16)
                .font(.system(size: 18))
                
                Spacer()
            }
        }
    }
    
    func cellForInfo(firstText: String, secondText: String) -> some View {
        return HStack {
            VStack (alignment: .leading, content: {
                Text(firstText)
                    .foregroundStyle(blueText)
                    .opacity(0.5)
                    .font(.caption)
                Text(secondText)
                    .foregroundStyle(blueText)
                    .font(.callout)
                    .fontWeight(.medium)
            })
            Spacer()
        }
    }
}

struct IdInfoView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isExpired = true
        @State var aamva = AAMVAData(lastName: "Kovalev", firstName: "gleb", jurisdiction: "WA", birthDate: "09012004", expirationDate: "05202010", gender: "1")
        @State var age: Int? = 20
        IDInfoView(isExpired: $isExpired, aamvaData: $aamva, age: $age)
    }
}
