<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>새 주문 등록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body { padding: 20px; }
        h3 { margin-bottom: 30px; }
        input:read-only {
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>
    <header>
        <h3><b>주문 등록</b></h3>
    </header>
    <form id="newOrderForm" class="form-horizontal">
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="newOrderCode" class="form-label">주문 코드</label>
                <input id="newOrderCode" type="text" class="form-control orderInfo" name="order_code" readonly/>
            </div>
            <div class="col-md-6 mb-3">
                <label for="newStatus" class="form-label">상태</label>
                <input id="newStatus" type="text"  class="form-control orderInfo" name="status" value="작성중" readonly />
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="newBuyerCode" class="form-label">바이어코드</label>
                <div class="input-group">
                    <input id="newBuyerCode" type="text" class="form-control orderInfo" name="buyer_code" placeholder="바이어코드를 검색해주세요." readonly/>
                    <a id="buyerPopupButton" class="btn btn-outline-secondary">검색</a>
                </div>
            </div>
            <div class="col-md-6 mb-3">
                <label for="newBuyerName" class="form-label">바이어명</label>
                <input id="newBuyerName" type="text" class="form-control orderInfo" name="buyer_name" readonly/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="newRequestDate" class="form-label">납품요청일</label>
                <input id="newRequestDate" type="date" class="form-control orderInfo" name="request_date" required="required" />
            </div>
            <div class="col-md-6 mb-3">
                <label for="newOrderDate" class="form-label">주문일</label>
                <input id="newOrderDate" type="date" class="form-control orderInfo" name="order_date" readonly/>
            </div>
        </div>
        <div class="row">
            <div class="col mb-3">
                <label for="newMemo" class="form-label">주문메모</label>
                <textarea rows="3" id="newMemo" class="form-control orderInfo" name="memo"></textarea>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="newProductCode" class="form-label">상품코드</label>
                <div class="input-group">
                    <input id="newProductCode" type="text" class="form-control" name="product_code" required="required" placeholder="상품코드를 검색해주세요." readonly/>
                    <button id="productPopupButton" class="btn btn-outline-secondary" type="button">검색</button>
                </div>
            </div>
            <div class="col-md-6 mb-3">
                <label for="newProductName" class="form-label">상품명</label>
                <input id="newProductName" type="text" class="form-control" name="product_name" readonly/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 mb-3">
                <label for="newPrice" class="form-label">단가</label>
                <input id="newPrice" type="number" class="form-control" name="price" required="required" />
            </div>
            <div class="col-md-4 mb-3">
                <label for="newQuantity" class="form-label">수량</label>
                <input id="newQuantity" type="number" class="form-control" name="quantity" required="required" />
            </div>
            <div class="col-md-4 mb-3">
                <label class="form-label"></label>
                <button type="button" id="resetItemButton" class="btn btn-danger">초기화</button>
                <button type="button" id="addNewItemButton" class="btn btn-danger">상품추가</button>
            </div>
        </div>
        <div class="row">
            <table class="table table-hover" id="newItem-table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>상품번호</th>
                    <th>상품명</th>
                    <th>수량</th>
                    <th>단가</th>
                    <th>총금액</th>
                    <th>X</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </form>

    <footer style="float: right; justify-content: flex-end;">
        <button type="button" id="newOrderSubmitButton" class="btn btn-danger">주문등록</button>
        <button type="button" class="btn btn-secondary" onclick="window.close();">취소</button>
    </footer>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>--%>
    <script type="text/javascript">
        let orderItemList = []; //주문 등록 모달창의 상품(표) 리스트

        $(function() {
            /* 바이어 검색 팝업창 */
            $('#buyerPopupButton').click(function() {
                buyerPopup();
            });

            /* 주문일 - 오늘 날짜 */
            const now = new Date();
            const today = now.getFullYear() + "-" + ("0"+(now.getMonth()+1)).slice(-2) + "-" + ("0"+(now.getDate())).slice(-2);
            $('#newOrderDate').val(today);

            /* 납품 요청일 */
            //$('#newRequestDate')

            /* 상품 검색 팝업창 */
            $('#productPopupButton').click(function() {
                let buyerCode = $.trim($('#newBuyerCode').val());
                let requestDate = $.trim($('#newRequestDate').val());

                if (buyerCode !== "" && requestDate !== "") {
                    // [TODO] 상품코드를 직접 검색하는 경우 팝업창으로 상품코드 전달 - 팝업창 검색 기능 작업 이후
                    // if ($('#newProductCode').val().trim() != "")
                    itemPopup();
                }
                if (buyerCode == "")  buyerPopup();
                if (requestDate == "") $('#newRequestDate').focus();
            });

            /* 상품 추가 버튼 */
            $('#addNewItemButton').click(function() {
                let buyerCode = $.trim($('#newBuyerCode').val());
                let requestDate = $.trim($('#newRequestDate').val());
                let productCode = $.trim($('#newProductCode').val());
                let productName = $.trim($('#newProductName').val());
                let price = $.trim($('#newPrice').val());
                let quantity = $.trim($('#newQuantity').val());

                if (buyerCode !== "" && requestDate !== "") {
                    if (productCode != "" && productName != "" && price != "" && quantity != "") {
                        addOrderItem();
                    }
                    if (productCode == "" || productName == "")  itemPopup();
                    if (price == "") $('#newPrice').focus();
                    if (quantity == "") $('#newQuantity').focus();
                }
                if (buyerCode == "")  buyerPopup();
                if (requestDate == "") $('#newRequestDate').focus();
            });

            /* 상품 초기화 버튼 */
            $('#resetItemButton').click(function() {
                resetItemInfo();
            });

            /* 주문 등록 전송 버튼 */
            $('#newOrderSubmitButton').click(function() {
                let buyerCode = $.trim($('#newBuyerCode').val());
                let requestDate = $.trim($('#newRequestDate').val());
                if (buyerCode != "" && requestDate != "") {
                    addNewOrder();
                } else {
                    if (buyerCode == "") buyerPopup();
                    if (requestDate == "") $('#newRequestDate').focus();
                }


                // console.log("----> "+orderItemList);
                // $('#registerModalBody').empty();
                // $('#registerModalBody').append("총 " + orderItemList.length + "건의 상품을 주문 등록하시겠습니까?");
            });

        });

        /* 바이어 검색 팝업창 */
        function buyerPopup() {
            let url = "/search/buyerPopup";
            let popupWidth = 600;
            let popupHeight = 500;
            let popupX = (window.screen.width / 2) - (popupWidth / 2);
            let popupY= (window.screen.height / 2) - (popupHeight / 2);
            let popupOption = 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY;
            window.open(url,"",popupOption);
        }
        // 바이어 정보 추가
        window.setBuyerInfo = function (buyerCode, buyerName) {
            $('#newBuyerCode').val(buyerCode);
            $('#newBuyerName').val(buyerName);
        }

        /* 상품 검색 팝업창 */
        function itemPopup() {
            resetItemInfo();
            let url = "/search/productPopup?buyer_code=" + $('#newBuyerCode').val();
            let popupWidth = 600;
            let popupHeight = 500;
            let popupX = (window.screen.width / 2) - (popupWidth / 2);
            let popupY= (window.screen.height / 2) - (popupHeight / 2);
            let popupOption = 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY;
            window.open(url,"",popupOption);
        }
        // 상품 정보 추가
        window.setItemInfo = function (itemCode, itemName, category, price) {
            $('#newProductCode').val(itemCode);
            $('#newProductName').val(itemName);
           // $('#newCategory').val(category);
            $('#newPrice').val(price);
        }

        /* 주문 상품 추가 */
        function addOrderItem() {
            let productCode = $('#newProductCode').val();
            let productName = $('#newProductName').val();
            let quantity = $('#newQuantity').val();
            let price = $('#newPrice').val();
            let totalPrice = quantity * price;

            // 상품 중복 확인
            let dupli = false;
            for(var i = 0; i<orderItemList.length; i++) {
                if (orderItemList[i][0] == productCode) {
                    dupli = true;
                }
            }
            if (dupli == false) {
                const itemList = [productCode, productName, quantity, price, totalPrice];
                orderItemList.push(itemList);
                itemListInPopup(itemList, orderItemList);

                // 바이어 정보 수정 불가
                $('#buyerPopupButton').attr('style','pointer-events:none;');

            } else {
                alert("상품번호 " + productCode + "가 중복됩니다.");
            }
            resetItemInfo();
        }

        /* 주문상품 리스트 조회 */
        function itemListInPopup(itemList, orderItemList) {
            let tbody = $('#newItem-table tbody');
            tbody.append("");
            tbody.append(
                "<tr>"
                + "<td>" + orderItemList.length + "</td>"
                + "<td>" + itemList[0] + "</td>"
                + "<td>" + itemList[1] + "</td>"
                + "<td>" + itemList[2] + "</td>"
                + "<td>" + itemList[3] + "</td>"
                + "<td>" + itemList[4] + "</td>"
                + "<td>X</td>"
                + "</tr>"
            );
        }

        /* 상품입력창 초기화 */
        function resetItemInfo() {
            $('#newProductCode').val("");
            $('#newProductName').val("");
            $('#newQuantity').val("");
            $('#newPrice').val("");
        }

        /* 새 주문 등록 */
        function addNewOrder() {
            let queryString = $(".orderInfo").serialize();
            $.ajax({
                type: 'POST',
                url: '/order/register',
                data: queryString,
                success: function (data) {
                    //console.log(data);
                    var objParams = {
                        "items" : orderItemList,
                        "orderCode" : data
                    };
                    $.ajax({
                        type: 'POST',
                        url: '/order/registerItem',
                        data: objParams,
                        dataType : 'json',
                        traditional: true,
                        success: function (result) {
                            console.log(result);

                        }
                    });
                }
            });

            setTimeout(function () {
                opener.parent.location.reload();
                window.close();
            }, 1000);
        }

    </script>
</body>
</html>