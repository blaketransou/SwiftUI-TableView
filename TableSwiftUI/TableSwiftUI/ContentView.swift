//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Transou, Blake M on 4/1/24.
//

import SwiftUI
import MapKit




let data = [
Item(name: "Austin Women's Boxing Club", neighborhood: "South", desc: "A boxing club for all levels for women.", lat: 30.24190844306894, long: -97.78143386032852, imageName: "rest1"),
Item(name: "Legends Boxing South Austin", neighborhood: "South", desc: "All levels boxing classes that focus on footwork, technique, self defense, and conditioning.", lat: 30.193428160557374, long:-97.84237666032944, imageName: "rest2"),
Item(name: "Easley Boxing and Fitness", neighborhood: "Downtown", desc: "A boxing gym for all ages and levels.", lat: 30.244167, long: -97.771785, imageName: "rest3"),
Item(name: "Archetype Boxing Club", neighborhood: "North", desc: " USA Boxing Certified instructors designed the boxing classes to offer an authentic experience similar to a professional boxer's.", lat: 30.358790959103764, long: -97.7348544449858, imageName: "rest4"),
Item(name: "Forty Five Boxing", neighborhood: "Buda", desc: "Boxing classes for all ages in Buda.", lat: 30.034985679381755, long: -97.82780804499218, imageName: "rest5")
]
struct Item: Identifiable {
    let id = UUID()
    let name: String
    let neighborhood: String
    let desc: String
    let lat: Double
    let long: Double
    let imageName: String
}






struct ContentView: View {            // add this at the top of the ContentView struct. In this case, you can choose the coordinates for the center of the map and Zoom levels
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.726220), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
    var body: some View {
        NavigationView {
            VStack {
        
                List(data, id: \.name) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.neighborhood)
                                    .font(.subheadline)
                            
                                   
                            } // end internal VStack
                            
                        } } // end HStack
                    
                } // end List
        
                //add this code in the ContentView within the main VStack.
                           Map(coordinateRegion: $region, annotationItems: data) { item in
                               MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                   Image(systemName: "mappin.circle.fill")
                                       .foregroundColor(.red)
                                       .font(.title)
                                       .overlay(
                                           Text(item.name)
                                               .font(.subheadline)
                                               .foregroundColor(.black)
                                               .fixedSize(horizontal: true, vertical: false)
                                               .offset(y: 25)
                                       )
                               }
                           } // end map
                           .frame(height: 300)
                           .padding(.bottom, -30)
            } // end VStack
            
            .listStyle(PlainListStyle())
                  .navigationTitle("Austin Boxing Gyms")
              } // end NavigationView
        } // end body

}




struct DetailView: View {
    // put this at the top of the DetailView struct to control the center and zoom of the map. It will use the item's coordinates as the center. You can adjust the Zoom level with the latitudeDelta and longitudeDelta properties
         @State private var region: MKCoordinateRegion
         
         init(item: Item) {
             self.item = item
             _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
         }
     let item: Item
             
     var body: some View {
         VStack {
             Image(item.imageName)
                 .resizable()
                 .aspectRatio(contentMode: .fill)
                 .frame(width:UIScreen.main.bounds.size.width)
                 .frame(maxWidth: 200)
             Text("Neighborhood: \(item.neighborhood)")
                 .font(.subheadline)
             Text("Description: \(item.desc)")
                 .font(.subheadline)
                 .padding(10)
             // include this within the VStack of the DetailView struct, below the content. Reads items from data into the map. Be careful to close curly braces properly.

                 Map(coordinateRegion: $region, annotationItems: [item]) { item in
                   MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                       Image(systemName: "mappin.circle.fill")
                           .foregroundColor(.red)
                           .font(.title)
                           .overlay(
                               Text(item.name)
                                   .font(.subheadline)
                                   .foregroundColor(.black)
                                   .fixedSize(horizontal: true, vertical: false)
                                   .offset(y: 25)
                           )
                   }
               } // end Map
                   .frame(height: 300)
                   .padding(.bottom, -30)
                 } // end VStack
                  .navigationTitle(item.name)
                  Spacer()
      } // end body
   } // end DetailView



#Preview {
    ContentView()
}
