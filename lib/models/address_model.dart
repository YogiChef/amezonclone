class AddressModel {
  String? name;
  String? phone;
  String? street;
  String? homeaddress;
  String? district;
  String? city;
  String? country;
  String? completeAddess;
  String? zipcode;

  AddressModel(
      {this.name,
      this.phone,
      this.street,
      this.homeaddress,
      this.district,
      this.city,
      this.country,
      this.zipcode,
      this.completeAddess});

  AddressModel.formJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    street = json['street'];
    homeaddress = json['homeaddress'];
    district = json['district'];
    city = json['city'];
    country = json['country'];
    zipcode = json['zipcode'];
    completeAddess = json['completeAddess'];
  }
}
