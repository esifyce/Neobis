//
//  TranslateHistoryController.swift
//  TranslatorApp
//
//  Created by Sabir Myrzaev on 18/3/22.
//

import UIKit
import RealmSwift

class TranslateHistoryController: UITableViewController {
    
    // MARK: - Properties
    var translators = Translator.wordsList
    private var realm: Realm?
    private var words: Results<Translator>!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            self.realm = try Realm()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        words = realm?.objects(Translator.self)
        
        getData(translators)
        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        title = "iTranslator"
        tableView.register(TranslateHistoryCell.self,
                           forCellReuseIdentifier: TranslateHistoryCell.identifier)
        
        view.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)

        tableView.rowHeight = 150
        tableView.separatorStyle = .none
    }
    
    private func showError(_ error: Error?) {
        if let error = error {
            print("DEBUG: \(String(describing: error.localizedDescription))")
            return
        }
    }
    
    private func getData(_ data: [Translator]) {
        
        realm?.beginWrite()
        realm?.add((data.compactMap { $0 }))
        
        try! realm?.commitWrite()
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return words.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TranslateHistoryCell.identifier,
                                                       for: indexPath) as? TranslateHistoryCell
        else {
            return UITableViewCell()
        }
        
        cell.configure(input: words[indexPath.row].inputWord,
                       output: words[indexPath.row].outputWord,
                       languages: words[indexPath.row].checkLanguage)
        cell.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

