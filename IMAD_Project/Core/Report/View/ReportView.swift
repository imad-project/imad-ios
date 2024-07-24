//
//  ReportView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/19/24.
//

import SwiftUI

struct ReportView: View {
    
    let id:Int
    let mode:String
    @State var other = ""
    @State var filter = ReportFilter.wrongInfo
    @EnvironmentObject var vm:ReportViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            header
            ScrollView(showsIndicators: false){
                content
            }
            .background(Color.gray.opacity(0.1))
        }
        .background(Color.white.ignoresSafeArea())
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

#Preview {
    ReportView(id: 1,mode:"")
        .environmentObject(ReportViewModel())
}

extension ReportView{
    var header:some View{
        HStack{
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .bold()
            }
            Text("신고하기")
                .bold()
                .font(.GmarketSansTTFMedium(25))
            Spacer()
        }
        .foregroundColor(.black)
        .padding(10)
    }
    
    var content:some View{
        VStack(alignment: .leading,spacing:10){
            ForEach(ReportFilter.allCases,id: \.self){ report in
                Button {
                    self.filter = report
                } label: {
                    HStack{
                        Image(systemName: self.filter != report ? "circle" : "largecircle.fill.circle").foregroundColor(.customIndigo)
                        Text(report.name)
                        Spacer()
                    }
                }
            }
            .foregroundColor(.black)
            .font(.GmarketSansTTFMedium(15))
            Divider().padding(.vertical)
            CustomTextEditor(placeholder: "신고 사유를 입력해 주세요.", color: .gray, textLimit: 2500, text: $other)
                .padding(.bottom,10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
                
            Button {
                switch mode{
                case "user":vm.reportUser(id: id, type: filter.rawValue, description: other)
                case "posting":vm.reportPosting(id: id, type: filter.rawValue, description: other)
                case "comment":vm.reportComment(id: id, type: filter.rawValue, description: other)
                case "review":vm.reportReview(id: id, type: filter.rawValue, description: other)
                default:print("그런거 없음")
                }
                dismiss()
            } label: {
                Text("신고하기")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .font(.GmarketSansTTFMedium(15))
                    .padding()
                    .padding(.vertical,5)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.customIndigo)
                    }
            }
            .padding(.vertical)

        }
        .padding(10)
        .background(Color.white)
    }
}
