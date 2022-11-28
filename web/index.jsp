<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>분산 워드카운팅</title>
    <script>
      function a()
      {
        location.href='distribute_wordcounting.jsp';
        alert("데이터량에 따라 시간이 걸릴 수 있습니다.")
      }
    </script>
  </head>
  <body>
  <h1>분산 워드카운팅</h1>
  <button type="button" onclick="location.href='./upload_rawData.jsp'">분석데이터 업로드</button>
  <button type="button" onclick="a()">WordCounting 수행</button>
  <button type="button" onclick="location.href='./result.jsp'">결과보기</button>
  </body>
</html>
