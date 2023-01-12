package com.sharedOne.controller.report;

import com.sharedOne.domain.report.OrderDto;
import com.sharedOne.domain.report.OrderGroupDto;
import com.sharedOne.domain.report.OrderItemDto;
import com.sharedOne.domain.report.SumDto;
import com.sharedOne.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
@RequestMapping("report")
public class ReportController {

    @Autowired
    private ReportService reportService;

    @GetMapping("result")
    public void reportMain() {

//        return "forward:/report/result";
    }

    @GetMapping("work")
    public String reportMain(Model model,
                             @RequestParam(required = false) String order_code,
                             @RequestParam(required = false) String buyer_code,
                             @RequestParam(required = false) String status,
                             @RequestParam(required = false) String adduser,
                             @RequestParam(required = false) String from_request_date,
                             @RequestParam(required = false) String to_request_date,
                             @RequestParam(required = false) String from_add_date,
                             @RequestParam(required = false) String to_add_date,
                             @RequestParam(required = false) String product_code,
                             @RequestParam(required = false, defaultValue = "i.num") String sumCondition
    ) {
        if (!sumCondition.equals("i.num") & (sumCondition != null) & !sumCondition.equals("")) {
//        if (!sumCondition.equals("i.num") ){
            if((((from_request_date.equals("")&from_request_date!=null)&!(to_request_date.equals("")&to_request_date!=null))
                    |((to_request_date.equals("")&to_request_date!=null)&!(from_request_date.equals("")&from_request_date!=null)))
            |(((from_add_date.equals("")&from_add_date!=null)&!(to_add_date.equals("")&to_add_date!=null))
                    |((to_add_date.equals("")&to_add_date!=null)&!(from_add_date.equals("")&from_add_date!=null)))
            ){
                model.addAttribute("message","날짜를 입력해주세요");
            System.out.println("에러");
                return "/report/sumResult";}


            System.out.println(sumCondition + "섬레졀트 작업시작");
            if (sumCondition.equals(("month(h.request_date)"))) {
                model.addAttribute("groupName", "월");
            }
            if (sumCondition.equals("h.buyer_code")) {
                model.addAttribute("groupName", "바이어코드");
            }
            if (sumCondition.equals("h.adduser")) {
                model.addAttribute("groupName", "유저명");
            }
            if (sumCondition.equals("h.status")) {
                model.addAttribute("groupName", "승인여부");
            }


            List<OrderGroupDto> orderGroups = reportService.getOrderGroups(order_code, buyer_code, status, adduser,
                    from_request_date,to_request_date,from_add_date, to_add_date, product_code, sumCondition);
            System.out.println("오더그룹스" + orderGroups);
            // 왜 한 그룹으로 나오지..? > 이유는 모르겠지만 자동으로 고쳐짐;
            orderGroups.forEach(orderGroupDto -> System.out.println("찾으려고 적음" + orderGroupDto));

            SumDto sums = reportService.getSums(order_code, buyer_code, status, adduser,
                    from_request_date,to_request_date,
                    from_add_date, to_add_date, product_code, sumCondition);

            model.addAttribute("orderGroups", orderGroups);
            model.addAttribute("sums", sums);
            model.addAttribute("orderGroupCount",orderGroups.size());
            model.addAttribute("from_add_date",from_add_date);
//            if(!from_add_date.equals("")&from_add_date!=null){
            model.addAttribute("to_add_date",to_add_date);
//            }
            model.addAttribute("from_request_date",from_request_date);
            model.addAttribute("to_request_date",to_request_date);
            return "/report/sumResult";
        }


        //---------------------------------------------------------------------

        System.out.println("레졀트 작업시작" + "order_code:" + sumCondition);
        if (order_code == null & buyer_code == null & adduser == null & from_add_date == null & to_add_date == null) {
            status = " ";
        }

        List<OrderDto> orders = reportService.getOrders(order_code, buyer_code, status, adduser,
                from_request_date,to_request_date,
                from_add_date, to_add_date, product_code);

        SumDto sums = reportService.getSums(order_code, buyer_code, status, adduser,
                from_request_date,to_request_date,
                from_add_date, to_add_date, product_code, sumCondition);

        System.out.println("갯수 : " + orders.size());
        System.out.println(sums + "sums");
        System.out.println(orders);
        model.addAttribute("orders", orders);
        model.addAttribute("sums", sums);
        model.addAttribute("orderCount",orders.size());
        model.addAttribute("from_add_date",from_add_date);
//            if(!from_add_date.equals("")&from_add_date!=null){
        model.addAttribute("to_add_date",to_add_date);
//            }
        model.addAttribute("from_request_date",from_request_date);
        model.addAttribute("to_request_date",to_request_date);

        return "/report/result";
    }


    @GetMapping("graph")
    public void apiTest() {
    }

    @GetMapping("mainTest")
    public void mainTest() {
    }


    @ResponseBody
    @PostMapping("search/order_code")
    public List<String> searchOrderCode(@RequestBody String partOfOrderCode) {
        System.out.println("서치오더코드");
        System.out.println(partOfOrderCode);
        //RequestBody로 값 받아옴 근데 왜 1이 아니라 "1" ?
        //임시방편으로 서브스트링메서드로 양 옆 쌍따옴표 떼어냄..

        String orderCodePart = partOfOrderCode.substring(1, partOfOrderCode.length() - 1);
        List<String> orderCodes = reportService.searchOrderCode(orderCodePart);
        System.out.println(orderCodes + "오더코드검색결과");

        //-----------------------------오더코드 검색 완료(배열로 받아옴)------------------------------------

        Map<String, Object> map = new HashMap<>();
        map.put("1", partOfOrderCode);
        System.out.println(map + "map");
        return orderCodes;
    }


//    @ResponseBody
//    @PostMapping("search/order_code")
//    public Map<String, Object> searchOrderCode(@RequestBody String order_code_part){
//        System.out.println("서치/오더코드");
//        Map<String,Object> map= new HashMap<>();
//        String orderCodes = reportService.searchOrderCode(order_code_part);
//        System.out.println("121"+orderCodes);
//        map.put("orderCode",orderCodes );
//        System.out.println("1211"+map);
//        return map;
//    }


    @GetMapping("order-itme")
    public List<OrderItemDto> getOrderItemByOrderCode(@RequestParam String product_code) {
        System.out.println("오더_아이템 반환");
        List<OrderItemDto> orderItemDtos = reportService.getOrderItems(product_code);

        return orderItemDtos;
    }

}
