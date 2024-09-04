// {YourFuckingIPAddress: 31.220.90.224, YourFuckingLocation: Düsseldorf, NW, Germany, YourFuckingHostname: vmi2087151.contaboserver.net, YourFuckingISP: Contabo GmbH, YourFuckingTorExit: false, YourFuckingCity: Düsseldorf, YourFuckingCountry: Germany, YourFuckingCountryCode: DE}

class IpAddressModel {
  final String? ipAddress;
  final String? location;
  final String? hostname;
  final String? isp;
  final String? city, country, countryCode;

  const IpAddressModel({
    this.ipAddress,
    this.location,
    this.hostname,
    this.isp,
    this.city,
    this.country,
    this.countryCode,
  });

  factory IpAddressModel.fromJson(Map<String, dynamic> json) => IpAddressModel(
        ipAddress: json["YourFuckingIPAddress"].toString(),
        location: json["YourFuckingLocation"].toString(),
        hostname: json["YourFuckingHostname"].toString(),
        isp: json["YourFuckingISP"].toString(),
        city: json["YourFuckingCity"].toString(),
        country: json["YourFuckingCountry"].toString(),
        countryCode: json["YourFuckingTorExit"].toString(),
      );
}
