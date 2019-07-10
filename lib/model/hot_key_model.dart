class HotKeyModel {
	List<HotKeyEntity> data;
	int errorCode;
	String errorMsg;

	HotKeyModel({this.data, this.errorCode, this.errorMsg});

	factory HotKeyModel.fromJson(Map<String, dynamic> json) => HotKeyModel(
			data: (json['data'] as List)
					?.map((e) => e == null
					? null
					: HotKeyEntity.fromJson(e as Map<String, dynamic>))
					?.toList(),
			errorCode: json['errorCode'] as int,
			errorMsg: json['errorMsg'] as String);

	Map<String,dynamic> toJson()=> <String, dynamic>{
		'data': this.data,
		'errorCode': this.errorCode,
		'errorMsg': this.errorMsg
	};
}
class HotKeyEntity{
	int visible;
	String link;
	String name;
	int id;
	int order;

	HotKeyEntity({this.visible, this.link, this.name, this.id, this.order});

	HotKeyEntity.fromJson(Map<String, dynamic> json) {
		visible = json['visible'];
		link = json['link'];
		name = json['name'];
		id = json['id'];
		order = json['order'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['visible'] = this.visible;
		data['link'] = this.link;
		data['name'] = this.name;
		data['id'] = this.id;
		data['order'] = this.order;
		return data;
	}
}