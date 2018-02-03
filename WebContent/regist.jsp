<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	var req;
	var doc;
	function getProvinces() {
		sendAjax();
	}
	function createAjax() {
		if (window.ActiveXObject) {
			req = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			req = new XMLHttpRequest;
		} else {
			alert("请使用IE或者FireFox内核的浏览器");
		}
	}
	function sendAjax() {
		createAjax();
		// 设置请求方式
		req.open("post", "city.xml", true);
		req.onreadystatechange = callBackMethod;
		req.send(null);
	}
	function callBackMethod() {
		if (req.readyState == 4) {
			doc = req.responseXML;
			showProvinces();
		}
	}
	function showProvinces() {
		addChooseOption("province");
		var provinces = doc.getElementsByTagName("province");
		appendOptions(provinces, "province");
	}
	function addChooseOption(id) {
		var select = document.getElementById(id);
		select.innerHTML = "";
		var chooseOpt = document.createElement("option");
		var chooseText = document.createTextNode("--请选择--");
		chooseOpt.value = "123";
		chooseOpt.appendChild(chooseText);
		select.appendChild(chooseOpt);
	}
	function appendOptions(arr, id) {
		var select = document.getElementById(id);
		for (var i = 0; i < arr.length; i++) {
			var cname = arr[i].attributes[0].value;
			var cid = arr[i].attributes[1].value;
			var opt = document.createElement("option");
			var text = document.createTextNode(cname);
			opt.appendChild(text);
			opt.value = cid;
			select.appendChild(opt);
		}
	}
	function getCities(c) {
		addChooseOption("city");
		addChooseOption("area");
		var cid = c.value;
		var provinces = doc.getElementsByTagName("province");
		for (var i = 0; i < provinces.length; i++) {
			if (provinces[i].attributes[1].value == cid) {
				var cities = provinces[i].getElementsByTagName("city");
				appendOptions(cities, "city");
			}
		}
	}

	function getAreas(obj) {
		addChooseOption("area");
		var pid = obj.value;
		var cities = doc.getElementsByTagName("city");
		for (var i = 0; i < cities.length; i++) {
			if (cities[i].attributes[1].value == pid) {
				var areas = cities[i].getElementsByTagName("area");
				appendOptions(areas, "area");
			}
		}
	}
</script>
</head>
<body onload="getProvinces()">
	<form action="" method="post">
		<p>
			所在城市：<br /> 
			省:<select name="province" id="province" style="width: 80px;" onchange="getCities(this)"></select> 
			市:<select name="city" id="city" onchange="getAreas(this)" style="width: 80px;"></select>
			区:<select name="area" id="area" style="width: 80px;"></select>
		</p>
	</form>
</body>
</html>
