//
//  PdfViewController.swift
//  HackerBooks
//
//  Created by Daniel Ruiz on 05/02/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import UIKit

class PdfViewController: UIViewController {
    
    //MARK: - Class Properties
    
    static let PdfMimetype: String = "application/pdf"
    static let DefaultPdfUrl: URL = Bundle.main.url(forResource: "default_pdf", withExtension: "pdf")!
    
    
    //MARK: - Properties
    
    var pdfData: AsyncData
    
    @IBOutlet weak var browser: UIWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    //MARK: - Initialization
    
    init(pdfUrl: URL) {
        pdfData = AsyncData(url: pdfUrl, defaultData: try! Data(contentsOf: PdfViewController.DefaultPdfUrl))
        super.init(nibName: nil, bundle: nil)
        
        pdfData.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribe()
        requestPdf()
        startSpinner()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribe()
    }
    
    //MARK: - Request Handling
    
    func requestPdf() {
        browser.load(pdfData.data, mimeType: PdfViewController.PdfMimetype, textEncodingName: "", baseURL: Bundle.main.bundleURL)
    }
    
    //MARK: - Spinner Handling
    
    func startSpinner() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func stopSpinner() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    
    //MARK: - AsyncData Handling
    
    func syncPdfData(pdfUrl: URL) {
        pdfData = AsyncData(url: pdfUrl, defaultData: try! Data(contentsOf: PdfViewController.DefaultPdfUrl))
        pdfData.delegate = self
        requestPdf()
    }

}

//MARK: - AsyncData Delegate

extension PdfViewController: AsyncDataDelegate {
    func asyncData(_ sender: AsyncData, didEndLoadingFrom url: URL) {
        requestPdf()
        stopSpinner()
    }
}

//MARK: - Notifications

extension PdfViewController {
    func subscribe() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: LibraryViewController.NotificationName, object: nil, queue: OperationQueue.main, using: { self.bookDidChange($0) })
    }
    
    func unsubscribe() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    func bookDidChange(_ notification: Notification) {
        let newBook = notification.userInfo?[LibraryViewController.BookKey] as! Book
        syncPdfData(pdfUrl: newBook.pdfUrl)
    }
}
