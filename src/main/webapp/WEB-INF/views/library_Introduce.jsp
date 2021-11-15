<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여기에는 제목</title>
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
<script type="text/javascript">
   $(function(){
   
   });
</script>
</head>
<body>
<!-- Navigation-->
	<c:import url = "/WEB-INF/views/include/top_menu.jsp"/>	
	<br><br>
   <!-- App features section-->
    <section id="features">
        <div class="container px-5">
            <div class="row gx-5 align-items-center">
                <div class="col-lg-8 order-lg-1 mb-5 mb-lg-0">
                    <div class="container-fluid px-5">
                        <div class="row gx-5">
                            <div class="col-md-6 mb-5">
                                <!-- Feature item-->
                                <div class="text-center">
                                    <img src="${pageContext.request.contextPath }/resources/assets/img/book.png" alt="..." style="height: 5rem" />
                                    <h3 class="font-alt">Reading, Search</h3>
                                    <p class="text-muted mb-0">종합목록 검색 시스템을 구축하여 원스톱 자료 검색 서비스를 운영</p>
                                </div>
                            </div>
                            <div class="col-md-6 mb-5">
                                <!-- Feature item-->
                                <div class="text-center">
                                    <img src="${pageContext.request.contextPath }/resources/assets/img/good.png" alt="..." style="height: 5rem" />
                                    <h3 class="font-alt">Reading, Culture</h3>
                                    <p class="text-muted mb-0">독서에 대한 관심을 높이기 위한 <br/>사서 추천 도서 및 신작 도서 정보 제공</p>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-5 mb-md-0">
                                <!-- Feature item-->
                                <div class="text-center">
                                    <img src="${pageContext.request.contextPath }/resources/assets/img/noticeboard.png" alt="..." style="height: 5rem" />
                                    <h3 class="font-alt">Reading, Communication</h3>
                                    <p class="text-muted mb-0">도서를 읽고 후기 작성!<br/>자유게시판을 통한 회원들 간의 소통</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <!-- Feature item-->
                                <div class="text-center">
                                    <img src="${pageContext.request.contextPath }/resources/assets/img/open-book.png" alt="..." style="height: 5rem" />
                                    <h3 class="font-alt">Reading, Dream</h3>
                                    <p class="text-muted mb-0">원하는 도서가 없다면 <br/>직접 도서관에 신청 가능</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <br><br>
    <!-- Basic features section-->
    <section class="bg-light">
        <div class="container px-5">
            <div class="row gx-5 align-items-center justify-content-center justify-content-lg-between">
                <div class="col-12 col-lg-5">
                    <h2 class="display-4 lh-1 mb-4">Enter a new age of web Library</h2>
                    <p class="lead fw-normal text-muted mb-5 mb-lg-0">읽고 싶은 도서를 직접 신청하고, 읽은 도서에 대한 <br/>후기를 작성 해 다른 회원들과 감상을 나누며 <br/>책에 대한 경험을 배로 얻어보세요.</p>
                </div>
                <div class="col-sm-8 col-md-6">
                	
                    <div class="px-5 px-sm-0"><img class="img-fluid rounded-circle" src="https://source.unsplash.com/u8Jn2rzYIps/500x500" alt="..." /></div>
                </div>
            </div>
        </div>
    </section>
<!-- Footer-->
	<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
</body>
</html>