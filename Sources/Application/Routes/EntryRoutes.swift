//
//  File.swift
//  
//
//  Created by Felipe Mesquita on 21/04/20.
//

import Foundation
import LoggerAPI
import KituraContracts

func initializeEntryRoutes(app: App) {
    app.router.post   ("/entries", handler: addEntry)
    app.router.get    ("/entries", handler: getEntries)
    app.router.delete ("/entries", handler: deleteEntry)
    app.router.put    ("/entries", handler: modifyEntry)
    app.router.get    ("/entries", handler: getOneEntry)
}

func addEntry(entry:NoteEntry, completion:
    @escaping(NoteEntry?,RequestError?) -> Void) {
    var storeEntry = entry
    storeEntry.id = UUID().uuidString
    storeEntry.save(completion)
}

func getEntries(params:NoteEntryParams?,completion:
    @escaping([NoteEntry]?,RequestError?) -> Void) -> Void {
    NoteEntry.findAll(matching:params, completion)
}

func deleteEntry(id:String, completion:@escaping(RequestError?)->Void) {
    NoteEntry.delete(id: id, completion)
}

func modifyEntry(id:String,entry:NoteEntry,completion: @escaping(NoteEntry?,RequestError?) -> Void) {
    entry.update(id: id, completion)
}

func getOneEntry(id:String,completion: @escaping(NoteEntry?,RequestError?) -> Void) {
    NoteEntry.find(id:id, completion)
}
