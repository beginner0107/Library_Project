<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>온라인 도서관 - 내서재</title>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles.css" rel="stylesheet" />
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath }/resources/css/styles2.css" rel="stylesheet" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/resources/js/comm.js"></script>
<style type="text/css">
	.table {
      border-collapse: collapse;
      border-top: 3px solid #168;
      width: 90%; 
      margin: auto;
    }  
	.table th {
      color: #168;
      background: #f0f6f9;
      text-align: center;
    }
    .table th, .table td {
      padding: 10px;
      border: 1px solid #ddd;
    }
    .table th:first-child, .table td:first-child {
      border-left: 0;
    }
    .table th:last-child, .table td:last-child {
      border-right: 0;
    }
    .table tr td:first-child{
      text-align: center;
    }
	body{font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;}
</style>
</head>
<body>
	<!-- Navigation-->
	<c:import url = "/WEB-INF/views/include/top_menu.jsp"/>	
	<!-- Page Content-->
    <div class="container px-4 px-lg-5">
    	<div class="row gx-4 gx-lg-5 align-items-center my-5">
            <div class="col-lg-5">
                <h1 class="font-weight-light">Library<br /> My Page</h1>
                	   <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">대여 도서 목록</li>
                        <li class="breadcrumb-item"><a href = "${pageContext.request.contextPath }/member/mypage_borrowedList">대여 했던 도서 목록</a></li>
        	     	   </ol>
                <p>
                ${mvo.username }님 안녕하세요! <br /> 
                ${mvo.username }님의 행복한 하루를 기원합니다.<br /> <br /> 
                저희 도서관은 정상 반납한 횟수와 연체 반납 횟수를 종합해 계산하여 회원님이 대여하실 수 있는 도서의 권수를 조정해드립니다.
                </p>
            </div>
        </div>
	   
        <!-- Heading Row-->

        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">대여 도서</h1><br><br>


       	<table class="table">
		<tr>
			<td colspan="5" class="info" style="text-align: right;">
				${pv.pageInfo }
				<script type="text/javascript">
					$(function(){
						$("#listCount").change(function(){
							var pageSize = $(this).val();
							SendPost("${pageContext.request.contextPath }/member/mypage", {"p":${cv.currentPage},"s":pageSize,"b":${cv.blockSize}});
						});	
					});
				</script>
				<select id="listCount">
					<option value="5" ${cv.pageSize==5 ? " selected='selected' " : "" }> 5개</option>
					<option value="10" ${cv.pageSize==10 ? " selected='selected' " : "" }>10개</option>
					<option value="20" ${cv.pageSize==20 ? " selected='selected' " : "" }>20개</option>
					<option value="30" ${cv.pageSize==30 ? " selected='selected' " : "" }>30개</option>
					<option value="50" ${cv.pageSize==50 ? " selected='selected' " : "" }>50개</option>
				</select>씩 보기	
			</td>
		</tr>
		<tr style="text-align: center">
			<th>회원 아이디</th>
			<th>isbn</th>
			<th>도서 제목</th>
			<th>빌린 날짜</th>
			<th>반납 예정 일</th>
		</tr>
		<c:if test="${pv.totalCount==0 }">
			<tr>
				<td colspan="5" class="info2">대여한 책이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${not empty pv.list }">
			<c:forEach var="vo" items="${pv.list }" varStatus="vs">
				<tr align="center">
					<td>
						<c:out value="${vo.userid}"></c:out>
					</td>
					<td>
						<c:out value="${vo.isbn}"></c:out>
					</td>
					<td>
						<c:out value="${vo.title}"></c:out>
					</td>
					<td>
						<fmt:formatDate value="${vo.rent_date}" type="date" dateStyle="short"/>
					</td>
					<td>
						<fmt:formatDate value="${vo.return_due_date}" type="date" dateStyle="short"/>
					</td>
				</tr>
			</c:forEach>
		<tr>
			<td style="border: none;text-align: center;" colspan="5">
				${pv.pageList }
			</td>
		</tr>
		</c:if>
	</table>	
	<!-- 검색 영역 -->
	   <div class="search_wrap" style="text-align: center;">
	    	<form id="searchForm" action="${pageContext.request.contextPath }/member/mypage" method="post">
	    	<div class="search_input">
		   	  	<select name = "type">
		    		<option value = "">--</option>
		    		<option value = "I">ISBN</option>
		    		<option value = "T">제목</option>
		    	</select>
	         <input type="text" name="keyword" id = "keyword" maxlength="50"/>
	         <button class='btn btn-primary btn-block'>검 색</button>                				
	   		</div>
	    	</form>
	    </div>
       </div>
                
                <div class="row gx-5 justify-content-center">
                <!-- 반납-->
                <div class="col-lg-6 col-xl-6">
                    <div class="card mb-5 mb-xl-0">
                        <div class="card-body p-10">
                            <div class="mb-3">
                                <span class="display-4 fw-bold"> 반납하기
                                </span>
                            </div>
                            <form action="${pageContext.request.contextPath }/member/return_bookOk" method="POST" onsubmit="return check();">
                          		
								${mvo.username }님 안녕하세요.<br/><br/>
								<label for="">반납하고자 하는 책의 ISBN</label>	
                                <div class="">
                                    <select class="form-control form-control-lg" id="isbn" name="isbn">
                                    
	                                    <c:forEach var="vo" items="${pv.list}">
		                                	<option>${vo.isbn} : ${vo.title }</option>
	                                	</c:forEach>
                                    </select>
                                </div>

                                <div class="mt-5 mb-0">
                                    <div class="d-grid">
                                        <input type="submit" class="btn btn-primary btn-block" value="반납하기" />
                                    </div>
                                </div>

                            </form>
                            
                            
                        </div>
                    </div>
                </div>
                <!-- 연장 -->
                <div class="col-lg-6 col-xl-6">
                    <div class="card mb-5 mb-xl-0">
                        <div class="card-body p-10">
                            <div class="mb-3">
                                <span class="display-4 fw-bold"> 연장하기
                                </span>
                            </div>
                            <form action="${pageContext.request.contextPath }/member/extension_book" method="POST" onsubmit="return check();">
                          		
								${mvo.username }님 안녕하세요.<br/><br/>
								<label for="">연장하고자 하는 책의 ISBN</label>	
                                <div class="">
                                    <select class="form-control form-control-lg" id="isbn" name="isbn">
                                    
	                                    <c:forEach var="vo" items="${pv.list}">
		                                    <c:if test="${vo.extension_count==0 }">
		                                		<option>${vo.isbn} : ${vo.title }</option>
		                                	</c:if>
	                                	</c:forEach>
                                    </select>
                                </div>
                                <label for="">연장하고자 일수 1~3</label>	
                                <div class="">
                                    <select class="form-control form-control-lg" id="extension_count" name="extension_count">
	                                		<option>1</option>
	                                		<option>2</option>
	                                		<option>3</option>
                                    </select>
                                </div>

                                <div class="mt-5 mb-0">
                                    <div class="d-grid">
                                        <input type="submit" class="btn btn-primary btn-block" value="연장하기" onclick = "extension();" />
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            </main>
       </div>
    </div>
<!-- Footer-->
<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
<script type="text/javascript">
	function extension(){
		var extenstion_count = parseInt($("#extension_count").val());
		if(extenstion_count>3){
			extension_count = 3;
			$("#extension_count").val(extension_count);
			alert('3일 연장 됩니다.');
		}
	}
	function check(){
		var isbn = $("#isbn").val();
		if(!isbn || isbn.trim().length() ==0){
			return false;
		}
	}
</script>
</body>
</html>