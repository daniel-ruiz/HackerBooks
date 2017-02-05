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
    
    
    //MARK: - Properties
    
    var pdfData: AsyncData
    
    @IBOutlet weak var browser: UIWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    //MARK: - Initialization
    
    init(pdfUrl: URL) {
        let defaultPdfUrl: URL = Bundle.main.url(forResource: "default_pdf", withExtension: "pdf")!
        pdfData = AsyncData(url: pdfUrl, defaultData: try! Data(contentsOf: defaultPdfUrl))
        super.init(nibName: nil, bundle: nil)
        
        pdfData.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestPdf()
        startSpinner()
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

}

//MARK: - AsyncData Delegate

extension PdfViewController: AsyncDataDelegate {
    func asyncData(_ sender: AsyncData, didEndLoadingFrom url: URL) {
        requestPdf()
        stopSpinner()
    }
}
