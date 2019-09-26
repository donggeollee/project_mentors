<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역 검색</title>
</head>
<body>

<script type="text/javascript">
var sojaeji = new Array(); 
		 	
         sojaeji['시도']='강원,경기,경남,경북,광주,대구,대전,부산,서울,세종,울산,인천,전남,전북,제주,충남,충북';
         sojaeji['강원']='강릉,고성군,동해,삼척,속초,양구군,양양군,영월군,원주,인제군,정선군,철원군,춘천,태백,평창군,홍천군,화천군,횡성군';
         sojaeji['경기']='가평군,고양시덕양구,고양 ,고양 ,과천,광명,광주,구리,군포,김포,남양주,동두천,부천 소사구,부천 오정구,부천 원미구,성남 분당구,성남 수정구,성남 중원구,수원 권선구,수원 영통구,수원 장안구,수원 팔달구,시흥 ,안산 단원구,안산 상록구,안성 ,안양 동안구,안양 만안구,양주,양평군,여주군,연천군,오산,용인시기흥구,용인 수지구,용인 처인구,의왕,의정부,이천,파주,평택,포천,하남,화성';
         sojaeji['경남']='거제,거창군,고성군,김해,남해군,밀양,사천,산청군,양산,의령군,진주,창녕군,창원 마산합포구,창원 마산회원구,창원 성산구,창원 의창구,창원 진해구,통영,하동군,함안군,함양군,합천군';
         sojaeji['경북']='경산,경주,고령군,구미,군위군,김천,문경,봉화군,상주,성주군,안동,영덕군,영양군,영주,영천,예천군,울릉군,울진군,의성군,청도군,청송군,칠곡군,포항시남구,포항시북구';
         sojaeji['광주']='광산구,남구,동구,북구,서구';
         sojaeji['대구']='남구,달서구,달성군,동구,북구,서구,수성구,중구';
         sojaeji['대전']='대덕구,동구,서구,유성구,중구';
         sojaeji['부산']='강서구,금정구,기장군,남구,동구,동래구,부산진구,북구,사상구,사하구,서구,수영구,연제구,영도구,중구,해운대구';
         sojaeji['서울']='강남구,강동구,강북구,강서구,관악구,광진구,구로구,금천구,노원구,도봉구,동대문구,동작구,마포구,서대문구,서초구,성동구,성북구,송파구,양천구,영등포구,용산구,은평구,종로구,중구,중랑구';
         sojaeji['세종']='';
         sojaeji['울산']='남구,동구,북구,울주군,중구';
         sojaeji['인천']='강화군,계양구,남구,남동구,동구,부평구,서구,연수구,옹진군,중구';
         sojaeji['전남']='강진군,고흥군,곡성군,광양,구례군,나주,담양군,목포,무안군,보성군,순천,신안군,여수,영광군,영암군,완도군,장성군,장흥군,진도군,함평군,해남군,화순군';
         sojaeji['전북']='고창군,군산,김제,남원,무주군,부안군,순창군,완주군,익산,임실군,장수군,전주시덕진구,전주시완산구,정읍,진안군';
         sojaeji['제주']='서귀포,이어도,제주';
         sojaeji['충남']='계룡,공주,금산군,논산,당진,보령,부여군,서산,서천군,아산,예산군,천안시동남구,천안시서북구,청양군,태안군,홍성군';
         sojaeji['충북']='괴산군,단양군,보은군,영동군,옥천군,음성군,제천시,증평군,진천군,청원군,청주시상당구,청주시흥덕구,충주';
         
         function sidochange() 
         {
                 var f = document.ftest;
                 gugunview(f.sido.value);
         }
     
         function gugunchange() 
         {
                 var f = document.ftest;
         }
     
         function sidoview()
         {
                 var f = document.ftest;
     
                 f.sido.options.length = 1;
                 f.sido.options[0].text = "시/도(전체)";
                 sojae = sojaeji["시도"].split(",");
                 f.sido.options.length = sojae.length+1;
                 for (i=0; i<sojae.length; i++) {
                         f.sido.options[i+1].value = sojae[i];
                         f.sido.options[i+1].text = sojae[i];
                 }
         }
         function gugunview(sido)
         {
                 var f = document.ftest;
     
                 f.gugun.options.length = 1;
                 f.gugun.options[0].text = "시/군/구(전체)";
                 f.gugun.options[0].selected = true;
                 if (!sido) {
                         return;
                 }
                 if( sido == "시/도(전체)"){
                	 return;
                 }
     			sojae = sojaeji[sido].split(",");
                 f.gugun.options.length = sojae.length+1;
                 for (i=0; i<sojae.length; i++) {
                         f.gugun.options[i+1].value = sojae[i];
                         f.gugun.options[i+1].text = sojae[i];
                 }
         }
          
  </script>       
          
<form name='ftest' method='get'>
<select name='sido' id="sido" onchange="sidochange()"></select><select name='gugun' id="gugun" onchange="gugunchange()"></select>
</form>
<script type="text/javascript"> <%-- language="JavaScript" --%>
    sidoview();
    gugunview("");
</script>


</body>
</html>