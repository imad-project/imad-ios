//
//  MovieListView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/19.
//

import SwiftUI
import Kingfisher

struct WorkListView: View {
    @StateObject var vm = SearchViewModel()
    let title:String
    
    let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    @Binding var back:Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                header
                
                CustomTextField(password: false, image: "magnifyingglass", placeholder: "작품을 검색해주세요 .. ", color: .gray, text: $vm.searchText)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(20)
                    .padding(.horizontal)
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
                ScrollView{
                    
                        LazyVGrid(columns: columns) {
                            ForEach(vm.work){ result in
                                NavigationLink {
                                    WorkView(id:result.id,type:result.mediaType ?? "")
                                   } label: {
                                       VStack{
                                           KFImage(URL(string: result.posterPath?.getImadImage() ?? ""))
                                               .placeholder{ _ in
                                                   emptyPoster
                                               }
                                               .resizable()
                                               .frame(height: 170)
                                               .cornerRadius(15)
                                           Text(result.title == nil ? result.name ?? "" : result.title ?? "")
                                           .bold()
                                           .font(.subheadline)
                                           .frame(maxWidth:130,maxHeight:5)
   
                                       }
                                   }
                                   .padding(.bottom,10)
                                if vm.work.last == result,vm.maxPage != vm.currentPage{    //WorkResult에 Equtabe추가
                                    ProgressView()
                                        .environment(\.colorScheme, .light)
                                        .onAppear{
                                            vm.searchWork(query: vm.searchText, type: vm.type, page: vm.currentPage + 1)
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

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkListView(title: "내 작품", back: .constant(false))
    }
}
extension WorkListView{
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
            Text(title)
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
