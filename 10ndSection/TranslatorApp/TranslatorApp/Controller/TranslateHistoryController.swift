//
//  TranslateHistoryController.swift
//  TranslatorApp
//
//  Created by Sabir Myrzaev on 18/3/22.
//

import UIKit

class TranslateHistoryController: UITableViewController {
    
    // MARK: - Properties
    var translators = Translator.translatorList
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "iTranslator"
        tableView.register(TranslateHistoryCell.self,
                           forCellReuseIdentifier: TranslateHistoryCell.identifier)
        view.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)

        tableView.rowHeight = 150
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return translators.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TranslateHistoryCell.identifier,
                                                       for: indexPath) as? TranslateHistoryCell
        else {
            return UITableViewCell()
        }
        
        cell.configure(input: translators[indexPath.row].inputWord,
                       output: translators[indexPath.row].outputWord,
                       languages: translators[indexPath.row].checkLanguage)
        cell.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
