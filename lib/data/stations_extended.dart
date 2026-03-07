import '../models/station.dart';
import '../utils/constants.dart';

/// Blue Branch Line stations (Yamuna Bank to Vaishali)
final List<Station> blueBranchStations = [
  const Station(id: 'bb_01', name: 'Yamuna Bank', nameHindi: 'यमुना बैंक', network: 'DMRC', lineId: LineIds.blueBranch, lineName: 'Blue Branch', lineColor: LineColors.blue, latitude: 28.6177, longitude: 77.2615, isInterchange: true, connectedLineIds: [LineIds.blue], stationOrder: 1),
  const Station(id: 'bb_02', name: 'Laxmi Nagar', nameHindi: 'लक्ष्मी नगर', network: 'DMRC', lineId: LineIds.blueBranch, lineName: 'Blue Branch', lineColor: LineColors.blue, latitude: 28.6313, longitude: 77.2755, stationOrder: 2),
  const Station(id: 'bb_03', name: 'Nirman Vihar', nameHindi: 'निर्माण विहार', network: 'DMRC', lineId: LineIds.blueBranch, lineName: 'Blue Branch', lineColor: LineColors.blue, latitude: 28.6374, longitude: 77.2832, stationOrder: 3),
  const Station(id: 'bb_04', name: 'Preet Vihar', nameHindi: 'प्रीत विहार', network: 'DMRC', lineId: LineIds.blueBranch, lineName: 'Blue Branch', lineColor: LineColors.blue, latitude: 28.6418, longitude: 77.2916, stationOrder: 4),
  const Station(id: 'bb_05', name: 'Karkarduma', nameHindi: 'करकरडूमा', network: 'DMRC', lineId: LineIds.blueBranch, lineName: 'Blue Branch', lineColor: LineColors.blue, latitude: 28.6530, longitude: 77.3085, stationOrder: 5),
  const Station(id: 'bb_06', name: 'Anand Vihar ISBT', nameHindi: 'आनंद विहार', network: 'DMRC', lineId: LineIds.blueBranch, lineName: 'Blue Branch', lineColor: LineColors.blue, latitude: 28.6468, longitude: 77.3159, stationOrder: 6),
  const Station(id: 'bb_07', name: 'Kaushambi', nameHindi: 'कौशाम्बी', network: 'DMRC', lineId: LineIds.blueBranch, lineName: 'Blue Branch', lineColor: LineColors.blue, latitude: 28.6426, longitude: 77.3236, stationOrder: 7),
  const Station(id: 'bb_08', name: 'Vaishali', nameHindi: 'वैशाली', network: 'DMRC', lineId: LineIds.blueBranch, lineName: 'Blue Branch', lineColor: LineColors.blue, latitude: 28.6409, longitude: 77.3381, stationOrder: 8),
];

/// Orange / Airport Express Line stations (New Delhi to Dwarka Sector 21)
final List<Station> orangeLineStations = [
  const Station(id: 'ol_01', name: 'New Delhi', nameHindi: 'नई दिल्ली', network: 'DMRC', lineId: LineIds.orange, lineName: 'Airport Express', lineColor: LineColors.orange, latitude: 28.6423, longitude: 77.2220, isInterchange: true, connectedLineIds: [LineIds.yellow], stationOrder: 1, locationType: 'underground'),
  const Station(id: 'ol_02', name: 'Shivaji Stadium', nameHindi: 'शिवाजी स्टेडियम', network: 'DMRC', lineId: LineIds.orange, lineName: 'Airport Express', lineColor: LineColors.orange, latitude: 28.6272, longitude: 77.2125, stationOrder: 2, locationType: 'underground'),
  const Station(id: 'ol_03', name: 'Dhaula Kuan', nameHindi: 'धौला कुआँ', network: 'DMRC', lineId: LineIds.orange, lineName: 'Airport Express', lineColor: LineColors.orange, latitude: 28.5907, longitude: 77.1608, stationOrder: 3),
  const Station(id: 'ol_04', name: 'Delhi Aerocity', nameHindi: 'दिल्ली एयरोसिटी', network: 'DMRC', lineId: LineIds.orange, lineName: 'Airport Express', lineColor: LineColors.orange, latitude: 28.5575, longitude: 77.1187, stationOrder: 4),
  const Station(id: 'ol_05', name: 'Terminal 1-IGI Airport', nameHindi: 'टर्मिनल 1-आई.जी.आई.', network: 'DMRC', lineId: LineIds.orange, lineName: 'Airport Express', lineColor: LineColors.orange, latitude: 28.5570, longitude: 77.0861, stationOrder: 5),
  const Station(id: 'ol_06', name: 'Dwarka Sector 21', nameHindi: 'द्वारका सेक्टर 21', network: 'DMRC', lineId: LineIds.orange, lineName: 'Airport Express', lineColor: LineColors.orange, latitude: 28.5521, longitude: 77.0581, isInterchange: true, connectedLineIds: [LineIds.blue], stationOrder: 6),
];

/// Grey Line stations (Dwarka to Najafgarh)
final List<Station> greyLineStations = [
  const Station(id: 'gr_01', name: 'Dwarka', nameHindi: 'द्वारका', network: 'DMRC', lineId: LineIds.grey, lineName: 'Grey Line', lineColor: LineColors.grey, latitude: 28.5938, longitude: 77.0161, isInterchange: true, connectedLineIds: [LineIds.blue], stationOrder: 1),
  const Station(id: 'gr_02', name: 'Nangli', nameHindi: 'नांगली', network: 'DMRC', lineId: LineIds.grey, lineName: 'Grey Line', lineColor: LineColors.grey, latitude: 28.5965, longitude: 76.9893, stationOrder: 2),
  const Station(id: 'gr_03', name: 'Najafgarh', nameHindi: 'नज़फ़गढ़', network: 'DMRC', lineId: LineIds.grey, lineName: 'Grey Line', lineColor: LineColors.grey, latitude: 28.6032, longitude: 76.9650, stationOrder: 3),
];

/// Aqua Line stations (Noida Sector 51 to Depot)
final List<Station> aquaLineStations = [
  const Station(id: 'aq_01', name: 'Noida Sector 51', nameHindi: 'नोएडा सेक्टर 51', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.5690, longitude: 77.3678, isInterchange: true, connectedLineIds: [LineIds.blue], stationOrder: 1),
  const Station(id: 'aq_02', name: 'Noida Sector 50', nameHindi: 'नोएडा सेक्टर 50', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.5650, longitude: 77.3730, stationOrder: 2),
  const Station(id: 'aq_03', name: 'Noida Sector 76', nameHindi: 'नोएडा सेक्टर 76', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.5680, longitude: 77.3854, stationOrder: 3),
  const Station(id: 'aq_04', name: 'Noida Sector 101', nameHindi: 'नोएडा सेक्टर 101', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.5619, longitude: 77.3923, stationOrder: 4),
  const Station(id: 'aq_05', name: 'Noida Sector 81', nameHindi: 'नोएडा सेक्टर 81', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.5560, longitude: 77.3990, stationOrder: 5),
  const Station(id: 'aq_06', name: 'NSEZ', nameHindi: 'एन.एस.ई.ज़ेड.', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.5490, longitude: 77.4113, stationOrder: 6),
  const Station(id: 'aq_07', name: 'Noida Sector 83', nameHindi: 'नोएडा सेक्टर 83', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.5430, longitude: 77.4186, stationOrder: 7),
  const Station(id: 'aq_08', name: 'Noida Sector 137', nameHindi: 'नोएडा सेक्टर 137', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.5360, longitude: 77.4274, stationOrder: 8),
  const Station(id: 'aq_09', name: 'Noida Sector 142', nameHindi: 'नोएडा सेक्टर 142', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.5280, longitude: 77.4410, stationOrder: 9),
  const Station(id: 'aq_10', name: 'Noida Sector 143', nameHindi: 'नोएडा सेक्टर 143', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.5220, longitude: 77.4479, stationOrder: 10),
  const Station(id: 'aq_11', name: 'Noida Sector 144', nameHindi: 'नोएडा सेक्टर 144', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.5170, longitude: 77.4556, stationOrder: 11),
  const Station(id: 'aq_12', name: 'Noida Sector 145', nameHindi: 'नोएडा सेक्टर 145', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.5123, longitude: 77.4625, stationOrder: 12),
  const Station(id: 'aq_13', name: 'Noida Sector 146', nameHindi: 'नोएडा सेक्टर 146', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.5070, longitude: 77.4698, stationOrder: 13),
  const Station(id: 'aq_14', name: 'Noida Sector 147', nameHindi: 'नोएडा सेक्टर 147', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.5020, longitude: 77.4760, stationOrder: 14),
  const Station(id: 'aq_15', name: 'Noida Sector 148', nameHindi: 'नोएडा सेक्टर 148', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.4990, longitude: 77.4830, stationOrder: 15),
  const Station(id: 'aq_16', name: 'Knowledge Park II', nameHindi: 'नॉलेज पार्क II', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.4802, longitude: 77.4881, stationOrder: 16),
  const Station(id: 'aq_17', name: 'Pari Chowk', nameHindi: 'परी चौक', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.4700, longitude: 77.4957, stationOrder: 17),
  const Station(id: 'aq_18', name: 'Alpha 1', nameHindi: 'अल्फा 1', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.4620, longitude: 77.5030, stationOrder: 18),
  const Station(id: 'aq_19', name: 'Delta 1', nameHindi: 'डेल्टा 1', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.4570, longitude: 77.5092, stationOrder: 19),
  const Station(id: 'aq_20', name: 'GNIDA Office', nameHindi: 'जी.एन.आई.डी.ए. ऑफ़िस', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.4500, longitude: 77.5156, stationOrder: 20),
  const Station(id: 'aq_21', name: 'Depot', nameHindi: 'डिपो', network: 'DMRC', lineId: 'aqua_line', lineName: 'Aqua Line', lineColor: '#00AAAD', latitude: 28.4450, longitude: 77.5201, stationOrder: 21),
];

/// Rapid Metro stations (Sikanderpur to Sector 55-56)
final List<Station> rapidMetroStations = [
  const Station(id: 'rm_01', name: 'Sikanderpur', nameHindi: 'सिकंदरपुर', network: 'DMRC', lineId: LineIds.rapid, lineName: 'Rapid Metro', lineColor: '#8B4513', latitude: 28.4800, longitude: 77.0895, isInterchange: true, connectedLineIds: [LineIds.yellow], stationOrder: 1),
  const Station(id: 'rm_02', name: 'Phase 1', nameHindi: 'फेज 1', network: 'DMRC', lineId: LineIds.rapid, lineName: 'Rapid Metro', lineColor: '#8B4513', latitude: 28.4720, longitude: 77.0790, stationOrder: 2),
  const Station(id: 'rm_03', name: 'Phase 2', nameHindi: 'फेज 2', network: 'DMRC', lineId: LineIds.rapid, lineName: 'Rapid Metro', lineColor: '#8B4513', latitude: 28.4680, longitude: 77.0720, stationOrder: 3),
  const Station(id: 'rm_04', name: 'Phase 3', nameHindi: 'फेज 3', network: 'DMRC', lineId: LineIds.rapid, lineName: 'Rapid Metro', lineColor: '#8B4513', latitude: 28.4630, longitude: 77.0650, stationOrder: 4),
  const Station(id: 'rm_05', name: 'Moulsari Avenue', nameHindi: 'मौलसरी एवेन्यू', network: 'DMRC', lineId: LineIds.rapid, lineName: 'Rapid Metro', lineColor: '#8B4513', latitude: 28.4580, longitude: 77.0580, stationOrder: 5),
  const Station(id: 'rm_06', name: 'Sector 42-43', nameHindi: 'सेक्टर 42-43', network: 'DMRC', lineId: LineIds.rapid, lineName: 'Rapid Metro', lineColor: '#8B4513', latitude: 28.4530, longitude: 77.0510, stationOrder: 6),
  const Station(id: 'rm_07', name: 'Sector 53-54', nameHindi: 'सेक्टर 53-54', network: 'DMRC', lineId: LineIds.rapid, lineName: 'Rapid Metro', lineColor: '#8B4513', latitude: 28.4490, longitude: 77.0440, stationOrder: 7),
  const Station(id: 'rm_08', name: 'Sector 54 Chowk', nameHindi: 'सेक्टर 54 चौक', network: 'DMRC', lineId: LineIds.rapid, lineName: 'Rapid Metro', lineColor: '#8B4513', latitude: 28.4450, longitude: 77.0370, stationOrder: 8),
  const Station(id: 'rm_09', name: 'Sector 55-56', nameHindi: 'सेक्टर 55-56', network: 'DMRC', lineId: LineIds.rapid, lineName: 'Rapid Metro', lineColor: '#8B4513', latitude: 28.4400, longitude: 77.0300, stationOrder: 9),
];
