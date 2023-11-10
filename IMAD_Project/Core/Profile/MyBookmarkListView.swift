import SwiftUI
import Kingfisher

struct MyBookmarkListView: View {
    @State var text = ""
    
    let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = WorkViewModel(workInfo: nil, bookmarkList: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var list:[BookmarkListResponse]{
        return vm.bookmarkList.filter({$0.contentsTitle.contains(text)})
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                header
                CustomTextField(password: false, image: "magnifyingglass", placeholder: "작품을 검색해주세요 .. ", color: .gray, text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(20)
                    .padding(.horizontal)
                gridView
            }
            .foregroundColor(.black)
            .background(Color.white)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .onAppear{
                vm.getBookmark(page: vm.currentPage)
            }
            .onDisappear{
                vm.bookmarkList.removeAll()
            }
        }
    }
}

struct MyBookmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        MyBookmarkListView(vm: WorkViewModel(workInfo: CustomData.instance.workInfo,bookmarkList: CustomData.instance.bookmarkList))
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}
extension MyBookmarkListView{
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
    var gridView:some View{
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(vm.bookmarkList,id:\.self){ result in
                    NavigationLink {
                        WorkView(contentsId: result.contentsID)
                            .environmentObject(vmAuth)
                            .navigationBarBackButtonHidden()
                    } label: {
                        VStack{
                            KFImageView(image: result.contentsPosterPath.getImadImage(),height: 170)
                            Text(result.contentsTitle)
                                .bold()
                                .frame(maxWidth:130,maxHeight:5)
                                .font(.subheadline)
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
