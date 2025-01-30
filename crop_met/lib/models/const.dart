Map<String, String> countryNames = {
  "IT": "Italy",
  "PK": "Pakistan",
  "US": "United States",
  "FR": "France",
  "DE": "Germany",
  "IN": "India",
  "UK": "United Kingdom",
  "CN": "China",
  "JP": "Japan",
  "CA": "Canada",
};

String getCountryName(String countryCode) {
  return countryNames[countryCode] ?? "Unknown";
}
