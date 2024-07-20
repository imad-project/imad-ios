//
//  PDFUIView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/21/24.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {

    let pdfDocument: PDFDocument

    init(showing pdfDoc: PDFDocument) {
        self.pdfDocument = pdfDoc
    }

    //you could also have inits that take a URL or Data

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = pdfDocument
    }
}

struct PDFUIView: View {

    let pdfDoc: PDFDocument
    let pdfName:String
    init(pdfName:String) {
        //for the sake of example, we're going to assume
        //you have a file Lipsum.pdf in your bundle
        let url = Bundle.main.url(forResource: pdfName, withExtension: "pdf")!
        pdfDoc = PDFDocument(url: url)!
        self.pdfName = pdfName
    }

    var body: some View {
        VStack{
            Text(pdfName)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .padding(.bottom)
                .background(Color.customIndigo)
            PDFKitView(showing: pdfDoc)
        }
        
    }
}
#Preview {
    PDFUIView(pdfName: "개인정보처리방침")
}
