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
    weather =
        json['weather'] != null
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

  // Convert CurrentWeather to Map for local DB
  Map<String, dynamic> toMap() {
    return {
      'coord': coord?.toMap(),
      'weather': weather?.map((w) => w.toMap()).toList(),
      'base': base,
      'main': main?.toMap(),
      'visibility': visibility,
      'wind': wind?.toMap(),
      'clouds': clouds?.toMap(),
      'dt': dt,
      'sys': sys?.toMap(),
      'timezone': timezone,
      'id': id,
      'name': name,
      'cod': cod,
    };
  }

  // Create CurrentWeather from Map retrieved from local DB
  factory CurrentWeather.fromMap(Map<dynamic, dynamic> map) {
    return CurrentWeather(
      coord:
          map['coord'] != null
              ? Coord.fromMap(Map<dynamic, dynamic>.from(map['coord']))
              : null,
      weather:
          map['weather'] != null
              ? List<Map<dynamic, dynamic>>.from(
                map['weather'],
              ).map((w) => Weather.fromMap(w)).toList()
              : null,
      base: map['base'],
      main:
          map['main'] != null
              ? Main.fromMap(Map<dynamic, dynamic>.from(map['main']))
              : null,
      visibility: map['visibility'],
      wind:
          map['wind'] != null
              ? Wind.fromMap(Map<dynamic, dynamic>.from(map['wind']))
              : null,
      clouds:
          map['clouds'] != null
              ? Clouds.fromMap(Map<dynamic, dynamic>.from(map['clouds']))
              : null,
      dt: map['dt'],
      sys:
          map['sys'] != null
              ? Sys.fromMap(Map<dynamic, dynamic>.from(map['sys']))
              : null,
      timezone: map['timezone'],
      id: map['id'],
      name: map['name'],
      cod: map['cod'],
    );
  }
}

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json)
    : lon = (json['lon'] as num?)?.toDouble(),
      lat = (json['lat'] as num?)?.toDouble();

  Map<String, dynamic> toJson() => {'lon': lon, 'lat': lat};

  Map<String, dynamic> toMap() => {'lon': lon, 'lat': lat};

  factory Coord.fromMap(Map<dynamic, dynamic> map) {
    return Coord(
      lon: (map['lon'] as num?)?.toDouble(),
      lat: (map['lat'] as num?)?.toDouble(),
    );
  }
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

  Map<String, dynamic> toJson() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };

  Map<String, dynamic> toMap() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };

  factory Weather.fromMap(Map<dynamic, dynamic> map) {
    return Weather(
      id: map['id'],
      main: map['main'],
      description: map['description'],
      icon: map['icon'],
    );
  }
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
    : temp = (json['temp'] as num?)?.toDouble(),
      feelsLike = (json['feels_like'] as num?)?.toDouble(),
      tempMin = (json['temp_min'] as num?)?.toDouble(),
      tempMax = (json['temp_max'] as num?)?.toDouble(),
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

  Map<String, dynamic> toMap() => {
    'temp': temp,
    'feels_like': feelsLike,
    'temp_min': tempMin,
    'temp_max': tempMax,
    'pressure': pressure,
    'humidity': humidity,
    'sea_level': seaLevel,
    'grnd_level': grndLevel,
  };

  factory Main.fromMap(Map<dynamic, dynamic> map) {
    return Main(
      temp: (map['temp'] as num?)?.toDouble(),
      feelsLike: (map['feels_like'] as num?)?.toDouble(),
      tempMin: (map['temp_min'] as num?)?.toDouble(),
      tempMax: (map['temp_max'] as num?)?.toDouble(),
      pressure: map['pressure'],
      humidity: map['humidity'],
      seaLevel: map['sea_level'],
      grndLevel: map['grnd_level'],
    );
  }
}

class Wind {
  double speed;
  int? deg;
  double? gust;

  Wind({required this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json)
    : speed = (json['speed'] as num).toDouble(),
      deg = json['deg'],
      gust = (json['gust'] != null) ? (json['gust'] as num).toDouble() : null;

  Map<String, dynamic> toJson() => {'speed': speed, 'deg': deg, 'gust': gust};

  Map<String, dynamic> toMap() => {'speed': speed, 'deg': deg, 'gust': gust};

  factory Wind.fromMap(Map<dynamic, dynamic> map) {
    return Wind(
      speed: (map['speed'] as num).toDouble(),
      deg: map['deg'],
      gust: map['gust'] != null ? (map['gust'] as num).toDouble() : null,
    );
  }
}

class Clouds {
  int? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) : all = json['all'];

  Map<String, dynamic> toJson() => {'all': all};

  Map<String, dynamic> toMap() => {'all': all};

  factory Clouds.fromMap(Map<dynamic, dynamic> map) {
    return Clouds(all: map['all']);
  }
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

  Map<String, dynamic> toJson() => {
    'country': country,
    'sunrise': sunrise,
    'sunset': sunset,
  };

  Map<String, dynamic> toMap() => {
    'country': country,
    'sunrise': sunrise,
    'sunset': sunset,
  };

  factory Sys.fromMap(Map<dynamic, dynamic> map) {
    return Sys(
      country: map['country'],
      sunrise: map['sunrise'],
      sunset: map['sunset'],
    );
  }
}
