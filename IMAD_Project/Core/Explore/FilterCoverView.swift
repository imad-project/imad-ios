
import SwiftUI
import SwiftUIFlowLayout

struct FilterCoverView: View {
    @ObservedObject var slider = CustomSlider(start: 1900, end: 2030)
    @Environment(\.dismiss) var dismiss
    let score = ["0~3점","3~6점","6~9점","9점 이상"]
    var body: some View {
        
        ZStack(alignment: .topLeading){
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading,spacing:10){
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
                            }.foregroundColor(.customIndigo.opacity(0.5))
                            Text("연도")
                                .padding(.vertical)
                            HStack(spacing: 0){
                                Text(" \(slider.lowHandle.currentValue)년 ~ ")
                                Text(" \(slider.highHandle.currentValue)년")
                            }.font(.caption)
                                .foregroundColor(.customIndigo)
                                
                            //Slider
                            SliderView(slider: slider).padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .padding(.trailing)
                          

                            
                            Text("국가")
                                .padding(.vertical)
                            
                        }
                        .bold()
                        .font(.title3)
                        .padding(.leading,20)
                    }
                    
                }
            }
        }
       
    }
}



struct FilterCoverView_Previews: PreviewProvider {
    static var previews: some View {
        FilterCoverView()
    }
}
