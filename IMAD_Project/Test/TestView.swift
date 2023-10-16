//
//  TestView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/06/02.
//

import SwiftUI
import Combine

//struct TestView: View {
//    let text = "AdYOmQHnrpYwoedHju6p6m518KN0YEDOsOxS6lb5hrBT9ZSdmvV0pbfoI8TvKiWliqo8JigZR2ENjP0nzzZrJbiYJTKgGK4w8NzvId2VPy82qbNFfKxGRLUhSyibvgeYgHWnB4VWRuFk0rTHG34F8WY1jihlX2EcfU86dMwowVoguzIHPI6Pkohq1WNuByJZXDFyizaBk68pTzCrKWIZV4RIwyJ43IbfxpHaP4cVt3TZ5mHBpDrXrnNm7AuYtE8ASI1CDZio7pvsdotL5jWROBY6CvWmPQ7qX0Fkliv6eZO6MTlSvhs2IttVlhIIed2lhg4elcZv2hgg50CYAoDa61g1D1BDEFRoi3S6qeARh35wf8QLk8lFfqTmmnpPm8vDQNw8YukaVbrnIbKvg8Cq8b9q2a3j1nTKkdG1bCRi5RW8KhAZg8cA98v3Q9FOFANdbmcjhhqk58jYs78T2f3Cpq8bhKwQO4isuxRXkzdBqZpfWnJOuxE4HQ4SG2K1uWlkBpmlotvYkWyggmXaAq1fgCmI49vyiTDDvdGLzQu687j9j7Nhx8up4rw0VkKErSRYdFOAiGynPAR6RRx5JKF1hM3bMPVqQc3VJuWMyld7gO89GoAqyHPQ7p2S4qpESYqgxUpfmOtf3XxJxi2JHPUfdHpOhhohFqjCKIlZdljSohdmKaIIlB8QWq3YlOK3xyGjnJBj2w5yLhkwbukyNvmkpxb3YLycO9rjfhqFbXL8RPUCHaduxZpqpbO47T0uHhsxbRDRhpF3a4pZngxisTjy436c44hNHn9U88iyMFSGiBPd5Os6WrsSASzB7gddz8dvumuQMaCDZZGiGWs4VFCkMaoWqlBEdVYVx3bliW1"
//    var body: some View {
//        ScrollView {
//            TabView {
//
//                Dummy(text: text)
//                    .font(.title)
//                    .onAppear{
//                        print(getHeightForText(text))
//                    }
//                Text("asdasd")
//            }.frame(height: getHeightForText(text))
//        }
//        .tabViewStyle(.page)
//                .indexViewStyle(.page(backgroundDisplayMode: .always))
//                .background(Color.red.ignoresSafeArea())
//    }
//    private func getHeightForText(_ text: String) -> CGFloat {
//        let constraintRect = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
//        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
//        print(boundingBox)
//        return ceil(boundingBox.height)
//    }
//}
//
//
struct Dummy:View{
    
    //    let font:UIFont.TextStyle = .subheadline
    //    let maxLines:CGFloat = 5
    
    let text:String
    var body: some View{
                    GeometryReader { geo in
                        let pp = geo.size.height
                        
                        Text(text)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                        
                        .ignoresSafeArea()
//                        .frame(height: pp)
                        .onAppear{
//                            height = pp
                            print(pp)
                        }
                    }
        
    }
}
////    private var shouldShowMoreButton:Bool {
////
////        let textHeight = getHeightForText(text)
////        let lineHeight = UIFont.preferredFont(forTextStyle: font).lineHeight
////        let maxTextHeight = CGFloat(maxLines) * lineHeight
////        return textHeight > maxTextHeight
////    }
//
//
//}
struct TestView: View {
    @State var num = 0
    @State var nums:[Int] = [0,1,2,3,4]
    @State var category:CommunityFilter = .question
    var ddd = PassthroughSubject<(),Never>()
    var body: some View{
        VStack{
            Picker("",selection: $category){
                ForEach(CommunityFilter.allCases,id: \.self){ item in
                    if item != .all{
                        Text(item.name)
                            .tag(item)
                    }
                }.foregroundColor(.black)
            }
            .pickerStyle(.segmented)
            .environment(\.colorScheme, .light)
            .padding(.horizontal,30)
//            HStack{
//                ForEach(num,id: \.self){ num in
//                    Text("\(num)")
//                }
//            }
//
//
//            Button {
//                var cancel = Set<AnyCancellable>()
//
//                [1,2,3].publisher
//                    .sink { com in
//                        print(com)
//                        ddd.send()
//                    } receiveValue: { int in
//                        num.append(int)
//                        [4,5,6].publisher
//                            .sink { com in
//                                print(com)
//                            } receiveValue: { int in
//                                num.append(int)
//                            }.store(in: &cancel)
//                    }.store(in: &cancel)
//
//                num.append(333333)
//
//
//
//            } label: {
//                Text("go")
//            }
//            .onReceive(ddd) {
//                var cancel = Set<AnyCancellable>()
//                [7,8,9].publisher
//                    .sink { com in
//                        print(com)
//                    } receiveValue: { int in
//                        num.append(int)
//                    }.store(in: &cancel)
//            }
        }
        

//        ScrollView{
//            LazyVStack(alignment: .leading,pinnedViews: [.sectionHeaders]){
//                Section {
//                    ForEach(0...10,id: \.self) { int in
//                        Text("\(int)")
//                    }
//                } header: {
//                    GeometryReader { geo -> AnyView in
//                        let offset = geo.frame(in: .global).minY
//        //                if {
//                            DispatchQueue.main.async {
//                                withAnimation {
//                                    -offset >= 0 ? (width = true) : (width = false)
//                                }
//
//                                print(width)
//                            }
//        //                }
//                        return AnyView(header)
//                    }
//
//
//                }
//
//
//            }
//
////                Color.red
////            }.frame(height: 200)
//        }.ignoresSafeArea()
    
        
            
    }
//    var header:some View{
//        VStack{
//            Spacer()
//            Text("dasdasd")
//                .font(width ? .largeTitle :.body)
//                .background(Color.red)
//        }
    }
//    let text = ".AdYOmQHnrpYwoedHju6p6m518KN0YEDOsOxS6lb5hrBT9ZSdmvV0pbfoI8TvKiWliqo8JigZR2ENjP0nzzZrJbiYJTKgGK4w8NzvId2VPy82qbNFfKxGRLUhSyibvgeYgHWnB4VWRuFk0rTHG34F8WY1jihlX2EcfU86dMwowVoguzIHPI6Pkohq1WNuByJZXDFyizaBk68pTzCrKWIZV4RIwyJ43IbfxpHaP4cVt3TZ5mHBpDrXrnNm7AuYtE8ASI1CDZio7pvsdotL5jWROBY6CvWmPQ7qX0Fkliv6eZO6MTlSvhs2IttVlhIIed2lhg4elcZv2hgg50CYAoDa61g1D1BDEFRoi3S6qeARh35wf8QLk8lFfqTmmnpPm8vDQNw8YukaVbrnIbKvg8Cq8b9q2a3j1nTKkdG1bCRi5RW8KhAZg8cA98v3Q9FOFANdbmcjhhqk58jYs78T2f3Cpq8bhKwQO4isuxRXkzdBqZpfWnJOuxE4HQ4SG2K1uWlkBpmlotvYkWyggmXaAq1fgCmI49vyiTDDvdGLzQu687j9j7Nhx8up4rw0VkKErSRYdFOAiGynPAR6RRx5JKF1hM3bMPVqQc3VJuWMyld7gO89GoAqyHPQ7p2S4qpESYqgxUpfmOtf3XxJxi2JHPUfdHpOhhohFqjCKIlZdljSohdmKaIIlB8QWq3YlOK3xyGjnJBj2w5yLhkwbukyNvmkpxb3YLycO9rjfhqFbXL8RPUCHaduxZpqpbO47T0uHhsxbRDRhpF3a4pZngxisTjy436c44hNHn9U88iyMFSGiBPd5Os6WrsSASzB7gddz8dvumuQMaCDZZGiGWs4VFCkMaoWqlBEdVYVx3bliW" // (your text here)
//    let work = CustomData.instance.workInfo
//    var body: some View {
//
//        ScrollView {
//            TabView {
//                Dummy(text: text)
//
//                    .onAppear {
//                        print(text.height(withConstrainedWidth: UIScreen.main.bounds.width, font: UIFont.preferredFont(forTextStyle: .subheadline)))
////                        print(getHeightForText(text))
//                    }
//                if let crew = work.credits?.crew{
//                    ForEach(crew){ _ in
//
//                    }
//                }
//
//                Text("asdasd")
//            }
//            .frame(height: text.height(withConstrainedWidth: UIScreen.main.bounds.width, font: UIFont.preferredFont(forTextStyle: .body)))
////            .frame(height: getHeightForText(text) + 300) // Adjust the constant value as needed
//        }
//        .tabViewStyle(.page)
//        .indexViewStyle(.page(backgroundDisplayMode: .always))
//        .background(Color.red.ignoresSafeArea())
//    }

//    private func getHeightForText(_ text: String) -> CGFloat {
//        let constraintRect = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
//
//        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
//        return ceil(boundingBox.height)
//    }
//}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
//        Dummy()
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
