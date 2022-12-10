<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>
        RESULT
    </title>
    <meta charset="utf-8">
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
        }
        #butt {
            margin: 0;
            padding: 0.5rem 1rem;
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
            display: block;
            text-align: center;
            padding-top: 40px;
        }
        .image {
            margin: auto;
            display: block;
            text-align: center;
            height: 500px;
            padding-top: 40px;
            width: 700px;
            border-radius: 3%;
            border-style: solid 0px;
            background-color: white;
        }
        .items {
            padding-top: 50px;
        }
        #text {
            font-family: "Noto Sans KR", sans-serif;
            font-weight: bold;
            color: rgb(99, 99, 99);
            font-size: 20px;
        }
        .data {
            padding-top: 45px;
        }
        .datas {
            margin: auto;
            display: block;
            padding-top: 20px;
            text-align: center;
            background-color: white;
            width: 700px;
            font-family: "Noto Sans KR", sans-serif;
            border-radius: 10px;
        }
        #word {
            padding: 10px;
            padding-left: 60px;
            padding-right: 60px;
            background-color: #C2DC81;
            border-radius: 5px;
            color: rgb(99, 99, 99);
            font-weight: bold;
            font-size: 20px;
        }
        #count {
            padding: 10px;
            padding-left: 60px;
            padding-right: 60px;
            background-color: #C2DC81;
            border-radius: 5px;
            color: rgb(99, 99, 99);
            font-weight: bold;
            font-size: 20px;
        }
        .data_count {
            margin: 0;
            padding: 0;
            width: 350px;
            float: left;
        }
        .data_word {
            margin: 0;
            padding: 0;
            width: 350px;
            float: left;
        }
    </style>
</head>

<body>
<%
    String ip = "192.168.127.134";
    String port = "3306";
    String databaseName = "distribute_database";
    String driver = "org.mariadb.jdbc.Driver";
    String DB_URL = "jdbc:mariadb://" + ip + ":" + port + "/" + databaseName;
    String DB_USER ="tempuser";
    String DB_PASSWD = "qwe123!@#";
    String sql = "SELECT * from resultData order by count desc";
    Statement stmt = null;
    ResultSet rs = null;
    Connection conn = null;

    try
    {
        Class.forName(driver);
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWD);

        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);
    }
    catch (ClassNotFoundException e)
    {
        e.printStackTrace();
        System.exit(1);
    }
    catch (SQLException e)
    {
        e.printStackTrace();
    }
%>
<div class="nav">
    RESULT
</div>
<div class="items">
    <div class="image">
        <a id="text">Word Cloud</a><br>
        <img src="./images/wordcloud.png"/>

    </div>
</div>
<div class="data">
    <div class="datas">
        <a id="word">WORD</a>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a id="count">COUNT</a><br><br>
        <% while (rs.next()) {%>
        <div class="data_word"><%= rs.getString("word") %></div>
        <div class="data_count"><%= rs.getString("count") %></div><br><br><hr><br>
        <% } %>
    </div>
</div>
</body>
</html>