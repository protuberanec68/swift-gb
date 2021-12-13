//
//  NewsTableViewController.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 30.10.2021.
//

import UIKit

protocol TableDelegate: AnyObject {
    func reloadTable(cell: UITableViewCell)
}

class NewsTableViewController: UITableViewController {

    private let networkRequester = Network()
    private var news: [VKNew] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private var nextListVKNewsID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        
        configureRefreshControl()
        
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
    
    private func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc
    private func refresh(){
        tableView.refreshControl?.beginRefreshing()
        self.news = []
        let queue = DispatchQueue(
            label: "refreshQueue",
            qos: .userInteractive)
        queue.sync {
            fetchNews(nextListVKNewsID: nextListVKNewsID)
        }
        queue.sync {
            self.tableView.refreshControl?.endRefreshing()
        }
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
                DispatchQueue.global(qos: .userInteractive).async {
                    guard let news = result?.news(),
                          let nextListVKNewsID = result?.nextFrom
                    else {return}
                    DispatchQueue.main.async {
                        if news.last?.date != self.news.last?.date {
                            self.news += news
                        }
                        self.nextListVKNewsID = nextListVKNewsID
                    }
                }
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == news.count - 2 {
                fetchNews(nextListVKNewsID: nextListVKNewsID)
        }
    }
    
    //MARK: Cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let new = news[indexPath.section]
        switch new.returnCellsCounter()[indexPath.row].0{
        case .text:
            guard let cell = tableView
                    .dequeueReusableCell(
                        withIdentifier: "textCell",
                        for: indexPath)
                    as? TextNewsCell else {return UITableViewCell()}
            cell.configure(new: new)
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        case .photos:
            guard let cell = tableView
                    .dequeueReusableCell(
                        withIdentifier: "photosCell",
                        for: indexPath)
                    as? PhotosNewsCell else {return UITableViewCell()}
            cell.configure(new: new)
            cell.selectionStyle = .none
            return cell
        case .docs:
            guard let cell = tableView
                    .dequeueReusableCell(
                        withIdentifier: "docsCell",
                        for: indexPath)
                    as? DocsNewsCell else {return UITableViewCell()}
            cell.configure(new: new, row: indexPath.row)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let new = news[indexPath.section]
        if new.returnCellsCounter()[indexPath.row].0 == .photos {
            let countPhotos = new.photos.count
            let correction = new.photos.first?.aspectRatio

            let halfCellHeight = UIScreen.main.bounds.width / 2
            if countPhotos % 2 == 0 {
                return (Double(countPhotos) * halfCellHeight * (correction ?? 1.0)) / 2
            } else {
                return ((Double(countPhotos) + 1) * halfCellHeight * (correction ?? 1.0) / 2) + halfCellHeight
            }
        } else {
            return UITableView.automaticDimension
        }
    }

    
    //MARK: Old show more/less text
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        defer {
//            tableView.deselectRow(
//                at: indexPath,
//                animated: true)
//        }
//        guard let _ = news[indexPath.section].isShortText else { return }
//        news[indexPath.section].isShortText?.toggle()
//        UIView.transition(with: tableView,
//                          duration: 0.35,
//                          options: .transitionCrossDissolve,
//                          animations: { self.tableView.reloadData() })
//    }
}


extension NewsTableViewController: TableDelegate {
    func reloadTable(cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        news[indexPath.section].isShortText?.toggle()
        
//MARK: не понимаю - почему такой код не работает корректно, обновляется очень криво, вся таблица прыгает и все съезжает когда пытаюсь обновить не первую ячейку:
//        tableView.reloadRows(at: [indexPath], with: .automatic)
//
        UIView.transition(with: tableView,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() })
    }
}
