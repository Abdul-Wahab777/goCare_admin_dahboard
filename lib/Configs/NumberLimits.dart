class Numberlimits {
  static int adminusername = 15;
  static int adminpin = 6;
  static int adminfullname = 25;
  static int adminpassword = 15;
  //--
  static DateTime defaultvalidtilltime = DateTime(3999, 01, 01);
  static int totalDatatoLoadAtOnceFromFirestore = 14;
  static int maxcurrencydigits = 9;
  static int maxcategoryiddigits = 3;
  static int maxproductiddigits = 17;
  static int maxsubcategoryiddigits = 4;
  static double maskopacity = 0.6;
  static double defaultclipradius = 6.0;
  static int maxtitledigits = 90;
  static int maxuiddigits = 90;
  static int maxcategorydescdigits = 90;
  static int maxcategorydigits = 40;
  static int maxnamedigits = 40;
  static int maxcategorytaglinedigits = 25;
  static int maxsubcategorydigits = 25;
  static int maxaddressdigits = 100;
  static int maxphonedigits = 15;
  static int maxemaildigits = 40;
  static int maxurldigits = 500;
  static int maxdescdigits = 1500;
  static int maxanydigits = 10;
  static int maxcoupondigits = 10;
  static int maxorderiddigits = 12;
  static int mincoupondigits = 3;
  static int maxsubtitledigits = 370;
  static int maxparagraphdigits = 1000;
  static int imageCompressQuality = 30;
  static int maxproductgalleryphotos = 9;
  static int maxproducscreenshots = 16;
  static int imageCompressRotationAngle = 0;
  static int maxVideoFileUpload =
      50; // in MB ----This value can be overide by anywidget having specific max upload size
  static int maxPDFFileUpload =
      5; // in MB ----This value can be overide by anywidget having specific max upload size
  static int maxImageFileUpload =
      5; // in MB ----This value can be overide by anywidget having specific max upload size
  static int maxZIPFileUpload =
      500; // in MB ----This value can be overide by anywidget having specific max upload size

  static String maxFileSizeExceededError1 =
      'Sorry! File size for upload should be less than:';
  static String maxFileSizeExceededError2 =
      'Please Compress the file & Try again.';

  static int totaltxnXns =
      200; // total transactions recordes for safety. After this number, old will get automatically deleted
  static int totalhistory =
      200; // total history recorder for activity. After this number, old will get automatically deleted
}
