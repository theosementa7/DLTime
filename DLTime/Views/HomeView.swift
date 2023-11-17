//
//  HomeView.swift
//  DLTime
//
//  Created by KaayZenn on 13/11/2023.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    // Custom Type
    @ObservedObject var downloadViewModel: DownloadViewModel = DownloadViewModel.shared
    
    // Environement
    
    // String Variables
    
    // Number Variables
    
    // Bool Variables
    
    // Computed Variables
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                if downloadViewModel.downloadCreateWithSuccess {
                    VStack {
                        if let lastDownload = downloadViewModel.downloads.sorted(by: { $0.date < $1.date }).last {
                            VStack(spacing: 16) {
                                Spacer()
                                if lastDownload.variation == 0 {
                                    VStack {
                                        Text("Download time for")
                                            .font(.system(size: 24, weight: .semibold))
                                        Text(lastDownload.title)
                                            .font(.system(size: 28, weight: .black))
                                            .foregroundStyle(Color.greenApp)
                                    }
                                    HStack(alignment: .bottom, spacing: 2) {
                                        ForEach(formattedParts(text: TimeManager().formattedDownloadTime(timeInSeconds: lastDownload.normalTimeOfDownloadInSeconds)), id: \.self) { part in
                                            Text(part)
                                                .font(part.isDigit ? .system(size: 48, weight: .black) : .system(size: 36, weight: .bold))
                                                .foregroundColor(part.isDigit ? .greenApp : .colorLabel)
                                                .offset(x: part.isDigit ? 0 : -2, y: part.isDigit ? 0 : -4)
                                        }
                                    }
                                } else {
                                    VStack {
                                        VStack {
                                            Text("Download time for")
                                                .font(.system(size: 24, weight: .semibold))
                                            Text(lastDownload.title)
                                                .font(.system(size: 28, weight: .black))
                                                .foregroundStyle(Color.greenApp)
                                        }
                                        
                                        
                                        VStack {
                                            Text("Shortest")
                                            HStack(alignment: .bottom, spacing: 2) {
                                                ForEach(formattedParts(text: TimeManager().formattedDownloadTime(timeInSeconds: lastDownload.shortestTimeOfDownloadInSeconds)), id: \.self) { part in
                                                    Text(part)
                                                        .font(part.isDigit ? .system(size: 48, weight: .black) : .system(size: 36, weight: .bold))
                                                        .foregroundColor(part.isDigit ? .greenApp : .colorLabel)
                                                        .offset(x: part.isDigit ? 0 : -2, y: part.isDigit ? 0 : -4)
                                                }
                                            }
                                        }
                                        
                                        VStack {
                                            Text("Normal")
                                            HStack(alignment: .bottom, spacing: 2) {
                                                ForEach(formattedParts(text: TimeManager().formattedDownloadTime(timeInSeconds: lastDownload.normalTimeOfDownloadInSeconds)), id: \.self) { part in
                                                    Text(part)
                                                        .font(part.isDigit ? .system(size: 48, weight: .black) : .system(size: 36, weight: .bold))
                                                        .foregroundColor(part.isDigit ? .greenApp : .colorLabel)
                                                        .offset(x: part.isDigit ? 0 : -2, y: part.isDigit ? 0 : -4)
                                                }
                                            }
                                        }
                                        
                                        VStack {
                                            Text("Longest")
                                            HStack(alignment: .bottom, spacing: 2) {
                                                ForEach(formattedParts(text: TimeManager().formattedDownloadTime(timeInSeconds: lastDownload.longestTimeOfDownloadInSeconds)), id: \.self) { part in
                                                    Text(part)
                                                        .font(part.isDigit ? .system(size: 48, weight: .black) : .system(size: 36, weight: .bold))
                                                        .foregroundColor(part.isDigit ? .greenApp : .colorLabel)
                                                        .offset(x: part.isDigit ? 0 : -2, y: part.isDigit ? 0 : -4)
                                                }
                                            }
                                        }
                                    }
                                }
                                Spacer()
                                Spacer()
                                
                                VStack {
                                    CustomPlainButton(
                                        icon: "",
                                        text: "Continue",
                                        action: { downloadViewModel.resetData() },
                                        color: Color.greenApp)
                                }
                                .padding(.horizontal)
                                
                            }
                        } else {
                            Text("No download found")
                            Text(downloadViewModel.downloads.count.formatted())
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack {
                        Spacer()
                        
                        CustomStringTextField(
                            title: "Title",
                            placeholder: "Call of duty: MW3",
                            value: $downloadViewModel.title
                        )
                        
                        CustomDoubleTextField(
                            title: "Speed",
                            placeholder: "12.2",
                            value: $downloadViewModel.speed,
                            unit: "Mo/s"
                        )
                        
                        CustomDoubleTextField(
                            title: "To download",
                            placeholder: "95.4",
                            value: $downloadViewModel.size,
                            unit: "Go"
                        )
                        
                        CustomDoubleTextField(
                            title: "Variation",
                            placeholder: "0.2",
                            value: $downloadViewModel.variation,
                            unit: "Mo"
                        )
                        
                        Spacer()
                        Spacer()
                        
                        CustomPlainButton(
                            icon: "",
                            text: "Calculate",
                            action: { downloadViewModel.createDownload() },
                            color: Color.greenApp)
                        .padding(.horizontal)
                    }
                }
            }
            .background(Color.background.ignoresSafeArea(edges: .all))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: { }, label: {
                        Image(systemName: "rectangle.stack.fill")
                            .foregroundStyle(.colorLabel)
                    })
                }
                
                ToolbarItem(placement: .principal) {
                    Text("DLT")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.greenApp)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: { }, label: {
                        Image(systemName: "chart.xyaxis.line")
                            .foregroundStyle(.colorLabel)
                    })
                }
            } // End toolbar
        } // End NavigationStack
    } // End body
    
    func formattedParts(text: String) -> [String] {
        var parts: [String] = []
        var currentPart: String = ""
        
        for character in text {
            if String(character).isDigit {
                if !currentPart.isEmpty && !currentPart.isDigit {
                    parts.append(currentPart)
                    currentPart = ""
                }
            } else {
                if !currentPart.isEmpty && currentPart.isDigit {
                    parts.append(currentPart)
                    currentPart = ""
                }
            }
            currentPart.append(character)
        }
        
        if !currentPart.isEmpty {
            parts.append(currentPart)
        }
        
        return parts
    }

    
} // End struct

//MARK: - Preview
#Preview {
    HomeView()
}
