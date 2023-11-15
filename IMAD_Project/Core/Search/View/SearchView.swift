//
//  MovieListView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/19.
//

import SwiftUI


struct SearchView: View {
   
    let postingMode:Bool    //MARK: true -> CommunityWriteView / false -> WorkView
    let columns =  [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
//    @State var tokenExpired = (false,"")
//    @State var goPosting = (false,0)
    @Binding var back:Bool
    @StateObject var vm = SearchViewModel()
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
//        NavigationView {
            VStack(alignment: .leading){
                header
                searchBar
                filter
                ScrollView{
                        LazyVGrid(columns: columns) {
                            ForEach(vm.work){ result in
                                workListRow(result: result)
                                if vm.work.last == result,vm.maxPage > vm.currentPage{
                                    ProgressView()
                                        .environment(\.colorScheme, .light)
                                        .onAppear{
                                            vm.searchWork(query: vm.searchText, type: vm.type, page: vm.currentPage + 1)
                                        }
                                }
                            } .padding(.top)
                        }.padding(.horizontal,10)
                }
               
            }
            .foregroundColor(.black)
            .background(Color.white)
            .onReceive(vm.refreschTokenExpired){
                vmAuth.logout(tokenExpired: true)
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
//        }
//        .navigationDestination(isPresented: $goPosting.0){
//            CommunityPostView(postingId:goPosting.1)
//                .environmentObject(vmAuth)
//        }
//        .onReceive(vm.tokenExpired) { messages in
//            tokenExpired = (true,messages)
//        }
//        .alert(isPresented: $tokenExpired.0) {
//            Alert(title: Text("토큰 만료됨"),message: Text(tokenExpired.1),dismissButton:.cancel(Text("확인")){
////                vmAuth.loginMode = false
//            })
//        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SearchView(postingMode: true, back: .constant(false),vm: SearchViewModel(work: CustomData.instance.workList))
                .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
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
        ZStack{
            HStack{
                Button {
                    back = false
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .padding()
                        
                }
                Spacer()

            }
            Text("작품 찾기")
                .bold()
        }
    }
        var searchBar:some View{
        CustomTextField(password: false, image: "magnifyingglass", placeholder: "작품을 검색해주세요 .. ", color: .gray, text: $vm.searchText)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
            .padding(.horizontal)
    }
    var filter:some View{
        HStack(spacing: 0){
            Image(systemName: "slider.horizontal.3")
            Picker("", selection: $vm.type) {
                ForEach(MovieTypeFilter.allCases,id:\.self){ text in
                    Text(text.name)
                }
            }
            .accentColor(.black)
        }
        .padding(.horizontal)
        .padding(.bottom,5)
    }
    func workListRow(result:WorkListResponse) ->some View{
        NavigationLink {
            Group{
                if postingMode{
                    CommunityWriteView(image: result.posterPath?.getImadImage() ?? "", goMain: .constant(true))
                }else{
                    WorkView(id:result.id,type: result.mediaType)
                }
            }
            .environmentObject(vmAuth)
            .navigationBarBackButtonHidden()
           } label: {
               VStack{
                   KFImageView(image: result.posterPath?.getImadImage() ?? "", height: (UIScreen.main.bounds.width/3)*1.25)
                   Text(result.title == nil ? result.name ?? "" : result.title ?? "")
                   .bold()
                   .font(.subheadline)
                   .frame(maxWidth:130,maxHeight:5)
               }
           }
           .padding(.bottom,10)
    }
}
