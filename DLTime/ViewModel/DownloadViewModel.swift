//
//  DownloadViewModel.swift
//  DLTime
//
//  Created by KaayZenn on 16/11/2023.
//

import Foundation
import SwiftData
import SwiftUI

class DownloadViewModel: ObservableObject {
    static let shared = DownloadViewModel()
    let container: ModelContainer
    let context: ModelContext
    
    @Published var downloads = [Download]()
    
    @Published var title: String = ""
    @Published var speed: Double = 0.0
    @Published var size: Double = 0.0
    @Published var variation: Double = 0.0
    
    @Published var errorMessageSpeed: String = ""
    @Published var errorMessageSize: String = ""
    
    @Published var downloadCreateWithSuccess: Bool = false
    
    init() {
        do {
            container = try ModelContainer(for: Download.self)
            context = ModelContext(container)
        } catch {
            fatalError("Failed to create ModelContainer for Download.")
        }
        fetchData { _ in }
    }
    
    func fetchData(completion: @escaping (Bool) -> Void) {
        do {
            let descriptor = FetchDescriptor<Download>(sortBy: [SortDescriptor(\.date)])
            downloads = try context.fetch(descriptor)
            completion(true)
        } catch {
            print("Fetch failed")
            completion(false)
        }
    }
}

extension DownloadViewModel {
    
    func createDownload() {
        if speed != 0 && size != 0 {
            let download = Download(
                title: title,
                speed: speed,
                size: size,
                variation: variation,
                date: Date()
            )
            
            context.insert(download)
            
            fetchData { result in
                if result { withAnimation { self.downloadCreateWithSuccess = true } }
            }
        } else {
            if speed == 0 { withAnimation { errorMessageSpeed = "You must specify the download speed" } }
            if size == 0 { withAnimation { errorMessageSize = "You must indicate the amount to be downloaded" } }
            withAnimation { downloadCreateWithSuccess = false }
        }
    } // End func
    
    func resetData() {
        withAnimation {
            title = ""
            speed = 0
            size = 0
            variation = 0
            downloadCreateWithSuccess = false
        }
    }
    
}
