class HttpBannerEntity {
	List<BannerEntity> data;
	int errorCode;
	String errorMsg;

	HttpBannerEntity({this.data, this.errorCode, this.errorMsg});

	factory HttpBannerEntity.fromJson(Map<String, dynamic> json) =>
			HttpBannerEntity(
					data: (json['data'] as List)
							?.map((e) => e == null
							? null
							: BannerEntity.fromJson(e as Map<String, dynamic>))
							?.toList(),
					errorCode: json['errorCode'] as int,
					errorMsg: json['errorMsg'] as String);

	Map<String, dynamic> toJson() =>  <String, dynamic>{
		'data': this.data,
		'errorCode': this.errorCode,
		'errorMsg': this.errorMsg
	};
}

class BannerEntity {
	String imagePath;
	int id;
	int isVisible;
	String title;
	int type;
	String url;
	String desc;
	int order;

	BannerEntity({this.imagePath, this.id, this.isVisible, this.title, this.type, this.url, this.desc, this.order});

	BannerEntity.fromJson(Map<String, dynamic> json) {
		imagePath = json['imagePath'];
		id = json['id'];
		isVisible = json['isVisible'];
		title = json['title'];
		type = json['type'];
		url = json['url'];
		desc = json['desc'];
		order = json['order'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['imagePath'] = this.imagePath;
		data['id'] = this.id;
		data['isVisible'] = this.isVisible;
		data['title'] = this.title;
		data['type'] = this.type;
		data['url'] = this.url;
		data['desc'] = this.desc;
		data['order'] = this.order;
		return data;
	}
}
