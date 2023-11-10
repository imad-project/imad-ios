import SwiftUI
import Kingfisher

struct MyBookmarkListView: View {
    @State var text = ""
    
    let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm:WorkViewModel
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                header
                
                CustomTextField(password: false, image: "magnifyingglass", placeholder: "작품을 검색해주세요 .. ", color: .gray, text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(20)
                    .padding(.horizontal)
                ScrollView{
                    LazyVGrid(columns: columns) {
                        ForEach(vm.myBookmarkList,id:\.self){ result in
                            NavigationLink {
//                                WorkView(id: result.contentsTmdbId, type:result.contentsType)
                            } label: {
                                VStack{
                                    KFImage(URL(string: result.contentsPosterPath.getImadImage()))
                                        .placeholder{ _ in
                                            emptyPoster
                                        }
                                        .resizable()
                                        .frame(height: 170)
                                        .cornerRadius(15)
                                    Text(result.contentsTitle)
                                        .bold()
                                        .font(.subheadline)
                                        .frame(maxWidth:130,maxHeight:5)
                                    
                                }
                            }
                            .padding(.bottom,10)
                            if let total = vm.bookmarkList?.totalElements,vm.myBookmarkList.last == result,vm.myBookmarkList.count != total{    //WorkResult에 Equtabe추가
                                ProgressView()
                                    .environment(\.colorScheme, .light)
                                    .onAppear{
                                        vm.getBookmark(page: vm.currentPage + 1)
                                    }
                            }
                        }
                        
                    }.padding(.horizontal,10)
                    
                    
                }
            }.foregroundColor(.black)
                .background(Color.white)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
        }
    }
}

struct MyBookmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        MyBookmarkListView()
            .environmentObject(WorkViewModel(workInfo: CustomData.instance.workInfo))
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}
extension MyBookmarkListView{
    func genreHeader(name:String) ->some View{
        HStack{
            Text(name)
                .bold()
                .padding(.leading)
                .padding(.top)
            Spacer()
        }
    }
    var header:some View{
        ZStack{
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .padding()
                    
                }
                Spacer()
                
            }
            Text("내 작품")
                .bold()
        }
    }
    var emptyPoster:some View{
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.gray.opacity(0.4))
            .overlay {
                VStack{
                    Image(systemName: "xmark.app.fill")
                        .font(.title)
                        .padding(.bottom)
                    Text("포스터 없음")
                }
                .bold()
                .foregroundColor(.white)
            }
    }
}
