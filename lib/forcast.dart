class Forcast {
  final String city;
  final double currentTemp;
  final String condition;
  final String iconLink;
  final double maxTemp;
  final double minTemp;

  Forcast(
      {required this.city,
      required this.currentTemp,
      required this.condition,
      required this.maxTemp,
      required this.minTemp,
      required this.iconLink});

  factory Forcast.refresh(Map<String, dynamic> json) {
    return switch (json) {
      {
        'location': {
          'name': String city,
        },
        'current': {
          'temp_c': double currentTemp,
          'condition': {
            'text': String condition,
            'icon': String iconLink,
          },
        },
        'forecast': {
          'forecastday': [
            {
              "day": {
                'maxtemp_c': double maxTemp,
                'mintemp_c': double minTemp,
              },
            }
          ]
        }
      } =>
        Forcast(
            city: city,
            currentTemp: currentTemp,
            condition: condition,
            maxTemp: maxTemp,
            minTemp: minTemp,
            iconLink: iconLink),
      _ => throw const FormatException("failed to load wheather")
    };
  }
}
