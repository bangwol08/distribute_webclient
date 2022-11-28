<%@ page import="Host.HostController" %>
<%@ page import="DB.DBcontroller" %>
<%@ page import="java.io.*" %>
<%@ page import="Operation.RemoteWordCounting" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    //동작시간을 기록하기 위한 부분
    long beforeTime = System.currentTimeMillis(); //코드 시작전 시간 받아오기

    //실제 동작부분
    HostController HostInfo = new HostController();
    int hostCount = HostInfo.getHostCount();
    int connectCount = 0;
    HostController.HostInfo[] hosts_ConnectionInfo = HostInfo.getHostInfo();
    DBcontroller[] server_DBcontrol = new DBcontroller[hostCount];

    //서버별 컨트롤러 생성
    for(int i=0; i<hostCount; i++)
    {
        server_DBcontrol[i] = new DBcontroller(hosts_ConnectionInfo[i].serverName, hosts_ConnectionInfo[i].host,
                hosts_ConnectionInfo[i].dbPort, "distribute_database", hosts_ConnectionInfo[i].ID, hosts_ConnectionInfo[i].PW);
    }

    //DB연결 현황 확인
    for(int i=0; i<hostCount; i++)
    {
        //각 클래스의 conn이 null이 아니면 접속성공 간주
        if(server_DBcontrol[i].conn != null)
        {
            connectCount++;
        }
    }

    //연결된 DB가 하나도 없을시 메인메뉴로 돌아감
    if(connectCount==0)
    {
        out.println("<script> alert('모든 DB와 연결실패. DB상태를 다시 확인하세요'); history.back(); </script>");
    }
    else
    {
        //DB DELETE 수행
        for(int i=0; i<hostCount; i++)
        {
            if(server_DBcontrol[i].conn != null)
            {
                server_DBcontrol[i].deleteRawDataAll();
            }
        }

        //DB AUTO_INCREMENT 1로 초기화
        for(int i=0; i<hostCount; i++)
        {
            if(server_DBcontrol[i].conn != null)
            {
                server_DBcontrol[i].initIncrement();
            }
        }

        //DB INSERT 수행.
        try
        {
            //rawData 전체 라인 수 읽기
            String filePath = application.getRealPath("/WEB-INF/rawData.txt");
            BufferedReader countFile = new BufferedReader(new FileReader(filePath));

            int Totalline = 0;
            while(countFile.readLine() != null)
            {
                Totalline++;
            }

            //txt파일에서 한줄씩 읽어오면서 INSERT수행
            BufferedReader inFile = new BufferedReader(new FileReader(filePath));
            String lineString;
            int linePointer = 0;
            int dbPointer = 0;
            int connPointer = 1;
            while((lineString = inFile.readLine()) != null)
            {
                //sql에서 '를 인식하지 못하는 문제때문에 ''으로 문자열 재배치 후 INSERT 수행
                lineString = lineString.replace("\'", "\'\'").replace("\"", "\"\"");
                server_DBcontrol[dbPointer].insertData(lineString);
                linePointer++;
                if(connPointer == connectCount)
                {
                    while((lineString = inFile.readLine()) != null)
                    {
                        lineString = lineString.replace("\'", "\'\'").replace("\"", "\"\"");
                        server_DBcontrol[dbPointer].insertData(lineString);
                    }
                }

                if(linePointer == Totalline/connectCount)
                {
                    while(true)
                    {
                        dbPointer++;
                        if(server_DBcontrol[dbPointer].conn != null)
                        {
                            connPointer++;
                            break;
                        }
                    }
                    linePointer = 0;
                }
            }
            out.println("<script> alert('분산저장 성공!'); </script>");

            //워드카운팅 전 결과값DB삭제
            DBcontroller DBcontroller = new DBcontroller("resultDB","192.168.127.134", "3306", "distribute_database", "tempuser", "qwe123!@#");
            DBcontroller.deleteResultDataAll();

            //원격 워드카운팅 실행
            RemoteWordCounting remote = new RemoteWordCounting();
            int returnFlag = remote.doRemoteWordCounting();
            if(returnFlag==-1)
            {
                out.println("<script> alert('WordCounting 실패! 서버상태를 확인하세요.'); history.back(); </script>");
            }
            else if(returnFlag==0)
            {
                //종료후 시간 측정
                long afterTime = System.currentTimeMillis(); // 코드 실행 후에 시간 받아오기
                long secDiffTime = (afterTime - beforeTime)/1000; //두 시간에 차 계산
                long mDiffTime = (afterTime - beforeTime)%1000;
                //실행결과출력
                out.println("<script> alert('WordCounting 성공! 결과보기 페이지에서 결과값을 확인하세요.');  </script>");
                out.println("<script> alert('분산 워드카운팅 소요시간 : " + secDiffTime + "." +mDiffTime + "초'); history.back(); </script>");
            }
        }
        catch (IOException e)
        {
            out.println("<script> alert('raw데이터 찾기 오류!'); history.back(); </script>");
        }
    }
%>
</body>
</html>
