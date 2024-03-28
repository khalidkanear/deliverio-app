

class Vehicle{
  String? make,model,regNo, vehicleId;


  Vehicle({
     this.vehicleId,
     this.model,
     this.make,
     this.regNo
  });

}


class ProfileModel{



  String? riderId, firstName, lastName , profileImage ,  address , phoneNo, email , nricUrl, licenceUrl ;

  String? nric, licenceNo, bankAccountNo;
  Vehicle ?vehicle;
  bool ?isOnline;

  ProfileModel({

     this.firstName,
     this.lastName,
     this.profileImage,
     this.address,
     this.phoneNo,
     this.email,
     this.nric,
     this.licenceNo,
     this.bankAccountNo,
     this.riderId,
     this.vehicle,
     this.isOnline,
     this.licenceUrl,
     this.nricUrl

  });





}