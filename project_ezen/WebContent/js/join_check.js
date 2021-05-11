
function getByteLength(tobj, size, dispObj){

   var ls_str     =  tobj.value;	// 이벤트가 일어난 컨트롤의 value 값
   var li_str_len =  ls_str.length;	// 전체길이

   // 변수초기화
   var li_max      =  size;		// 제한할 글자수 크기
   var i           =  0;		// for문에 사용
   var li_byte     =  0;		// 한글일경우는 2 그밗에는 1을 더함
   var li_len      =  0;		// substring하기 위해서 사용
   var ls_one_char =  "";		// 한글자씩 검사한다

	for(i= 0; i< li_str_len; i++) {
		// 한글자추출
		ls_one_char =  ls_str.charAt(i);

		// 한글이면 2를 더한다.
		if (escape(ls_one_char).length > 4) {
			li_byte =  li_byte+2;
		} else {
			li_byte++;
		}

		// 전체 크기가 li_max를 넘지않으면
		if(li_byte <=  li_max) {
			li_len =  i + 1;
		}
	}

	// 전체길이를 초과하면
	if(li_byte > li_max) {
		alert( li_max + " 글자를 초과 입력할수 없습니다. \n 초과된 내용은 자동으로 삭제 됩니다. ");
		tobj.value =  ls_str.substr(0, li_len);
	}

	// 입력된 글자byte수 출력
	if (dispObj != null) {
		if (typeof(dispObj) == "string") {
			dispObj	= document.all[dispObj];
		}
		if (dispObj != null) {
			dispObj.innerText	= (tobj.value.length+(escape(tobj.value)+"%u").match(/%u/g).length-1);
		}
	}
	tobj.focus();
}

function checkNumber(tobj) {
	var str = tobj.value;
	var str_len = str.length;
	var flag = true;

	if (str_len > 0) { 
		for (i = 0; i < str_len; i++) { 
			if (str.charAt(i) < '0' || str.charAt(i) > '9') { 
				flag = false;
			} 
		} 
	}

	if (!flag) {
		alert("숫자만 입력가능합니다.");
		// tobj.value = str.substring(0,str_len-1);
		tobj.value = "0";
		tobj.focus();
	} 
}

function checkInt(tobj) {
	var nochk='01234567890'
	for (i=0; i<tobj.length; i++){
		if(nochk.indexOf(tobj.substring(i,i+1)) < 0){
			return false;
		}
	}
}

function checkFloat(tobj) {
	var nochk='01234567890.'
	for (i=0; i<tobj.length; i++){
		if(nochk.indexOf(tobj.substring(i,i+1)) < 0){
			return false;
		}
	}
}

function checkNumberHour(tobj) {
	var str = tobj.value;
	var str_len = str.length;
	var flag = true;

	if (str_len > 0) { 
		for (i = 0; i < str_len; i++) { 
			if (str.charAt(i) < '0' || str.charAt(i) > '9') { 
				flag = false;
			} 
		} 
	}

	if (str > 24) { 
		flag = false;
	}

	if (!flag) {
		alert("숫자만 입력가능하며 24이하만 입력 가능합니다.");
		tobj.value = "";
		tobj.focus();
	} 
}


function chkMgtPrdNm(tobj,ObjNm){
	var str = tobj.value;
	var str_len = str.length;
	var htmlChar = str.replace("\'", "");

	if(-1 < str.indexOf("\'") || -1 < str.indexOf("\"")){
			alert("["+ObjNm+"]에는 따옴표를 입력하실 수 없습니다.");

			htmlChar = htmlChar.replace("\"", "");

			tobj.value = htmlChar;
			tobj.focus();
			return false;
	}

	if(!(str.indexOf("<") == -1 ) || !(str.indexOf(">") == -1 )) {
			alert("["+ObjNm+"]에 Tag를 입력할 수 없습니다.");
			htmlChar = htmlChar.replace("<", "");
			htmlChar = htmlChar.replace(">", "");

			tobj.value = htmlChar;
			tobj.focus();
			return false;
	}

	return true;
}

// 이메일 주소 앞 뒷부분을 체크하는 부분(a ~ z 의 소문자와 0~9까지의 숫자와 '.'만 허용
function CheckEmailTail(str) { 
	strarr = new Array(str.length); 
	var flag = true; 
	for (i=0; i<str.length; i++) { 
		strarr[i] = str.charAt(i) 
		if (!((strarr[i]>='a')&&(strarr[i]<='z')||(strarr[i]>='0')&&(strarr[i]<='9')||(strarr[i]=='.')||(strarr[i]=='_')||(strarr[i]=='-'))) { 
			flag = false; 
		} 
	}
	if (flag) {
		return true; 
	} else {
		return false; 
	} 
} 

function CheckCharNumEng(Data) {
	var nochk='01234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

	for (i=0; i<Data.length; i++){
		if(nochk.indexOf(Data.substring(i,i+1)) < 0) {		return false;		}
	}
}

function moveNext (num, from, to) {
	var len = from.value.length;
	if (len == num)
		to.focus ();
}

function EmptyChk(str){
	var strValue = "";
	var strLen = 0;
	strValue = str.replace(/(^\s*)|(\s*$)/g,"");
	strLen = strValue.length;

	return strLen;
}

// 사업자등록번호 체크
function fChkSuppNo(suppno) {
	var sum = 0;
	var getlist =new Array(10);
	var chkvalue =new Array("1","3","7","1","3","7","1","3","5");
	for(var i=0; i<10; i++) { getlist[i] = suppno.substring(i, i+1); }
	for(var i=0; i<9; i++) { sum += getlist[i]*chkvalue[i]; }
	
	sum = sum + parseInt((getlist[8]*5)/10);
	sidliy = sum % 10;
	sidchk = 0;
    
	if(sidliy != 0) { sidchk = 10 - sidliy; }
	else { sidchk = 0; }

	if(sidchk != getlist[9]) { return false; }
	return true;
}

// 이메일 주소 체크
function email_chk(val) {
    var t = val;
	var ValidFlag = false;
	var atCount = 0;
	var SpecialFlag;
	var atLoop;
	var atChr;
	var BadFlag;
	var tAry1;
	var UserName;
	var DomainName;

	if ( t.length > 0 && t.indexOf("@") > 0 && t.indexOf(".") > 0 ) {
		atCount = 0
		SpecialFlag = false

		for( atLoop=1; atLoop<=t.length; atLoop++ ) {
			atChr = t.substring( atLoop, atLoop+1 )
			if ( atChr == "@" ) atCount = atCount + 1

			if ( (atChr >= 32) && (atChr <= 44) ) SpecialFlag = true 
			if ( (atChr == 47) || (atChr == 96) || (atChr >= 123) ) SpecialFlag = true 
			if ( (atChr >= 58) && (atChr <= 63) ) SpecialFlag = true 
			if ( (atChr >= 91) && (atChr <= 94) ) SpecialFlag = true 
		}

		if ( ( atCount == 1 ) && (SpecialFlag == false ) ) {
			BadFlag = false
			tAry1 = t.split("@")
			UserName = tAry1[0]
			DomainName = tAry1[1]
			if ( (UserName.length <= 0 ) || (DomainName.length <= 0 ) ) BadFlag = true
			if ( DomainName.substring( 1, 2 ) == "." ) BadFlag = true
			if ( DomainName.substring( DomainName.length-1, DomainName.length) == "." ) BadFlag = true
			ValidFlag = true
		}
	}
	if ( BadFlag == true ) ValidFlag = false
	return ValidFlag
}
