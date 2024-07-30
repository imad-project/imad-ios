//
//  ReportView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/19/24.
//

import SwiftUI

struct ReportView: View {
    
    let id:Int              //신고 ID
    let mode:String         //
    @State var other = ""
    @State var filter = ReportFilter.wrongInfo
    @EnvironmentObject var vm:ReportViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            headerView
            contentView
        }
        .background(Color.white.ignoresSafeArea())
        .onTapGesture{ UIApplication.shared.endEditing() }
    }
}

extension ReportView{
    var headerView:some View{
        HeaderView(backIcon: "xmark", text: "신고하기"){
            dismiss()
        }
        .padding(10)
    }
    var listView:some View{
        ForEach(ReportFilter.allCases,id: \.self){ report in
            Button {
                self.filter = report
            } label: {
                HStack{
                    Image(systemName:self.filter != report ? "circle" : "largecircle.fill.circle")
                        .foregroundColor(.customIndigo)
                    Text(report.name)
                    Spacer()
                }
            }
        }
        .foregroundColor(.black)
        .font(.GmarketSansTTFMedium(15))
    }
    var textEditorView:some View{
        CustomTextEditor(placeholder: "신고 사유를 입력해 주세요.", color: .gray, textLimit: 2500, text: $other)
            .padding(.bottom,10)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(5)
    }
    var buttonView:some View{
        CustomConfirmButton(text: "신고하기", color: .customIndigo,textColor:.white) {
            switch mode{
            case "user":vm.reportUser(id: id, type: filter.rawValue, description: other)
            case "posting":vm.reportPosting(id: id, type: filter.rawValue, description: other)
            case "comment":vm.reportComment(id: id, type: filter.rawValue, description: other)
            case "review":vm.reportReview(id: id, type: filter.rawValue, description: other)
            default:print("그런거 없음")
            }
            dismiss()
        }
        .padding(.vertical)
    }
    var contentView:some View{
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading,spacing:10){
                listView
                Divider().padding(.vertical)
                textEditorView
                buttonView
            }
            .padding(10)
            .background(Color.white)
        }
        .background(Color.gray.opacity(0.1))
    }
}

#Preview {
    ReportView(id: 1,mode:"")
        .environmentObject(ReportViewModel())
}
