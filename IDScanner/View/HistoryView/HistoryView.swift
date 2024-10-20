//
//  HistoryView.swift
//  IDScanner
//
//  Created by Kovalev Gleb on 30.09.2024.
//

import SwiftUI

struct HistoryView: View {
    @FetchRequest(
        entity: DriverIDHistory.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \DriverIDHistory.date, ascending: false)]
    ) var history: FetchedResults<DriverIDHistory>
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack {
                white.ignoresSafeArea()
                
                List {
                    ForEach(groupedByDate(), id: \.key) { date, records in
                        Section(header: Text(formattedDate(date))
                                    .font(.caption)
                                    .foregroundColor(greyText)) {
                            ForEach(records, id: \.self) { record in
                                HistoryRow(record: record)
                                    .listRowSeparator(.hidden)
                            }
                        }
                        .headerProminence(.increased)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Text("Scan history")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(blueText)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: 
                            {
                        self.presentationMode.wrappedValue.dismiss()
                    })
                    {
                        Image(systemName: "xmark")
                            .foregroundStyle(blueButton)
                            .font(.system(size: 17))
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
    
    private func groupedByDate() -> [(key: Date, value: [DriverIDHistory])] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: history) { (record: DriverIDHistory) -> Date in
            return calendar.startOfDay(for: record.date ?? Date())
        }
        return grouped.sorted { $0.key > $1.key }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else if let daysAgo = calendar.date(byAdding: .day, value: -3, to: Date()), calendar.isDate(date, inSameDayAs: daysAgo) {
            return "3 days ago"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return dateFormatter.string(from: date)
        }
    }
}

struct HistoryRow: View {
    let record: DriverIDHistory
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("NAME")
                    .font(.caption)
                    .foregroundColor(.white)
                    .opacity(0.5)
                Text("\(record.firstName?.localizedUppercase.prefix(1) ?? ""). \(record.lastName ?? "")")
                    .font(.callout)
                    .foregroundColor(.white)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                if let birthDate = record.birthDate {
                    Text("AGE")
                        .font(.caption)
                        .foregroundColor(.white)
                        .opacity(0.5)
                    Text("\(calculateAge(from: birthDate) ?? 0)")
                        .font(.callout)
                        .foregroundColor(.white)
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.white)
                .font(.system(size: 17.88))
        }
        .padding(.horizontal, 16.5)
        .background {
            if let expirationDate = record.expirationDate {
                RoundedRectangle(cornerRadius: 20) .foregroundStyle(isDocumentExpired(expirationDate: expirationDate) ? redBad : greenApproval)
                    .frame(height: 68)
            } else {
                RoundedRectangle(cornerRadius: 12) .foregroundStyle(redBad)
                    .frame(height: 68)
            }
        }
        .shadow(radius: 3)
        .frame(height: 68)
    }
}

#Preview {
    HistoryView()
}
