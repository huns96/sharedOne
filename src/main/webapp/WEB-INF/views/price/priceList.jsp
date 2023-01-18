<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-01-03
  Time: 오후 2:20
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0">
  <title>Title</title>
  <link rel="stylesheet" type="text/css" media="screen" href="../css/price.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <style>
    .page-background {
      background-color: white;
      padding: 10px;
      margin: 5px;
      border-radius: 5px;
    }

  </style>
</head>

<body style="background-color: #e0e0e0;">


<%--<c:if test="${not empty message}">--%>
<%--  <script type="text/javascript">--%>

<%--    alert("${message }");--%>

<%--  </script>--%>
<%--</c:if>--%>

<div class="container-fluid">
  <div class="row flex-nowrap">
    <my:Sidebar></my:Sidebar>
    <c:if test="${not empty message}">
      <script type="text/javascript">

        alert("${message }");

      </script>
    </c:if>

    <div class="container-md" style="width: 80%">
      <div class="page-header">
<%--        <h1 class="page-title"> Price </h1>--%>
  <div class="row">
    <div class="col">
      <div id="search" class="page-background">
        <form action="" role="search" style="display: flex; height: 40px" >
          <label class="form-label" style="width: 70px;  margin-top:8px; text-align:center">바이어</label>
          <select name="bt" class="form-select" style="width: 130px; vertical-align:bottom" aria-label="Disabled select example">
            <option value="buyer_code">바이어코드</option>
            <option value="buyer_name">바이어명</option>
          </select>
          <input class="form-control" type="search" name="bq" placeholder="바이어검색" style="width: 200px; text-align:center">
          <label class="form-label" style="width: 70px;  margin-top:8px; text-align:center">제품</label>
          <select name="pt" class="form-select" style="width: 130px; vertical-align:bottom" aria-label="Disabled select example">
            <option value="product_code">제품코드</option>
            <option value="product_name">제품명</option>
          </select>
          <input class="form-control" type="search" name="pq" placeholder="제품검색" style="width: 200px; text-align:center">
          <br>
          <button class="btn btn-dark" type="submit" style="width: 100px; height: 40px; position: absolute; right:3%; border-radius: 7px;">조회</button>
        </form>
      </div>
    </div>
  </div>

      </div>

      <div class="card-body page-background " style="height: 85%;">
          <h4 style="position: relative; top: 4%; margin-left: 20px ">판매가
        <div class="btn-group" style="position: absolute; right: 10px;">
          <button class="btn btn-success btn-sm" type="button" data-bs-toggle="modal" data-bs-target="#registerModal" style="border-radius: 7px; margin-right: 4px">등록 </button>
          <button class="btn btn-danger btn-sm" type="button"data-bs-toggle="modal" data-bs-target="#removeModal" id="delete" style="border-radius: 7px">삭제</button>
          <div class="modal fade" id="removeModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h1 class="modal-title fs-5">삭제 확인</h1>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <form id="remove" action="/price/remove" method="post">
                    <input id="removeNum" type="hidden" name="removePrices">
                    삭제하시겠습니까?
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                  <button id="removeConfirm" class="btn btn-danger" type="submit">확인</button>
                </div>
                </form>

              </div>
            </div>
          </div>
        </div>
          </h4>
        <br>
        <table class="table table-hover mt-3" id="deviceTable">
          <thead>
          <tr style="text-align: center">
            <th>No.</th>
            <th>바이어코드</th>
            <th>바이어명</th>
            <th>제품코드</th>
            <th>제품명</th>
            <th>판매가</th>
            <th>시작일</th>
            <th>종료일</th>
            <th>화폐단위</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>수정자</th>
            <th></th>
<%--            <th>수정일</th>--%>
          </tr>
          </thead>
          <tbody>
          <c:forEach items="${priceList}" var="price" varStatus="status">
            <tr style="text-align: center">
              <td><input type="checkbox" value="${price.num}" name="checkPrices">  ${status.count}</td>
              <td>${price.buyer_code}</td>
              <td>${price.buyer_name}</td>
              <td>${price.product_code}</td>
              <td>${price.product_name}</td>
              <td id="${status.count}">${price.price}</td>
              <td>${price.start_date}</td>
              <td>${price.end_date}</td>
              <td>${price.currency}</td>
              <td>${price.adduser}</td>
              <td>${price.adddate}</td>
              <td>${price.upduser}</td>
<%--              <td>${price.upddate}</td>--%>
              <td>
                <span style="text-decoration: underline;" id="modify" class="modify" type="button" value="${price.num}" data-bs-toggle="modal" data-bs-target="#modifyModal${price.num}" onclick="myFunction('price${status.count}')">수정</span>
                <div class="modal fade" id="modifyModal${price.num}" tabindex="-1" aria-hidden="true">
                  <div class="modal-dialog modal-xl" role="document">
                    <div class="modal-content">

                      <div class="modal-header">
                        <h1 class="modal-title fs-5" style="left: 10px">판매가 수정</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                aria-label="Close" style="right: 10px"></button>
                      </div>
                      <div class="modal-body">
                        <form class="modifyForm" id="modifyForm" action="/price/modify" method="post" enctype="multipart/form-data" style="margin: auto;  height: 664px;">
                          <div style="margin: 20px;">
                                  <div class="mb-3 mx-4" style="position: relative">
                                    <label class="form-label">바이어코드</label>
                                    <input class="form-control" type="text" name="buyer_code" data-bs-toggle="modal" data-bs-target="#buyerModal" placeholder="바이어 코드" value="${price.buyer_code}" style="text-align: center" readonly>
                                    <i class="fa-solid fa-magnifying-glass" type="button" style="position: absolute; top: 62%; right: 1%" data-bs-toggle="modal" data-bs-target="#buyerModal"></i>
                                  </div>
<%--                            <div class="mb-3 mx-4" style="position: relative">--%>
<%--                              <label class="form-label">바이어코드</label>--%>
<%--                              <input class="form-control" type="text" id="buyer_code" name="buyer_code" data-bs-toggle="modal" data-bs-target="#buyerModal" value="${price.buyer_code}" required="required" placeholder="바이어 코드" style="text-align: center">--%>
<%--                              <i class="fa-solid fa-magnifying-glass" type="button" style="position: absolute; top: 62%; right: 1%" data-bs-toggle="modal" data-bs-target="#buyerModal"></i>--%>
<%--                            </div>--%>
<%--                            <div class="mb-3 mx-4">--%>
<%--                              <label class="form-label">제품코드</label>--%>
<%--                              <input class="form-control" type="text" id="product_code" name="product_code" value="${price.product_code}" data-bs-toggle="modal" data-bs-target="#productModal" required="required" placeholder="제품 코드" style="text-align: center">--%>
<%--                            </div>--%>
                            <div class="mb-3 mx-4" style="position: relative">
                              <label class="form-label">제품코드</label>
                              <input class="form-control" type="text" name="product_code" data-bs-toggle="modal" data-bs-target="#productModal" placeholder="제품 코드" value="${price.product_code}" style="text-align: center" readonly>
                              <i class="fa-solid fa-magnifying-glass" type="button" style="position: absolute; top: 62%; right: 1%" data-bs-toggle="modal" data-bs-target="#productModal"></i>
                            </div>
                            <div class="mb-3 mx-4">
                              <label class="form-label">판매가</label>
                              <input class="form-control" onkeyup="inputNumberFormat(this);" type="text" name="price" id="price${status.count}" value="${price.price}" style="text-align: center" required="required">
                            </div>
                            <div class="mb-3 mx-4">
                              <label class="form-label">시작일</label>
                              <input class="form-control" type="date" name="start_date" id="start_date" value="${price.start_date}"  style="text-align: center" required="required">
                            </div>
                            <div class="mb-3 mx-4">
                              <label class="form-label">종료일</label>
                              <input class="form-control" type="date" name="end_date" id="end_date" value="${price.end_date}"  style="text-align: center" required="required">
                            </div>
                            <div class="mb-3 mx-4">
                              <label class="form-label">화폐단위</label><br>
                              <select class="form-control" type="text" name="currency" id="currency" value="${price.currency}" style="text-align: center" required="required">
                                <option value="">화폐 단위를 선택하세요</option>
                                <option value="원(₩)" <c:if test="${price.currency == '원(₩)' }">selected="selected"</c:if>>원(₩)</option>
                                <option value="달러($)"<c:if test="${price.currency == '달러($)' }">selected="selected"</c:if>>달러($)</option>
                                <option value="앤(¥)"<c:if test="${price.currency == '앤(¥)' }">selected="selected"</c:if>>앤(¥)</option>
                                <option value="위안(元)"<c:if test="${price.currency == '위안(元)' }">selected="selected"</c:if>>위안(元)</option>
                              </select>
                            </div>
                            <input class="form-control" type="hidden" name="num" id="num" value="${price.num}">
                          </div>

                      <div class="modal-footer">
                        <button id="modifyConfirmButton" onclick="myFunction2('price${status.count}')"
                                class="btn btn-primary" type="submit">수정</button>
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">취소</button>
                      </div>
                      </form>

                      </div>



                    </div>
                  </div>
                </div>
                <span style="text-decoration: underline;" type="button"data-bs-toggle="modal" data-bs-target="#removeModal${price.num}" value="${price.num}">삭제</span>
                <!-- remove Modal -->
                <div class="modal fade" id="removeModal${price.num}" tabindex="-1" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h1 class="modal-title fs-5">삭제 확인</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      </div>
                      <div class="modal-body">
                        <form id="removeForm" action="/price/remove" method="post">
                          <input type="hidden" name="num" value="${price.num}">
                          삭제하시겠습니까?
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button id="removeConfirmButton" class="btn btn-danger" type="submit">확인</button>
                      </div>
                        </form>

                    </div>
                  </div>
                </div>
             </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
        <div class="row" >
          <div class="col" style="width: 17px">
            <nav class="mt-3 page" aria-label="Page navigation example">
              <ul class="pagination justify-content-center">
                <c:if test="${pageInfo.currentPageNumber != 1 }">
                  <li class="page-item">
                    <a class="page-link" href="/price/priceList?page=1}" aria-label="first" style="height:100%;">
                      <span aria-hidden="true"><i class="fa-solid fa-angles-left"></i></span>
                    </a>
                  </li>
                </c:if>
                <c:if test="${pageInfo.leftPageNumber != 1 }">
                  <li class="page-item">
                    <a class="page-link" href="/price/priceList?page=${pageInfo.currentPageNumber-1}" aria-label="left" style="height: 100%">
                      <span aria-hidden="true"><i class="fa-solid fa-angle-left"></i></span>
                    </a>
                  </li>
                </c:if>
                <c:forEach begin="${pageInfo.leftPageNumber}" end="${pageInfo.rightPageNumber }" var="pageNumber">
                  <li class="page-item ${pageInfo.currentPageNumber eq pageNumber ? 'active' : '' }">
                    <a class="page-link" href="/price/priceList?page=${pageNumber}" >${pageNumber }</a>
                  </li>
                </c:forEach>
                <c:if test="${pageInfo.rightPageNumber} != ${pageInfo.lastPageNumber/10*10} and ${pageInfo.currentPageNumber != pageInfo.lastPageNumber }">
                  <li class="page-item">
                    <a class="page-link" href="/price/priceList?page=${pageInfo.currentPageNumber+1}" aria-label="last" style="height: 100%">
                      <span aria-hidden="true"><i class="fa-solid fa-angle-right"></i></span>
                    </a>
                  </li>
                </c:if>
                <c:if test="${pageInfo.currentPageNumber != pageInfo.lastPageNumber }">
                  <li class="page-item">
                    <a class="page-link" href="/price/priceList?page=${pageInfo.lastPageNumber}" aria-label="last" style="height:100%;">
                      <span aria-hidden="true"><i class="fa-solid fa-angles-right"></i></span>
                    </a>
                  </li>
                </c:if>
              </ul>
            </nav>
          </div>
        </div>
      </div>
    </div>
      </div>

</div>









<jsp:include page="include/registerModal.jsp" />
<jsp:include page="include/buyerModal.jsp" />
<jsp:include page="include/productModal.jsp" />
<%--<jsp:include page="include/modifyModal.jsp" />--%>

<%--<script type="text/javascript" src="../js/jquery.js"></script>--%>
<script type="text/javascript" src="../js/jquery-3.6.3.min.js"></script>
<script src="http://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script>

//  $("#modifyConfirmButton").click(function(){
  //  let price = $("#price").val();
    //let intPrice = parseInt(price.replace(/,/g,""));
   // $("input[name='price']").val(intPrice);
  //})

  function myFunction2(x) {
    let price = document.getElementById(x).value;
    let intPrice = parseInt(price.replace(/,/g,""));
    document.getElementById(x).value = intPrice;
  }

  function myFunction(x) {
    let money = document.getElementById(x).value;
    let money2 = money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    document.getElementById(x).value = money2;
  }

  $("#delete").click(function() {
    let checkPrices = [];
    $("input[name='checkPrices']:checked").each(function(){
      checkPrices.push($(this).val());
    })
    $("#removeNum").val(checkPrices);
  });

  function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
  }

  function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
  }


  function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
  }


  function priceToString(price) {
    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
  }

  $('#buyerList tr').dblclick(function() {
    let tr = $(this);
    let td = tr.children();
    let buyerCode = td.eq(1).text();
    $('#buyerCodeInput').val(buyerCode);
    $("[name='buyer_code']").val(buyerCode);

    $("#buyerModal").hide();
    $(".modal-backdrop").remove();

  });

  $('#buyerCodeList tr').dblclick(function() {
    let tr = $(this);
    let td = tr.children();
    let buyerCode = td.eq(1).text();
    $('#buyerCodeInput').val(buyerCode);
    $("[name='buyer_code']").val(buyerCode);

    $("#buyerModal").hide();
    $("#buyer_code_search").hide();
    $(".modal-backdrop").remove();

  });

  $('#buyerNameList tr').dblclick(function() {
    let tr = $(this);
    let td = tr.children();
    let buyerCode = td.eq(1).text();
    $('#buyerCodeInput').val(buyerCode);
    $("[name='buyer_code']").val(buyerCode);

    $("#buyerModal").hide();
    $("#name_search").hide();
    $(".modal-backdrop").remove();

  });

  $('#productList tr').dblclick(function() {
    let tr = $(this);
    let td = tr.children();
    let productCode = td.eq(1).text();
    $('#productCodeInput').val(productCode);
    $("[name='product_code']").val(productCode);

    $("#productModal").hide();
    $(".modal-backdrop").remove();

  });

  $('#productCodeList tr').dblclick(function() {
    let tr = $(this);
    let td = tr.children();
    let productCode = td.eq(1).text();
    $('#productCodeInput').val(productCode);
    $("[name='product_code']").val(productCode);

    $("#productModal").hide();
    $("#product_code_search").hide();
    $(".modal-backdrop").remove();

  });

  $('#productNameList tr').dblclick(function() {
    let tr = $(this);
    let td = tr.children();
    let productCode = td.eq(1).text();
    $('#productCodeInput').val(productCode);
    $("[name='product_code']").val(productCode);

    $("#productModal").hide();
    $("#name_search").hide();
    $(".modal-backdrop").remove();

  });


  for(let i=1; i<=${pageInfo.countAll} ; i++) {
    let money = document.getElementById(i).innerText;
    let money2 = money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    document.getElementById(i).innerText=money2;
    // var money = '';
    // var money2 = '';
  }



  <%--const ctx = "${pageContext.request.contextPath}";--%>

  <%--document.querySelector("#removeConfirmButton").addEventListener("click", function() {--%>
  <%--  document.querySelector("#removeForm").submit();--%>
  <%--});--%>

  <%--document.querySelector("#modifyConfirmButton").addEventListener("click", function() {--%>
  <%--  const buyer_code = document.getElementById("buyer_code").value;--%>
  <%--  const product_code = document.getElementById("product_code").value;--%>
  <%--  const price = document.getElementById("price").value;--%>
  <%--  const start_date = document.getElementById("start_date").value;--%>
  <%--  const end_date = document.getElementById("end_date").value;--%>
  <%--  const currency = document.getElementById("currency").value;--%>
  <%--  const adduser = document.getElementById("adduser").value;--%>
  <%--  const data = {buyer_code, product_code, price, start_date, end_date, currency, adduser};--%>

  <%--  fetch(`\${ctx}/price/pricelist`, {--%>
  <%--    method : "put",--%>
  <%--    headers : {--%>
  <%--      "Content-Type" : "application/json"--%>
  <%--    },--%>
  <%--    body : JSON.stringify(data)--%>
  <%--  })--%>
  <%--          .then(response => response.json())--%>
  <%--          .then(result => {--%>
  <%--              if (result.message === 'SUCCESS') {--%>
  <%--                alert('수정 완료되었습니다.');--%>
  <%--              }--%>
  <%--            });--%>
  <%--});--%>

  // document.querySelector("#registerModal").addEventListener("click", function() {
  //   $('#registerModal>.modal-dialog').load("register", function() {
  //     $("#registerModal").modal("show");
  //   });
  // });

  <%--const ctx = "${pageContext.request.contextPath}";--%>
  <%--var buyer_code = document.getElementById("buyer_code").value;--%>
  <%--var product_code = document.getElementById("product_code").value;--%>
  <%--var price = document.getElementById("price").value;--%>
  <%--var start_date = document.getElementById("start_date").value;--%>
  <%--var end_date = document.getElementById("end_date").value;--%>
  <%--var currency = document.getElementById("currency").value;--%>
  <%--var adduser = document.getElementById("adduser").value;--%>

  <%--const register = () => {--%>
  <%--  fetch('\${ctx}/price/pricelist', {--%>
  <%--    method: 'POST',--%>
  <%--    body: JSON.stringify({--%>
  <%--      "buyer_code":buyer_code,--%>
  <%--      "product_code":buyer_code,--%>
  <%--      "price":price,--%>
  <%--      "start_date":start_date,--%>
  <%--      "end_date":end_date,--%>
  <%--      "currency":currency,--%>
  <%--      "adduesr":adduser--%>
  <%--    }),--%>
  <%--  })--%>
  <%--          .then(response => response.json())--%>
  <%--          .then(result => {--%>
  <%--            if (result.message === 'SUCCESS') {--%>
  <%--              alert('등록 완료되었습니다.');--%>
  <%--              setModal(false);--%>
  <%--            }--%>
  <%--          });--%>
  <%--};--%>
</script>


</body>
</html>
