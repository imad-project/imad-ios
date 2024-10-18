import SwiftUI
import Kingfisher

struct MyBookmarkListView: View {
    @State var text = ""
    
    let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = WorkViewModel(workInfo: nil, bookmarkList: [])
    @StateObject var vmAuth = AuthViewModel(user:nil)
    
    var list:[BookmarkListResponse]{
        return vm.bookmarkList.filter({$0.contentsTitle.contains(text)})
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                header
                CustomTextField(password: false, image: "magnifyingglass", placeholder: "작품을 검색해주세요 .. ", color: .gray,style: .capsule, text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(50)
                    .padding(.horizontal)
                gridView
            }
            .foregroundColor(.black)
            .background(Color.white)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .onAppear{
                vm.currentPage = 1
                vm.getBookmark(page: vm.currentPage)
            }
            .onDisappear{
                vm.currentPage = 1
                vm.bookmarkList.removeAll()
            }
            .onReceive(vm.refreschTokenExpired){
                vmAuth.logout(tokenExpired: true)
            }
        }
    }
}

struct MyBookmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        MyBookmarkListView(vm: WorkViewModel(workInfo: CustomData.workInfo,bookmarkList: CustomData.bookmarkList))
           
    }
}
extension MyBookmarkListView{
    var header:some View{
        HStack{
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
            }
            Text("내 작품")
                .font(.GmarketSansTTFMedium(25))
            Spacer()
        }
        .bold()
        .padding(10)
    }
    var gridView:some View{
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(vm.bookmarkList,id:\.self){ result in
                    NavigationLink {
                        WorkView(contentsId: result.contentsID)
                           
                            .navigationBarBackButtonHidden()
                    } label: {
                        VStack{
                            KFImageView(image: result.contentsPosterPath.getImadImage(),height: UIScreen.main.bounds.width/2)
                                .cornerRadius(5)
                            Text(result.contentsTitle)
                                .frame(maxWidth:130,maxHeight:5)
                                .font(.GmarketSansTTFMedium(14))
                                .padding(.top,5)
                            
                        }
                    }
                    .padding(.vertical,10)
                    if vm.bookmarkList.last == result,vm.currentPage < vm.maxPage{
                        ProgressView()
                            .environment(\.colorScheme, .light)
                            .onAppear{
                                vm.getBookmark(page: vm.currentPage + 1)
                            }
                    }
                }
            }.padding(.horizontal,10)
        }
    }
}
