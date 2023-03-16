// Define the necessary classes to describe a simple Electroinc Health Record containing:
// - the patient information such as birthday, sex
// - heart rate data (full series of data and average of the specific day)
// - sequence of weight and height data
// - drugs (time of intake, quantity and note)
// Write a main function instantiating a EHR, filling it with some data and showing the summary of the current state
// of the patient ie. the latest data available in each category

// generic class for generic health data
abstract class HealthData {
  DateTime timestamp;
  HealthData(this.timestamp);
}

// class defining a patient and its characteristics
class Patient {
  DateTime birthday;
  String sex;
  String name;
  Patient(this.birthday, this.sex, this.name);

  @override
  String toString() {
    return '$name ($sex) born on: $birthday';
  }
}

// class defining the heart rate data for a specific day, it extends the generic health data
class HeartRate extends HealthData {
  List<int> hr;
  int average;
  HeartRate(this.hr, DateTime day)
      // in the constructor we automatically calculate the average HR of the day using the list as input
      // we use the reduce method on the list which sums all the elements in the list and then we devide
      // it by the length of the list
      : this.average =
            hr.reduce((value, element) => value + element) ~/ hr.length,
        super(day);

  // the toString method is overridden from the Object superclass to print a string describing the class object
  @override
  String toString() {
    return 'Heart rate average on $timestamp is $average';
  }
}

class Height extends HealthData {
  double cm;
  Height(this.cm, super.timestamp);

  @override
  String toString() {
    return 'On $timestamp the height was $cm cm';
  }
}

class Weight extends HealthData {
  double kg;
  Weight(this.kg, super.timestamp);

  @override
  String toString() {
    return 'On $timestamp the weight was $kg kg';
  }
}

class DrugIntake extends HealthData {
  int quantity;
  String name;
  DrugIntake(super.timestamp, this.quantity, this.name);

  @override
  String toString() {
    return 'Drug $name ($quantity) taken on $timestamp';
  }
}

// class defining the EHR containing the patient and all its data
class EHR {
  Patient patient;
  List<Height> heightSeries = [];
  List<DrugIntake> drugs = [];
  List<Weight> weigthSeries = [];
  List<HeartRate> hrSeries = [];

  // base constructor
  EHR(this.patient);

  /// named constructor with some baseline data to be inserted at the creation of the EHR
  EHR.withInfo(this.patient, {Weight? weight, Height? height}) {
    if (weight != null) this.weigthSeries.add(weight);
    if (height != null) this.heightSeries.add(height);
  }

  /// method to insert a new drug intake
  void addDrug(DrugIntake newDrug) {
    drugs.add(newDrug);
  }

  void addWeight(Weight newWeight) {
    weigthSeries.add(newWeight);
  }

  void addHeight(Height newHeight) {
    heightSeries.add(newHeight);
  }

  /// method to add an HR data and returning the average for the day
  int addHR(HeartRate hr) {
    hrSeries.add(hr);
    return hr.average;
  }

  @override
  String toString() {
    return 'EHR of ${patient} \nLatest drug: ${drugs.last}\nLatest weight: ${weigthSeries.last}\nLatest average HR: ${hrSeries.last}';
  }
}

void main(List<String> args) {
  // creation of a new EHR
  EHR ehr = EHR(Patient(DateTime(2000, 01, 01), 'M', 'Mario'));
  
  // add some data
  ehr.addDrug(DrugIntake(DateTime.now(), 1, 'Tachipirina'));
  ehr.addWeight(Weight(73, DateTime.now().subtract(Duration(days: 5))));
  ehr.addWeight(Weight(75, DateTime.now()));
  ehr.addHeight(Height(173, DateTime.now().subtract(Duration(days: 5))));
  ehr.addHeight(Height(175, DateTime.now()));
  int avg = ehr.addHR(
      HeartRate(List.generate(10, (index) => 60 + index), DateTime.now()));
  // print the average of the HR
  print(avg);
  // print the summary of the current EHR
  print(ehr);
}
