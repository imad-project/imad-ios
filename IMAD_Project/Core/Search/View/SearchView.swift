//
//  MovieListView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/19.
//

import SwiftUI


struct SearchView: View {
    let backMode:Bool
    let postingMode:Bool    //MARK: true -> CreatePostingView / false -> WorkView
    let columns =  [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
  
    @State var contentsId:Int?
    @State var work:WorkListResponse?
    @State var goWork = false
    
    @Binding var back:Bool
    @StateObject var vmWork = WorkViewModel(workInfo: nil, bookmarkList: [])
    @StateObject var vm = SearchViewModel()
    @StateObject var user = UserInfoManager.instance
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            header
            searchBar
            filter
            Divider()
            ScrollView{
                workListView
            }
        }
        .foregroundColor(.black)
        .background(Color.white)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onReceive(vmWork.success){ contentsId in
            self.contentsId = contentsId
            goWork = true
        }
        .navigationDestination(isPresented: $goWork) {
            Group{
                if let work{
                    if postingMode{
                        CreatePostingView(contentsId: contentsId,  contents: (work.posterPath?.getImadImage() ?? "",work.title == nil ? work.name ?? "" : work.title ?? ""), goMain: $back)
                    }else{
                        WorkView(id:work.id,type: work.mediaType)
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SearchView(backMode: true, postingMode: true, back: .constant(false),vm: SearchViewModel(work: CustomData.workList))
               
        }
    }
}
extension SearchView{
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
        HeaderView(backIcon: backMode ? nil :"xmark", text: "작품 찾기"){
            back = false
        }
        .padding([.horizontal,.top],10)
    }
    var searchBar:some View{
        CustomTextField(password: false, image: "magnifyingglass", placeholder: "작품을 검색해주세요 .. ", color: .gray.opacity(0.2), style: .capsule, text: $vm.searchText)
    }
    var filter:some View{
        Picker("", selection: $vm.type) {
            ForEach(WorkTypeCategory.allCases,id:\.self){ text in
                Text(text.name)
            }
        }
        .accentColor(.customIndigo)
    }
    var workListView:some View{
        LazyVGrid(columns: columns) {
            ForEach(vm.work){ result in
                Button {
                    work = result
                    vmWork.getWorkInfo(id: result.id, type: result.mediaType ?? "")
                } label: {
                    VStack{
                        KFImageView(image: result.posterPath?.getImadImage() ?? "", height: (UIScreen.main.bounds.width/3)*1.25)
                            .cornerRadius(5)
                            .shadow(radius: 1)
                        Text(result.title == nil ? result.name ?? "" : result.title ?? "")
                            .font(.GmarketSansTTFMedium(12))
                            .frame(maxWidth:130,maxHeight:5)
                    }
                }
                .padding(.bottom,5)
                if vm.work.last == result,vm.maxPage > vm.currentPage{
                    ProgressView()
                        .environment(\.colorScheme, .light)
                        .onAppear{
                            vm.searchWork(query: vm.searchText, type: vm.type, page: vm.currentPage + 1)
                        }
                }
            } .padding(.top,10)
        }
        .padding(.horizontal,10)
        .padding(.bottom)
    }
}
