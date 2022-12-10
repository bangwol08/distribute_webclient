<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>분산 워드카운팅</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    body {
      margin: 0;
      font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #E4EDC0;
    }
    .nav {
      background-color: #77B278;
      height: 50px;
      padding-top: 13px;
      padding-left: 15px;
      font-weight: bold;
      font-size: 20px;
      color: white;
      cursor: pointer;
    }
    #main_title {
      color: rgb(99, 99, 99);
      text-align: center;
    }
    #butt {
      margin: 0;
      padding: 0.5rem 1rem;
      margin-bottom: 50px;
      font-family: "Noto Sans KR", sans-serif;
      font-size: 1rem;
      font-weight: 400;
      text-align: center;
      text-decoration: none;
      background-color: #C2DC81;
      display: inline-block;
      width: auto;
      cursor: pointer;
      border: none;
      border-radius: 4px;
      color: rgb(99, 99, 99);
      font-size: 20px;
      font-weight: bold;
      box-shadow: 0 10px 35px rgba(0, 0, 0, 0.05), 0 6px 6px rgba(0, 0, 0, 0.1);
    }
    #butt_form {
      margin: auto;
      display: flex;
      text-align: center;
      padding-top: 100px;
      flex-direction: column;
      width: 400px;
      height: 600px;
    }
  </style>

  <script>
    function b(){
      location.href='./distribute_wordcounting.jsp';
      alert("처리상황에 따라 시간이 걸릴 수 있습니다.")
    }


  </script>
</head>
<body>
<div class="nav">
  WORD COUNTER
</div>
<h1 id="main_title">분산 워드카운팅</h1>
<div id="butt_form">
  <button id="butt" type="button" onclick="b()">분산 필터링 및 WordCounting 수행</button>
  <button id="butt" type="button" onclick="location.href='./result.jsp'">결과보기</button>
</div>
</body>
</html>
