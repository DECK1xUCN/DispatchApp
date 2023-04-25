
class DailyUpdate {
  int id;
  bool wasFlight;
  String? delayCode;
  int? delayTime;
  String? delayDesc;
  bool maintenance;
  bool? plannedMaintenance;
  bool? unplannedMaintenance;
  bool? otherMaintenance;
  String? maintenanceNote;
  bool? baseAndEquipment;
  String? note;

  DailyUpdate({
    required this.id,
    required this.wasFlight,
    this.delayCode,
    this.delayTime,
    this.delayDesc,
    required this.maintenance,
    this.plannedMaintenance,
    this.unplannedMaintenance,
    this.otherMaintenance,
    this.maintenanceNote,
    this.baseAndEquipment,
    this.note,
  });

}
