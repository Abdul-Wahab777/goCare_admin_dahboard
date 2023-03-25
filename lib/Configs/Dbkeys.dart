// ignore: todo
//TODO:  WARNING:    DO NOT EDIT THIS PAGE UNLESS YOU ARE A DEVELOPER. THIS PAGE HAS ALL THE KEYS USED IN FIRESTORE DATABASE -----
import 'package:cloud_firestore/cloud_firestore.dart';

class Dbkeys {
  // PRIMARY ---------
  static final String countrywisedata = 'countrywisedata';
  static final String setup = 'setup';
  static final String automaticChecks = 'automaticChecks';
  static final String users = 'users';
  static final String staffs = 'staffs';
  static final String partners = 'partners';
  static final String admin = 'admin';
  static final String userapp = 'userapp';
  static final String staffapp = 'staffapp';
  static final String partnerapp = 'partnerapp';
  static final String adminapp = 'adminapp';

  static final String latestappversionandroid = 'latestappversionandroid';
  static final String latestappversionios = 'latestappversionios';
  static final String latestappversionweb = 'latestappversionweb';
  static final String latestappversionwindows = 'latestappversionwindows';
  static final String latestappversionmac = 'latestappversionmac';
  static final String appsettings = 'appsettings';

//-----Admin Key------
  static final String admincredentials = 'admincred';
  static final String adminphotourl = 'photourl';
  static final String adminpin = 'pin';
  static final String adminpassword = 'password';
  static final String adminemailid = 'emailid';
  static final String adminusername = 'username';
  static final String adminphone = 'phone';
  static final String admintoken = 'notificationtoken';
  static final String adminfullname = 'fullname';
  static final String adminloginhistory = 'list';
  static final String admincurrentdevice = 'currentdevice';
  static final String admindeviceslist = 'devicelist';
  static final String adminlogineventsTIME = 'tm';
  static final String adminlogineventsTITLE = 'ttl';
  static final String adminlogineventsDESC = 'dsc';
  static final String adminlogineventsLOCATIONGEOCORD = 'tloc';
  static final String adminlogineventsTITLEcredchange = 'credchng';

  static final String pROVIDERgoogle = 'google.com';
  static final String pROVIDEfacebook = 'facebook.com';
  static final String pROVIDEgooglefacebook = 'google.comfacebook.com';
  static final String pROVIDEfacebookgoogle = 'facebook.comgoogle.com';

  //---
  static final String uSERproviderid = 'providerid';
  static final String uSERrole = 'role';
  static final String uSERtimezoneinminutes = 'timezoneinminutes';
  static final String uSERisverfiedaccount = 'isverfiedaccount';
  static final String uSERfullname = 'nickname';
  static final String uSERemail = 'email';
  static final String uSERphone = 'phone';
  static final String uSERphonecountrycodenumber = 'phonecountrycodenumber';
  static final String uSERphonecountrycodename = 'phonecountrycodename';
  static final String uSERphotourl = 'photoUrl';
  static final String uSERsearchkey = 'searchkey';
  static final String uSERcountrycode = 'countryCode';
  static final String uSERphonesecondary = 'phonesecondary';

  static final String uSERuid = 'uid';
  static final String uSERlastlogin = 'lastlogin';
  static final String uSERjoinedon = 'joinedOn';
  static final String uSERlastseen = 'lastSeen';
  static final String uSERaccountcreatedon = 'accountcreatedon';
  static final String uSERandroidnotificationtoken = 'androidnotificationtoken';
  static final String uSERactionmessage = 'actionmessage';
  static final String uSERaccountstatus = 'accountstatus';
  static final String uSERnotificationtokenlist = 'notificationtokenlist';
  static final String uSERdevicelist = 'deviceDetails';
  //--

  //-
  static final String hISTORYtitle = 'title';
  static final String hISTORYdesc = 'desc';
  static final String hISTORYtimestamp = 'timestamp';
  static final String hISTORYcreatedby = 'createdby';
  static final String hISTORYcreatortype = 'creatortype';
  static final String hISTORYlevel = 'level';

  //-----
  static final String errorREASONissinglgeloginonly = 'issingleloginonly';
  static final String errorREASONdeviceisemulator = 'demulator';
  static final String errorREASONuserblocked = 'userblocked';
  static final String errorREASONuserpending = 'userpending';
  static final String errorREASONerror = 'error';
  static final String errorREASONundermaintainance = 'undermaintainance';
  static final String errorREASONupdaterequired = 'updaterequired';

  // Status--------
  static final String sTATUSblocked = 'blocked';
  static final String sTATUSallowed = 'allowed';
  static final String sTATUSpending = 'pending';
  static final String sTATUSverified = 'verified';
  static final String sTATUSdeleted = 'deleted';
  static final String sTATUSdone = 'done';

  static final String isphonenumbermandatorywhilelogin =
      'isphonenumbermandatorywhilelogin';
  static final String isphonenumberpreffered = 'isphonenumberpreffered';
  static final String isaccountapprovalbyadminneeded =
      'isaccountapprovalbyadminneeded';
  static final String accountapprovalmessage = 'accountapprovalmessage';
  static final String privacypolicy = 'ppl';
  static final String tnc = 'tnc';
  static final String tncTYPE = 'tncType';
  static final String privacypolicyTYPE = 'pplType';
  static final String url = 'url';
  static final String file = 'file';

  static final String isgeolocationprefered = 'isgeolocationprefered';
  static final String isgeolocationmandatory = 'isgeolocationmandatory';
  static final String isCollectDeviceInfoAndSavetoDatabase =
      'iscollectdeviceinfo';
  static final String isOnlySingleDeviceLoginAllowed =
      'isOnlySingleDeviceallow';
  static final String islocationeditallowed = 'isloceditalwd';
  static final String isemulatorallowed = 'isemlalwd';
  static final String iscallsallowed = 'iscallsallowed';
  static final String ismediamessageallowed = 'ismediamessageallowed';
  static final String istextmessageallowed = 'istextmessageallowed';
  static final String isadmobshow = 'isadmobshow';

  // SECONDARY ---------

  static final String newapplinkandroid = 'newapplinkandroid';
  static final String newapplinkios = 'newapplinkios';
  static final String newapplinkweb = 'newapplinkweb';
  static final String newapplinkwindows = 'newapplinkwindows';
  static final String newapplinkmac = 'newapplinkmac';
  // static final String newstaffapplink = 'newstaffapplink';
  // static final String newpartnerapplink = 'newpartnerapplink';
  // static final String newadminapplink = 'newadminapplink';

  static final String issetupdone = 'xhxaxftaft';
  static final String isupdatemandatory = 'isupdatemandatory';
  static final String isappunderconstructionandroid =
      'isappunderconstructionandroid';
  static final String isappunderconstructionios = 'isappunderconstructionios';
  static final String isappunderconstructionweb = 'isappunderconstructionweb';
  static final String isappunderconstructionmac = 'isappunderconstructionmac';
  static final String isappunderconstructionwindows =
      'isappunderconstructionwindows';
  static final String alloweddebuggersUID = 'alloweddebuggersUID';
  static final String isblocknewlogins = 'isblocknewlogins';
  static final String maintainancemessage = 'maintainancemessage';
  static final String isshowerrorlog = 'isshowerrorlog';

  static final String totalapprovedusers = 'totalapprovedusers';
  static final String totalblockedusers = 'totalblockedusers';
  static final String totalpendingusers = 'totalpendingusers';
  static final String totalapprovedstaffs = 'totalapprovedstaffs';
  static final String totalblockedstaffs = 'totalblockedstaffs';
  static final String totalpendingstaffs = 'totalpendingstaffs';
  static final String totalapprovedpartners = 'totalapprovedpartners';
  static final String totalblockedpartners = 'totalblockedpartners';
  static final String totalpendingpartners = 'totalpendingpartners';
  static final String totalvisitsANDROID = 'totalvisitsANDROID';
  static final String totalvisitsIOS = 'totalvisitsIOS';
  ////

  static final String audiocallsmade = 'audioCallMade';
  static final String videocallsmade = 'videoCallMade';
  static final String audioCallRecieved = 'audioCallRecieved';
  static final String videoCallRecieved = 'videoCallRecieved';
  static final String mssgSent = 'mssgSent';

  static final String mediamessagessent = 'mediamessagessent';

  // static final String totalsessions = 'totalsessions';

//------
  static final String alertISSOLVED = 'ais';
  static final String alertTITLE = 'at';
  static final String alertDESC = 'ad';
  static final String alertUSERSTYPE = 'aut';
  static final String alertUSERSUID = 'auid';
  static final String alertTIMESTAMP = 'ats';

  static final String dataTypeUSERS = 'dataTypeUSERS';
  static final String dataTypeSTAFFS = 'dataTypeSTAFFS';
  static final String dataTypePARTNERS = 'dataTypePARTNERS';
  static final String dataTypeNOTIFICATIONS = 'dataTypeNOTIFICATIONS';
  static final String dataTypeHISTORY = 'dataTypeHISTORY';
  static final String dataTypeCALLHISTORY = 'dataTypeCALLHISTORY';
  static final String dataTypeREPORTS = 'dataTypeREPORTS';

  //------------
  static final String list = 'list';
  static final String docid = 'docid';
  //------------

  static final String nOTIFICATIONisunseen = 'isunseen';
  static final String nOTIFICATIONxxauthor = 'author';
  static final String nOTIFICATIONxxtitle = 'title';
  static final String nOTIFICATIONxxdesc = 'desc';
  static final String nOTIFICATIONxxaction = 'action';
  static final String nOTIFICATIONxximageurl = 'imageurl';
  static final String nOTIFICATIONxxlastupdate = 'lastupdated';
  static final String nOTIFICATIONxxpagecomparekey = 'comparekey';
  static final String nOTIFICATIONxxpagecompareval = 'compareval';
  static final String nOTIFICATIONxxparentid = 'parentid';
  static final String nOTIFICATIONxxextrafield = 'extrafield';
  static final String nOTIFICATIONxxpagetype = 'pagetype';
  static final String nOTIFICATIONxxpageID = 'pageid';
  static final String nOTIFICATIONpagetypeAllDOCSNAPLIST = 'AllDOCSNAPLIST';
  static final String nOTIFICATIONpagetypeSingleDOCinDOCSNAPLIST =
      'SingleDOCinDOCSNAPLIST';
  static final String nOTIFICATIONpagetypeSingleLISTinDOCSNAP =
      'SingleLISTinDOCSNAP';
  static final String nOTIFICATIONpagecollection1 = 'collection1';
  static final String nOTIFICATIONpagedoc1 = 'doc1';
  static final String nOTIFICATIONpagecollection2 = 'collection2';
  static final String nOTIFICATIONpagedoc2 = 'doc2';
  static final String nOTIFICATIONtopic = 'topic';
//--
  static final String pageIDAllNotifications = 'AllNotifications';

  //-----
  static final String nOTIFICATIONactionNOPUSH = 'NOPUSH';
  static final String nOTIFICATIONactionPUSH = 'PUSH';

  //----
  static final String sharedPREFisLocationSkipped = 'isLocationSkipped';
  static final String sharedPREFisUpdateappSkipped = 'isUpdateappSkipped';
  static final String sharedPREFisPhoneSkipped = 'isPhoneSkipped';

  //------- device info
  static final String deviceInfoDEVICEID = 'Device ID';
  static final String deviceInfoOSID = 'Os ID';
  static final String deviceInfoMODEL = 'Model';
  static final String deviceInfoOSVERSION = 'OS version';
  static final String deviceInfoOS = 'OS type';
  static final String deviceInfoDEVICENAME = 'Device name';
  static final String deviceInfoMANUFACTURER = 'Manufacturer';
  static final String deviceInfoLOGINTIMESTAMP = 'Device login Time';
  static final String deviceInfoISPHYSICAL = 'Is Physical';

  //--
  static final String usersidesetupdone = 'usersidesetupdone';
  static final String adminsidesetupdone = 'adminsidesetupdone';

  // Status--------

  static final String totalusers = 'totalusers';

  //---
  static const String sortbyBLOCKED = 'All Blocked';
  static const String sortbyPENDING = 'All Pending';
  static const String sortbyAPPROVED = 'All Approved';
  static const String sortbyALLUSERS = 'All Users';
  static const String sortbyUSERSONLINE = 'Online Users';

//--
  static final String topicUSERS = 'USERS';
  static final String topicADMIN = 'ADMIN';
  static final String topicUSERSandroid = 'USERS-ANDROID';
  static final String topicUSERSios = 'USERS-IOS';
  static final String topicUSERSweb = 'USERS-WEB';

//-added in update-
  static final String isCallFeatureTotallyHide = 'isCallFeatureTotallyHide';
  static final String maxFileSizeAllowedInMB = 'maxFileSizeAllowedInMB';
  static final String is24hrsTimeformat = 'is24hrsTimeformat';
  static final String isPercentProgressShowWhileUploading =
      'isPercentProgressShowWhileUploading';

  static final String isAllowCreatingGroups = 'isAllowCreatingGroups';
  static final String isAllowCreatingBroadcasts = 'isAllowCreatingBroadcasts';
  static final String isAllowCreatingStatus = 'isAllowCreatingStatus';
  static final String groupMemberslimit = 'groupmemberslimit';
  static final String statusDeleteAfterInHours = 'statusDeleteAfterInHours';
  static final String broadcastMemberslimit = 'broadcastMemberslimit';
  static final String feedbackEmail = 'feedbackEmail';
  static final String isLogoutButtonShowInSettingsPage =
      'isLogoutButtonShowInSettingsPage';
  static final String updateV7done = 'updateV7done';
  static final String maxNoOfFilesInMultiSharing = 'maxNoOfFilesInMultiSharing';
  static final String maxNoOfContactsSelectForForward =
      'maxNoOfContactsSelectForForward';
  static final String appShareMessageStringAndroid =
      'appShareMessageStringAndroid';
  static final String appShareMessageStringiOS = 'appShareMessageStringiOS';
  static final String isCustomAppShareLink = 'isCustomAppShareLink';
  static final String lastupdatedepoch = 'lue';
}

// WARNING:    DO NOT EDIT THIS ----
const String K1 = 'Z7y0En20wq543K050273Y520t50';
const String K2 = '07X2DC2WGH566y9402Y3';
const String K3 = '92r0083EGW024E3F42v3df28lW1';
const String K4 = '102';
const String K5 = '32050394';
const String K6 = 'J4tr28z9Ci4856';
const String K7 = 's384tvrhd74fnacs3r92gt3urv';
const String K8 = "Fiberchat";
const String K9 = "appsettings";
const String K11 = 'adminapp';
final k12 = FirebaseFirestore.instance
    .collection(Dbkeys.appsettings)
    .doc(Dbkeys.adminapp);
const K13 = 'Admin App';
