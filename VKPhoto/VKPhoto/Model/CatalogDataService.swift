//
//  CatalogDataService.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 05.04.2022.
//

import Foundation

class CatalogDataService {
    
    //MARK: - data
    
    typealias DataChangedListener = () -> Void
    
    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(storeFileName)
    static let shared = CatalogDataService()
    
    private var dataChangedListeners = [DataChangedListener]()
    private static let storeFileName = "catalog.data"
    private(set) var data = ImageItemRepo(items: [])
    
    //MARK: - internal functions
    
    func appendItem(_ item: ImageItem) {
        data.items.append(item)
        notifyDataChangedListeners()
    }
    
    func removeItem(byIndex index: Int) {
        if data.items.indices.contains(index) {
            data.items.remove(at: index)
            notifyDataChangedListeners()
        }
    }
    
    func changeFilter( byIndex index: Int, next: Bool) {
        if next {
            if data.items.indices.contains(index) {
     //           data.items[index].filter = FilterManager.instance.getNextFilter(currentName: data.items[index].filter)
                notifyDataChangedListeners()
            }
        } else {
            if data.items.indices.contains(index) {
       //         data.items[index].filter = FilterManager.instance.getPreviosFilter(currentName: data.items[index].filter)
                notifyDataChangedListeners()
            }
        }
    }
    
    func updateDataAfterChangeRowNumber() {
        notifyDataChangedListeners()
    }
    
    func addDataChangedListener(_ listener: @escaping DataChangedListener) {
        dataChangedListeners.append(listener)
    }
    
    func save() {
        do {
            guard let url = url else { return }
            let dataForJson = data
            let encoder = JSONEncoder()
            let data = try encoder.encode(dataForJson)
            try data.write(to: url, options: [])
        } catch {
            print( "ERROR")
        }
    }
    
    func load() {
        do {
            guard let url = url else { return }
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let container = try decoder.decode(ImageItemRepo.self, from: jsonData)
            self.data = container
        } catch {
            print("ERROR")
            return
        }
    }
    
    func notifyDataChangedListeners() {
        DispatchQueue.main.async {
            self.dataChangedListeners.forEach { $0() }
        }
    }
    //MARK: - private functions
    
    private init() {}
}

