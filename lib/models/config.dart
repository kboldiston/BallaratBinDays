class Config {
  static final String appTitle = "Bin Days";
  static final String endpoint = "https://data.gov.au/api/action/datastore_search_sql?_=1598533050128&sql=";
  static final String query = "SELECT * from \"23be1fc4-b6ef-4013-9102-c014c9d48711\" where lower(address) LIKE '{1}%' limit 5";
}