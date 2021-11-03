//
//  NewsTableViewController.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 30.10.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {

    private let networkRequester = Network()
    private var news: [VKNew] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var nextListVKNewsID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(
            HeaderNewsView.self,
            forHeaderFooterViewReuseIdentifier: "headerView")
        tableView.register(
            UINib(nibName: "TextNewsCell", bundle: nil),
            forCellReuseIdentifier: "textCell")
        tableView.register(
            UINib(nibName: "PhotosNewsCell", bundle: nil),
            forCellReuseIdentifier: "photosCell")
        tableView.register(
            UINib(nibName: "DocsNewsCell", bundle: nil),
            forCellReuseIdentifier: "docsCell")
        tableView.register(
            FooterNewsView.self,
            forHeaderFooterViewReuseIdentifier: "footerView")
        
        fetchNews()

    }
//MARK: FetchNews
    private func fetchNews(nextListVKNewsID: String = "\"\"") {
        networkRequester.sendRequest(
            endpoint: VKNews.init(),
            requestType: "newsfeed.getRecommended",
            nextListVKNewsID: nextListVKNewsID) {
            [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let result):
                guard let news = result?.news(),
                      let nextListVKNewsID = result?.nextFrom
                else {return}
                self.news += news
                self.nextListVKNewsID = nextListVKNewsID
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: TableView

    override func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news[section].returnCellsCounter().count
    }
    

    
    //MARK: Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView") as! HeaderNewsView
        view.configure(new: news[section])
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    //MARK: Footer
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footerView") as! FooterNewsView
        view.configure(new: news[section])
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    
//    плохо работает
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
//            if indexPath == lastVisibleIndexPath {
//                fetchNews(nextListVKNewsID: nextListVKNewsID)
//            }
//        }
//    }
    
    //MARK: Cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let new = news[indexPath.section]
        switch new.returnCellsCounter()[indexPath.row].0{
        case .text:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as? TextNewsCell else {return UITableViewCell()}
            cell.configure(new: new)
            return cell
        case .photos:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "photosCell", for: indexPath) as? PhotosNewsCell else {return UITableViewCell()}
            cell.configure(new: new)
            cell.layoutIfNeeded()
            return cell
        case .docs:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "docsCell", for: indexPath) as? DocsNewsCell else {return UITableViewCell()}
            cell.configure(new: new, row: indexPath.row)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if news[indexPath.section].returnCellsCounter()[indexPath.row].0 == .photos {
            return 400.0 }
        else {
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(
                at: indexPath,
                animated: true)
        }
        guard let _ = news[indexPath.section].isShortText else { return }
        news[indexPath.section].isShortText?.toggle()
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
}
