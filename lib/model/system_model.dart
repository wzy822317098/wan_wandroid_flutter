class SystemModel {
	List<SystemEntity> data;
	int errorCode;
	String errorMsg;

	SystemModel({this.data, this.errorCode, this.errorMsg});

	factory SystemModel.fromJson(Map<String, dynamic> json) => SystemModel(
			data: (json['data'] as List)
					?.map((e) => e == null
					? null
					: SystemEntity.fromJson(e as Map<String, dynamic>))
					?.toList(),
			errorCode: json['errorCode'] as int,
			errorMsg: json['errorMsg'] as String);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['errorCode'] = this.errorCode;
		data['errorMsg'] = this.errorMsg;
		return data;
	}
}

class SystemEntity {
	int visible;
	List<SystemEntity> children;
	String name;
	bool userControlSetTop;
	int id;
	int courseId;
	int parentChapterId;
	int order;

	SystemEntity({this.visible, this.children, this.name, this.userControlSetTop, this.id, this.courseId, this.parentChapterId, this.order});

	SystemEntity.fromJson(Map<String, dynamic> json)  {
		visible = json['visible'];
		children=(json['children'] as List)
				?.map((e) => e == null
				? null
				: SystemEntity.fromJson(e as Map<String, dynamic>))
				?.toList();
		name = json['name'];
		userControlSetTop = json['userControlSetTop'];
		id = json['id'];
		courseId = json['courseId'];
		parentChapterId = json['parentChapterId'];
		order = json['order'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['visible'] = this.visible;
		if (this.children != null) {
      data['children'] =  this.children.map((v) => v.toJson()).toList();
    }
		data['name'] = this.name;
		data['userControlSetTop'] = this.userControlSetTop;
		data['id'] = this.id;
		data['courseId'] = this.courseId;
		data['parentChapterId'] = this.parentChapterId;
		data['order'] = this.order;
		return data;
	}
}
