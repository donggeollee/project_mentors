<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드</title>
</head>
<body>
	<h1>파일 업로드 예제</h1>
	<form method="post" action="upload" enctype="multipart/form-data">
		<label>email:</label> <input type="text" name="email"> <br>
		<br> <label>파일:</label> <input type="file" name="file1">
		<br>
		<br> <input type="submit" value="Upload">
	</form>

<!-- <input type="file" name="profile" onchange="miri(this);" multiple>
<img src="" id="img0">
<img src="" id="img1">
<img src="" id="img2"> -->

<!-- <input id="browse" type="file" onchange="previewFiles()" multiple>
<div id="preview"></div>


<script>
    function miri(tag){
        var reader = new FileReader();
        // files메서드는 배열로 반환되기 때문에 멀티파일도 처리가능하다.
        
        console.log(tag.files.length);
        
        for(var i = 0 ; i <= tag.files.length ; i++) {
        	reader.readAsDataURL(tag.files[i]);
            reader.onload = function() {
                // 여기서의 this는 reader객체
                console.log("img" + i);
                document.getElementById("img" + i).src = this.result;
            }
        }
    }
    
    function previewFiles() {

    	  var preview = document.querySelector('#preview');
    	  var files   = document.querySelector('input[type=file]').files;

    	  function readAndPreview(file) {

    	    // `file.name` 형태의 확장자 규칙에 주의하세요
    	    if ( /\.(jpe?g|png|gif)$/i.test(file.name) ) {
    	      var reader = new FileReader();

    	      reader.addEventListener("load", function () {
    	        var image = new Image();
    	        image.height = 100;
    	        image.title = file.name;
    	        image.src = this.result;
    	        preview.appendChild( image );
    	      }, false);

    	      reader.readAsDataURL(file);
    	    }

    	  }

    	  if (files) {
    	    [].forEach.call(files, readAndPreview);
    	  }

    	}
</script> -->

</body>
</html>