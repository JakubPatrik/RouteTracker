
class Track {

	int _id;
	String _date;
	String _route;

	Track(  this._date,this._route);

	int get id => _id;

	String get date => _date;
	String get route => _route;

	set date(String date) => this.date = date;
	// Convert a Note object into a Map object
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['date'] = _date;
		map['route'] = route;
		return map;
	}

	// Extract a Note object from a Map object
	Track.fromMapObject(Map<String, dynamic> map) {
		this._date = map['date'];
		this._route = map['route'];
	}
}









