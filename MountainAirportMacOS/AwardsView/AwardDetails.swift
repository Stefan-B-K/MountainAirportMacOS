
import SwiftUI

struct AwardDetails: View {
  var award: AwardInformation
  @Environment(\.dismiss) var dismiss
  
  func imageSize(proxy: GeometryProxy) -> CGFloat {
    let size = min(proxy.size.width, proxy.size.height)
    return size * 0.8
  }
  
  var body: some View {
    HStack {
      Spacer()
      Button {
        dismiss()
      } label: {
        Image(systemName: "xmark.circle")
          .font(.largeTitle)
      }
      .buttonStyle(.plain)
      .padding()
      .foregroundColor(.primary)
    }
    
    VStack(alignment: .center) {
      Image(award.imageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 150, height: 150)
      Text(award.title)
        .font(.title)
        .padding()
      Text(award.description)
        .font(.body)
        .padding()
      AwardStars(stars: award.stars)
        .foregroundColor(.yellow)
        .scaleEffect(1.5)
        .shadow(color: .primary, radius: 5)
      Spacer()
    }
    .padding()
    .foregroundColor(.primary)
    .opacity(award.awarded ? 1 : 0.4)
    .saturation(award.awarded ? 1 : 0.3)
    .frame(minWidth: 400, idealWidth: 600, maxWidth: .infinity,
           minHeight: 300, idealHeight: 400, maxHeight: .infinity)
  }
}

struct AwardDetails_Previews: PreviewProvider {
  static var previews: some View {
    let award = AwardInformation(
      imageName: "first-visit-award",
      title: "First Visit",
      description: "Awarded the first time you open the app while at the airport.",
      awarded: true,
      stars: 3
    )
    
    let award2 = AwardInformation(
      imageName: "rainy-day-award",
      title: "Rainy Day",
      description: "Your flight was delayed because of weather.",
      awarded: false,
      stars: 2
    )
    
    Group {
      AwardDetails(award: award)
      AwardDetails(award: award2)
    }
  }
}
