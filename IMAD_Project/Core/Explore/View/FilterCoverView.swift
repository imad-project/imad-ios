
import SwiftUI
import SwiftUIFlowLayout

struct FilterCoverView: View {
    @State var searchText = ""
    @StateObject var vm = ContriesFilter()
    @ObservedObject var slider = CustomSlider(start: 1900, end: 2030)
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    @Environment(\.dismiss) var dismiss
    let score = ["0~3점","3~6점","6~9점","9점 이상"]
    
    var filteredItems: [String] {
        if searchText.isEmpty {
            return vm.nativename
        } else {
        return vm.nativename.filter { String($0).contains(searchText) }
        }
    }
    var body: some View {
        
        ZStack(alignment: .topLeading){
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading,spacing:0){
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }.padding(20)
                ScrollView{
                    VStack(alignment: .leading){
                        Group{
                            Text("평점")
                                .padding(.vertical)
                            HStack{
                                ForEach(score,id: \.self){
                                    Text($0)
                                        .font(.subheadline)
                                        .padding(.horizontal)
                                        .padding(5)
                                        .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth:1))
                                        
                                }
                            }.foregroundColor(.customIndigo)
                            Text("장르")
                                .padding(.vertical)
                            FlowLayout(mode: .scrollable, items: MovieGenreFilter.allCases) { item in
                                Text(item.generName).font(.subheadline)
                                    .bold()
                                    .padding(8)
                                    .padding(.horizontal).background(Capsule().stroke(lineWidth: 1).foregroundColor(.customIndigo.opacity(0.5)))
                            }.foregroundColor(.customIndigo.opacity(0.5)).padding(.trailing)
                            Text("연도")
                                .padding(.vertical)
                            HStack(spacing: 0){
                                Text(" \(slider.lowHandle.currentValue)년 ~ ")
                                Text(" \(slider.highHandle.currentValue)년")
                            }.font(.caption)
                                .foregroundColor(.customIndigo)
                                
                            //Slider
                            SliderView(slider: slider).padding(.vertical)
                                .padding(.trailing)
                                .frame(maxWidth: .infinity)
                          

                            
                            Text("국가")
                                .padding(.vertical)
                            CustomTextField(password: false, image: "magnifyingglass", placeholder: "국가 검색 ..", color: .gray, text: $searchText)
                                .font(.subheadline)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(10)
                                .padding(.trailing)
                                .padding(.bottom)
                            FlowLayout(mode: .scrollable, items: filteredItems) { item in
                                Text(item).font(.caption)
                                    .padding(.horizontal)
                                    .padding(10)
                                    .background(Capsule().stroke(lineWidth: 1))
                            }.padding(.trailing)
                                .padding(.bottom,30)
                        }
                        .bold()
                        .font(.title3)
                        .padding(.leading,20)
                    }.padding(.bottom, keyboardResponder.keyboardHeight)
                    .edgesIgnoringSafeArea(keyboardResponder.keyboardIsVisible ? .bottom : [])
                }
                Button {
                    dismiss()
                } label: {
                    Text("확인")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .background(Color.customIndigo)
                }
            }
        }.foregroundColor(.customIndigo)
            .onAppear{
                vm.fetchDataFromURL() 
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
       
    }
}



struct FilterCoverView_Previews: PreviewProvider {
    static var previews: some View {
        FilterCoverView()
    }
}



class KeyboardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    @Published var keyboardIsVisible = false
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            keyboardHeight = keyboardFrame.height
            keyboardIsVisible = true
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        keyboardHeight = 0
        keyboardIsVisible = false
    }
}
