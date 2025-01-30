class CurrentWeather {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  CurrentWeather({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    weather = json['weather'] != null
        ? (json['weather'] as List).map((v) => Weather.fromJson(v)).toList()
        : null;
    base = json['base'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() => {
        'coord': coord?.toJson(),
        'weather': weather?.map((v) => v.toJson()).toList(),
        'base': base,
        'main': main?.toJson(),
        'visibility': visibility,
        'wind': wind?.toJson(),
        'clouds': clouds?.toJson(),
        'dt': dt,
        'sys': sys?.toJson(),
        'timezone': timezone,
        'id': id,
        'name': name,
        'cod': cod,
      };
}

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json)
      : lon = json['lon'],
        lat = json['lat'];

  Map<String, dynamic> toJson() => {'lon': lon, 'lat': lat};
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        main = json['main'],
        description = json['description'],
        icon = json['icon'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'main': main, 'description': description, 'icon': icon};
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  Main.fromJson(Map<String, dynamic> json)
      : temp = json['temp'],
        feelsLike = json['feels_like'],
        tempMin = json['temp_min'],
        tempMax = json['temp_max'],
        pressure = json['pressure'],
        humidity = json['humidity'],
        seaLevel = json['sea_level'],
        grndLevel = json['grnd_level'];

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'humidity': humidity,
        'sea_level': seaLevel,
        'grnd_level': grndLevel,
      };
}

class Wind {
  double speed;
  int? deg;
  double? gust;

  Wind({required this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json)
      : speed = json['speed'],
        deg = json['deg'],
        gust = json['gust'];

  Map<String, dynamic> toJson() => {'speed': speed, 'deg': deg, 'gust': gust};
}

class Clouds {
  int? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) : all = json['all'];

  Map<String, dynamic> toJson() => {'all': all};
}

class Sys {
  String? country;
  int? sunrise;
  int? sunset;

  Sys({this.country, this.sunrise, this.sunset});

  Sys.fromJson(Map<String, dynamic> json)
      : country = json['country'],
        sunrise = json['sunrise'],
        sunset = json['sunset'];

  Map<String, dynamic> toJson() =>
      {'country': country, 'sunrise': sunrise, 'sunset': sunset};
}
