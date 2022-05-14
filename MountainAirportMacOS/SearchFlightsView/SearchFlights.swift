
import SwiftUI

struct SearchFlights: View {
  @State var flightData: [FlightInformation]
  @State private var date = Date()
  @State private var directionFilter: FlightDirection = .none
  @State private var city = ""
  @State private var runningSearch = false
  
  @State private var showListOfCities = false
  @FocusState private var focusedField
  
  
  var matchingFlights: [FlightInformation] {
    var matchingFlights = flightData
    
    if directionFilter != .none {
      matchingFlights = matchingFlights.filter { $0.direction == directionFilter }
    }
    return matchingFlights
  }
  
  
  var flightDates: [Date] {
    let allDates = matchingFlights.map { $0.localTime.dateOnly }
    let uniqueDates = Array(Set(allDates))
    return uniqueDates.sorted()
  }
  
  func flightsForDay(date: Date) -> [FlightInformation] {
    matchingFlights.filter {
      Calendar.current.isDate($0.localTime, inSameDayAs: date)
    }
  }
  
  var body: some View {
    ZStack {
      Image("background-view")
        .resizable()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      VStack {
        Picker(
          selection: $directionFilter,
          label: Text("Flight Direction")) {
            Text("All").tag(FlightDirection.none)
            Text("Arrivals").tag(FlightDirection.arrival)
            Text("Departures").tag(FlightDirection.departure)
          }
          .pickerStyle(SegmentedPickerStyle())
          .padding(.leading, 5)
          .background(Color.white.opacity(0.4))
          .clipShape(RoundedRectangle(cornerRadius: 5))
        TextField("Search cities", text: $city)
          .background(Color.white.opacity(0.4))
          .clipShape(RoundedRectangle(cornerRadius: 5))
          .focused($focusedField)
          .onSubmit(of: .text) {
            Task {
              runningSearch = true
              showListOfCities = false
              await flightData = FlightData.searchFlightsForCity(city)
              runningSearch = false
            }
          }
          .onChange(of: city) { newText in
            showListOfCities = true
          }
          .onChange(of: focusedField) { clicked in
            showListOfCities = clicked ? true : false
          }
          .popover(isPresented: $showListOfCities, arrowEdge: .bottom) {
            VStack(alignment: .leading, spacing: 2) {
              ForEach(FlightData.citiesContaining(city), id: \.self) { city in
                Text(city).searchCompletion(city)
              }
            }
            .padding()
            .frame(minWidth: 150)
          }
        List(flightDates, id: \.hashValue) { date in
          Section {
            ForEach(flightsForDay(date: date)) { flight in
              SearchResultRow(flight: flight)
            }
          } header: {
            Text(longDateFormatter.string(from: date))
          } footer: {
            HStack {
              Spacer()
              Text("Mateches for the date: \(flightsForDay(date: date).count)")
            }
          }
        }
        .overlay(
          Group {
            if runningSearch {
              VStack {
                Text("Searching...")
                ProgressView()
                  .progressViewStyle(CircularProgressViewStyle())
                  .tint(.black)
                  .scaleEffect(4)
              }
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .background(.white)
              .opacity(0.6)
            }
          }
        )
        .listStyle(InsetListStyle() )
        Spacer()
      }
      .navigationTitle("Search Flights")
      .padding()
    }
  }
}

struct SearchFlights_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SearchFlights(flightData: FlightData.generateTestFlights(date: Date())
      )
    }
  }
}
