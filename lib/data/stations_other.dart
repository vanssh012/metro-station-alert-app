import '../models/station.dart';
import '../utils/constants.dart';

/// Red Line key stations (Rithala to Shaheed Sthal New Bus Adda)
final List<Station> redLineStations = [
  const Station(id: 'rl_01', name: 'Rithala', nameHindi: 'रिठाला', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.7208, longitude: 77.1092, stationOrder: 1),
  const Station(id: 'rl_02', name: 'Rohini West', nameHindi: 'रोहिणी वेस्ट', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.7146, longitude: 77.1153, stationOrder: 2),
  const Station(id: 'rl_03', name: 'Rohini East', nameHindi: 'रोहिणी ईस्ट', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.7062, longitude: 77.1241, stationOrder: 3),
  const Station(id: 'rl_04', name: 'Pitam Pura', nameHindi: 'पीतम पुरा', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6997, longitude: 77.1314, stationOrder: 4),
  const Station(id: 'rl_05', name: 'Kohat Enclave', nameHindi: 'कोहाट एन्क्लेव', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6950, longitude: 77.1373, stationOrder: 5),
  const Station(id: 'rl_06', name: 'Netaji Subhash Place', nameHindi: 'नेताजी सुभाष प्लेस', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6896, longitude: 77.1486, isInterchange: true, connectedLineIds: [LineIds.pink], stationOrder: 6),
  const Station(id: 'rl_07', name: 'Shakti Nagar', nameHindi: 'शक्ति नगर', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6821, longitude: 77.1534, stationOrder: 7),
  const Station(id: 'rl_08', name: 'Pratap Nagar', nameHindi: 'प्रताप नगर', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6774, longitude: 77.1619, stationOrder: 8),
  const Station(id: 'rl_09', name: 'Shastri Nagar', nameHindi: 'शास्त्री नगर', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6741, longitude: 77.1755, stationOrder: 9),
  const Station(id: 'rl_10', name: 'Inder Lok', nameHindi: 'इंदर लोक', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6719, longitude: 77.1838, isInterchange: true, connectedLineIds: [LineIds.green], stationOrder: 10),
  const Station(id: 'rl_11', name: 'Kanhaiya Nagar', nameHindi: 'कन्हैया नगर', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6734, longitude: 77.1928, stationOrder: 11),
  const Station(id: 'rl_12', name: 'Keshav Puram', nameHindi: 'केशव पुरम', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6722, longitude: 77.2023, stationOrder: 12),
  const Station(id: 'rl_13', name: 'Tri Nagar', nameHindi: 'त्रि नगर', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6704, longitude: 77.2088, stationOrder: 13),
  const Station(id: 'rl_14', name: 'Pulbangash', nameHindi: 'पुल बंगश', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6687, longitude: 77.2147, stationOrder: 14),
  const Station(id: 'rl_15', name: 'Tis Hazari', nameHindi: 'तीस हज़ारी', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6674, longitude: 77.2189, stationOrder: 15),
  const Station(id: 'rl_16', name: 'Kashmere Gate', nameHindi: 'कश्मीरी गेट', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6675, longitude: 77.2275, isInterchange: true, connectedLineIds: [LineIds.yellow, LineIds.violet, LineIds.pink], stationOrder: 16),
  const Station(id: 'rl_17', name: 'Shastri Park', nameHindi: 'शास्त्री पार्क', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6717, longitude: 77.2456, stationOrder: 17),
  const Station(id: 'rl_18', name: 'Seelampur', nameHindi: 'सीलमपुर', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6726, longitude: 77.2564, stationOrder: 18),
  const Station(id: 'rl_19', name: 'Welcome', nameHindi: 'वेलकम', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6755, longitude: 77.2664, isInterchange: true, connectedLineIds: [LineIds.pink], stationOrder: 19),
  const Station(id: 'rl_20', name: 'Shahdara', nameHindi: 'शाहदरा', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6725, longitude: 77.2867, stationOrder: 20),
  const Station(id: 'rl_21', name: 'Mansarovar Park', nameHindi: 'मानसरोवर पार्क', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6709, longitude: 77.2984, stationOrder: 21),
  const Station(id: 'rl_22', name: 'Jhilmil', nameHindi: 'झिल मिल', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6746, longitude: 77.3107, stationOrder: 22),
  const Station(id: 'rl_23', name: 'Dilshad Garden', nameHindi: 'दिलशाद गार्डन', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6809, longitude: 77.3175, stationOrder: 23),
  const Station(id: 'rl_24', name: 'Shaheed Sthal', nameHindi: 'शहीद स्थल', network: 'DMRC', lineId: LineIds.red, lineName: 'Red Line', lineColor: LineColors.red, latitude: 28.6903, longitude: 77.3227, stationOrder: 24),
];

/// Violet Line key stations (Kashmere Gate to Raja Nahar Singh)
final List<Station> violetLineStations = [
  const Station(id: 'vl_01', name: 'Kashmere Gate', nameHindi: 'कश्मीरी गेट', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.6675, longitude: 77.2275, isInterchange: true, connectedLineIds: [LineIds.yellow, LineIds.red, LineIds.pink], stationOrder: 1),
  const Station(id: 'vl_02', name: 'Lal Quila', nameHindi: 'लाल किला', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.6560, longitude: 77.2390, stationOrder: 2, locationType: 'underground'),
  const Station(id: 'vl_03', name: 'Jama Masjid', nameHindi: 'जामा मस्जिद', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.6491, longitude: 77.2375, stationOrder: 3, locationType: 'underground'),
  const Station(id: 'vl_04', name: 'Delhi Gate', nameHindi: 'दिल्ली गेट', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.6411, longitude: 77.2397, stationOrder: 4, locationType: 'underground'),
  const Station(id: 'vl_05', name: 'ITO', nameHindi: 'आई.टी.ओ.', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.6305, longitude: 77.2400, stationOrder: 5, locationType: 'underground'),
  const Station(id: 'vl_06', name: 'Mandi House', nameHindi: 'मंडी हाउस', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.6259, longitude: 77.2346, isInterchange: true, connectedLineIds: [LineIds.blue], stationOrder: 6, locationType: 'underground'),
  const Station(id: 'vl_07', name: 'Janpath', nameHindi: 'जनपथ', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.6195, longitude: 77.2209, stationOrder: 7, locationType: 'underground'),
  const Station(id: 'vl_08', name: 'Central Secretariat', nameHindi: 'केंद्रीय सचिवालय', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.6149, longitude: 77.2118, isInterchange: true, connectedLineIds: [LineIds.yellow], stationOrder: 8, locationType: 'underground'),
  const Station(id: 'vl_09', name: 'Khan Market', nameHindi: 'खान मार्केट', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.6000, longitude: 77.2278, stationOrder: 9, locationType: 'underground'),
  const Station(id: 'vl_10', name: 'JLN Stadium', nameHindi: 'जे.एल.एन. स्टेडियम', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.5862, longitude: 77.2336, stationOrder: 10),
  const Station(id: 'vl_11', name: 'Jangpura', nameHindi: 'जंगपुरा', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.5795, longitude: 77.2408, stationOrder: 11),
  const Station(id: 'vl_12', name: 'Lajpat Nagar', nameHindi: 'लाजपत नगर', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.5694, longitude: 77.2417, isInterchange: true, connectedLineIds: [LineIds.pink], stationOrder: 12),
  const Station(id: 'vl_13', name: 'Moolchand', nameHindi: 'मूलचंद', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.5624, longitude: 77.2394, stationOrder: 13),
  const Station(id: 'vl_14', name: 'Kailash Colony', nameHindi: 'कैलाश कॉलोनी', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.5523, longitude: 77.2364, stationOrder: 14),
  const Station(id: 'vl_15', name: 'Nehru Place', nameHindi: 'नेहरू प्लेस', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.5458, longitude: 77.2488, stationOrder: 15),
  const Station(id: 'vl_16', name: 'Kalkaji Mandir', nameHindi: 'कालकाजी मंदिर', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.5443, longitude: 77.2572, isInterchange: true, connectedLineIds: [LineIds.magenta], stationOrder: 16),
  const Station(id: 'vl_17', name: 'Govind Puri', nameHindi: 'गोविंदपुरी', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.5328, longitude: 77.2651, stationOrder: 17),
  const Station(id: 'vl_18', name: 'Harkesh Nagar Okhla', nameHindi: 'हरकेश नगर ओखला', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.5252, longitude: 77.2707, stationOrder: 18),
  const Station(id: 'vl_19', name: 'Jasola Apollo', nameHindi: 'जसोला अपोलो', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.5190, longitude: 77.2828, stationOrder: 19),
  const Station(id: 'vl_20', name: 'Sarita Vihar', nameHindi: 'सरिता विहार', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.5138, longitude: 77.2898, stationOrder: 20),
  const Station(id: 'vl_21', name: 'Mohan Estate', nameHindi: 'मोहन एस्टेट', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.5013, longitude: 77.3011, stationOrder: 21),
  const Station(id: 'vl_22', name: 'Tughlakabad', nameHindi: 'तुगलकाबाद', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.4919, longitude: 77.3076, stationOrder: 22),
  const Station(id: 'vl_23', name: 'Badarpur Border', nameHindi: 'बदरपुर बॉर्डर', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.4838, longitude: 77.3046, stationOrder: 23),
  const Station(id: 'vl_24', name: 'Sarai', nameHindi: 'सराय', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.4704, longitude: 77.3094, stationOrder: 24),
  const Station(id: 'vl_25', name: 'NHPC Chowk', nameHindi: 'एन.एच.पी.सी. चौक', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.4617, longitude: 77.3101, stationOrder: 25),
  const Station(id: 'vl_26', name: 'Mewala Maharajpur', nameHindi: 'मेवला महाराजपुर', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.4499, longitude: 77.3130, stationOrder: 26),
  const Station(id: 'vl_27', name: 'Sector 28', nameHindi: 'सेक्टर 28', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.4380, longitude: 77.3173, stationOrder: 27),
  const Station(id: 'vl_28', name: 'Badkal Mor', nameHindi: 'बड़कल मोड़', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.4303, longitude: 77.3120, stationOrder: 28),
  const Station(id: 'vl_29', name: 'Old Faridabad', nameHindi: 'पुरानी फ़रीदाबाद', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.4185, longitude: 77.3063, stationOrder: 29),
  const Station(id: 'vl_30', name: 'Neelam Chowk Ajronda', nameHindi: 'नीलम चौक अजरोंदा', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.4109, longitude: 77.3103, stationOrder: 30),
  const Station(id: 'vl_31', name: 'Bata Chowk', nameHindi: 'बाटा चौक', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.4012, longitude: 77.3104, stationOrder: 31),
  const Station(id: 'vl_32', name: 'Escorts Mujesar', nameHindi: 'एस्कॉर्ट्स मुजेसर', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.3909, longitude: 77.3065, stationOrder: 32),
  const Station(id: 'vl_33', name: 'Raja Nahar Singh', nameHindi: 'राजा नाहर सिंह', network: 'DMRC', lineId: LineIds.violet, lineName: 'Violet Line', lineColor: LineColors.violet, latitude: 28.3830, longitude: 77.3148, stationOrder: 33),
];

/// Namo Bharat RRTS key stations (Delhi–Meerut corridor)
final List<Station> rrtsStations = [
  const Station(id: 'rr_01', name: 'Sarai Kale Khan', nameHindi: 'सराय काले खान', network: 'NCRTC', lineId: LineIds.rrtsMeerut, lineName: 'Namo Bharat RRTS', lineColor: LineColors.rrtsMeerut, latitude: 28.5901, longitude: 77.2491, stationOrder: 1),
  const Station(id: 'rr_02', name: 'New Ashok Nagar RRTS', nameHindi: 'न्यू अशोक नगर', network: 'NCRTC', lineId: LineIds.rrtsMeerut, lineName: 'Namo Bharat RRTS', lineColor: LineColors.rrtsMeerut, latitude: 28.5929, longitude: 77.3095, stationOrder: 2),
  const Station(id: 'rr_03', name: 'Anand Vihar RRTS', nameHindi: 'आनंद विहार', network: 'NCRTC', lineId: LineIds.rrtsMeerut, lineName: 'Namo Bharat RRTS', lineColor: LineColors.rrtsMeerut, latitude: 28.6468, longitude: 77.3159, stationOrder: 3),
  const Station(id: 'rr_04', name: 'Sahibabad RRTS', nameHindi: 'साहिबाबाद', network: 'NCRTC', lineId: LineIds.rrtsMeerut, lineName: 'Namo Bharat RRTS', lineColor: LineColors.rrtsMeerut, latitude: 28.6731, longitude: 77.3401, stationOrder: 4),
  const Station(id: 'rr_05', name: 'Ghaziabad RRTS', nameHindi: 'ग़ाज़ियाबाद', network: 'NCRTC', lineId: LineIds.rrtsMeerut, lineName: 'Namo Bharat RRTS', lineColor: LineColors.rrtsMeerut, latitude: 28.6692, longitude: 77.4140, stationOrder: 5),
  const Station(id: 'rr_06', name: 'Guldhar RRTS', nameHindi: 'गुलधर', network: 'NCRTC', lineId: LineIds.rrtsMeerut, lineName: 'Namo Bharat RRTS', lineColor: LineColors.rrtsMeerut, latitude: 28.6809, longitude: 77.4450, stationOrder: 6),
  const Station(id: 'rr_07', name: 'Duhai RRTS', nameHindi: 'दुहाई', network: 'NCRTC', lineId: LineIds.rrtsMeerut, lineName: 'Namo Bharat RRTS', lineColor: LineColors.rrtsMeerut, latitude: 28.6979, longitude: 77.4758, stationOrder: 7),
  const Station(id: 'rr_08', name: 'Duhai Depot RRTS', nameHindi: 'दुहाई डिपो', network: 'NCRTC', lineId: LineIds.rrtsMeerut, lineName: 'Namo Bharat RRTS', lineColor: LineColors.rrtsMeerut, latitude: 28.7093, longitude: 77.4855, stationOrder: 8),
  const Station(id: 'rr_09', name: 'Muradnagar RRTS', nameHindi: 'मुरादनगर', network: 'NCRTC', lineId: LineIds.rrtsMeerut, lineName: 'Namo Bharat RRTS', lineColor: LineColors.rrtsMeerut, latitude: 28.7785, longitude: 77.5023, stationOrder: 9),
  const Station(id: 'rr_10', name: 'Modi Nagar South RRTS', nameHindi: 'मोदी नगर साउथ', network: 'NCRTC', lineId: LineIds.rrtsMeerut, lineName: 'Namo Bharat RRTS', lineColor: LineColors.rrtsMeerut, latitude: 28.8164, longitude: 77.5715, stationOrder: 10),
  const Station(id: 'rr_11', name: 'Modi Nagar North RRTS', nameHindi: 'मोदी नगर नॉर्थ', network: 'NCRTC', lineId: LineIds.rrtsMeerut, lineName: 'Namo Bharat RRTS', lineColor: LineColors.rrtsMeerut, latitude: 28.8469, longitude: 77.5819, stationOrder: 11),
  const Station(id: 'rr_12', name: 'Meerut South RRTS', nameHindi: 'मेरठ साउथ', network: 'NCRTC', lineId: LineIds.rrtsMeerut, lineName: 'Namo Bharat RRTS', lineColor: LineColors.rrtsMeerut, latitude: 28.9242, longitude: 77.6401, stationOrder: 12),
  const Station(id: 'rr_13', name: 'Meerut Central RRTS', nameHindi: 'मेरठ सेंट्रल', network: 'NCRTC', lineId: LineIds.rrtsMeerut, lineName: 'Namo Bharat RRTS', lineColor: LineColors.rrtsMeerut, latitude: 28.9689, longitude: 77.6863, stationOrder: 13),
  const Station(id: 'rr_14', name: 'Meerut North RRTS', nameHindi: 'मेरठ नॉर्थ', network: 'NCRTC', lineId: LineIds.rrtsMeerut, lineName: 'Namo Bharat RRTS', lineColor: LineColors.rrtsMeerut, latitude: 28.9918, longitude: 77.6982, stationOrder: 14),
];

/// Green Line key stations
final List<Station> greenLineStations = [
  const Station(id: 'gl_01', name: 'Brigadier Hoshiar Singh', nameHindi: 'ब्रिगेडियर होशियार सिंह', network: 'DMRC', lineId: LineIds.green, lineName: 'Green Line', lineColor: LineColors.green, latitude: 28.6793, longitude: 77.1068, stationOrder: 1),
  const Station(id: 'gl_02', name: 'Madipur', nameHindi: 'मादीपुर', network: 'DMRC', lineId: LineIds.green, lineName: 'Green Line', lineColor: LineColors.green, latitude: 28.6749, longitude: 77.1163, stationOrder: 2),
  const Station(id: 'gl_03', name: 'Shivaji Park', nameHindi: 'शिवाजी पार्क', network: 'DMRC', lineId: LineIds.green, lineName: 'Green Line', lineColor: LineColors.green, latitude: 28.6724, longitude: 77.1287, stationOrder: 3),
  const Station(id: 'gl_04', name: 'Punjabi Bagh', nameHindi: 'पंजाबी बाग', network: 'DMRC', lineId: LineIds.green, lineName: 'Green Line', lineColor: LineColors.green, latitude: 28.6692, longitude: 77.1312, stationOrder: 4),
  const Station(id: 'gl_05', name: 'Ashok Park Main', nameHindi: 'अशोक पार्क मेन', network: 'DMRC', lineId: LineIds.green, lineName: 'Green Line', lineColor: LineColors.green, latitude: 28.6672, longitude: 77.1461, stationOrder: 5),
  const Station(id: 'gl_06', name: 'Satguru Ram Singh Marg', nameHindi: 'सतगुरु राम सिंह मार्ग', network: 'DMRC', lineId: LineIds.green, lineName: 'Green Line', lineColor: LineColors.green, latitude: 28.6624, longitude: 77.1536, stationOrder: 6),
  const Station(id: 'gl_07', name: 'Kirti Nagar', nameHindi: 'कीर्ति नगर', network: 'DMRC', lineId: LineIds.green, lineName: 'Green Line', lineColor: LineColors.green, latitude: 28.6554, longitude: 77.0701, isInterchange: true, connectedLineIds: [LineIds.blue], stationOrder: 7),
  const Station(id: 'gl_08', name: 'Inder Lok', nameHindi: 'इंदर लोक', network: 'DMRC', lineId: LineIds.green, lineName: 'Green Line', lineColor: LineColors.green, latitude: 28.6719, longitude: 77.1838, isInterchange: true, connectedLineIds: [LineIds.red], stationOrder: 8),
];

/// Magenta Line key stations
final List<Station> magentaLineStations = [
  const Station(id: 'mg_01', name: 'Botanical Garden', nameHindi: 'बोटैनिकल गार्डन', network: 'DMRC', lineId: LineIds.magenta, lineName: 'Magenta Line', lineColor: LineColors.magenta, latitude: 28.5646, longitude: 77.3345, isInterchange: true, connectedLineIds: [LineIds.blue], stationOrder: 1),
  const Station(id: 'mg_02', name: 'Okhla Bird Sanctuary', nameHindi: 'ओखला बर्ड सैंक्चुअरी', network: 'DMRC', lineId: LineIds.magenta, lineName: 'Magenta Line', lineColor: LineColors.magenta, latitude: 28.5542, longitude: 77.3193, stationOrder: 2),
  const Station(id: 'mg_03', name: 'Kalkaji Mandir', nameHindi: 'कालकाजी मंदिर', network: 'DMRC', lineId: LineIds.magenta, lineName: 'Magenta Line', lineColor: LineColors.magenta, latitude: 28.5443, longitude: 77.2572, isInterchange: true, connectedLineIds: [LineIds.violet], stationOrder: 3),
  const Station(id: 'mg_04', name: 'Okhla NSIC', nameHindi: 'ओखला एन.एस.आई.सी.', network: 'DMRC', lineId: LineIds.magenta, lineName: 'Magenta Line', lineColor: LineColors.magenta, latitude: 28.5368, longitude: 77.2618, stationOrder: 4),
  const Station(id: 'mg_05', name: 'Sukhdev Vihar', nameHindi: 'सुखदेव विहार', network: 'DMRC', lineId: LineIds.magenta, lineName: 'Magenta Line', lineColor: LineColors.magenta, latitude: 28.5285, longitude: 77.2583, stationOrder: 5),
  const Station(id: 'mg_06', name: 'Jamia Millia Islamia', nameHindi: 'जामिया मिल्लिया इस्लामिया', network: 'DMRC', lineId: LineIds.magenta, lineName: 'Magenta Line', lineColor: LineColors.magenta, latitude: 28.5253, longitude: 77.2684, stationOrder: 6),
  const Station(id: 'mg_07', name: 'Jasola Vihar Shaheen Bagh', nameHindi: 'जसोला विहार शाहीन बाग', network: 'DMRC', lineId: LineIds.magenta, lineName: 'Magenta Line', lineColor: LineColors.magenta, latitude: 28.5270, longitude: 77.2828, stationOrder: 7),
  const Station(id: 'mg_08', name: 'Hauz Khas', nameHindi: 'हौज़ खास', network: 'DMRC', lineId: LineIds.magenta, lineName: 'Magenta Line', lineColor: LineColors.magenta, latitude: 28.5434, longitude: 77.2054, isInterchange: true, connectedLineIds: [LineIds.yellow], stationOrder: 8, locationType: 'underground'),
  const Station(id: 'mg_09', name: 'Panchsheel Park', nameHindi: 'पंचशील पार्क', network: 'DMRC', lineId: LineIds.magenta, lineName: 'Magenta Line', lineColor: LineColors.magenta, latitude: 28.5370, longitude: 77.2160, stationOrder: 9, locationType: 'underground'),
  const Station(id: 'mg_10', name: 'Chirag Delhi', nameHindi: 'चिराग़ दिल्ली', network: 'DMRC', lineId: LineIds.magenta, lineName: 'Magenta Line', lineColor: LineColors.magenta, latitude: 28.5332, longitude: 77.2217, stationOrder: 10, locationType: 'underground'),
  const Station(id: 'mg_11', name: 'Greater Kailash', nameHindi: 'ग्रेटर कैलाश', network: 'DMRC', lineId: LineIds.magenta, lineName: 'Magenta Line', lineColor: LineColors.magenta, latitude: 28.5354, longitude: 77.2331, stationOrder: 11, locationType: 'underground'),
  const Station(id: 'mg_12', name: 'Nehru Enclave', nameHindi: 'नेहरू एन्क्लेव', network: 'DMRC', lineId: LineIds.magenta, lineName: 'Magenta Line', lineColor: LineColors.magenta, latitude: 28.5365, longitude: 77.2441, stationOrder: 12, locationType: 'underground'),
  const Station(id: 'mg_13', name: 'Janakpuri West', nameHindi: 'जनकपुरी पश्चिम', network: 'DMRC', lineId: LineIds.magenta, lineName: 'Magenta Line', lineColor: LineColors.magenta, latitude: 28.6286, longitude: 77.0046, isInterchange: true, connectedLineIds: [LineIds.blue], stationOrder: 13),
];

/// Combined list of all "other" line stations
final List<Station> otherLineStations = [
  ...redLineStations,
  ...violetLineStations,
  ...greenLineStations,
  ...magentaLineStations,
  ...rrtsStations,
];
