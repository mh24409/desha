class CustomerData {
  String? name;
  String? address;
  String? distinctiveAddress;
  String? email;
  String? website;
  String? phoneNumber;
  int? customerTypeId;
  int? paymentTermId;
  int? governmentId;
  int? cityId;
  int? saleZoneId;
  double? lat;
  double? lng;
  String? image;

  CustomerData({
    this.name,
    this.address,
    this.distinctiveAddress,
    this.email,
    this.website,
    this.phoneNumber,
    this.customerTypeId,
    this.paymentTermId,
    this.governmentId,
    this.cityId,
    this.lat,
    this.lng,
    this.saleZoneId,
    this.image,
  });
}

class ResponsibleData {
  String name;
  String email;
  String phoneNumber;
  String workStartDay;
  String workEndDay;
  String workStartTime;
  String workEndTime;

  ResponsibleData({
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.workStartDay = '',
    this.workEndDay = '',
    this.workStartTime = '',
    this.workEndTime = '',
  });
}

class OwnerData {
  String name;
  String email;
  String phoneNumber;
  String workStartDay;
  String workEndDay;
  String workStartTime;
  String workEndTime;

  OwnerData({
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.workStartDay = '',
    this.workEndDay = '',
    this.workStartTime = '',
    this.workEndTime = '',
  });
}
