/**
 * 공통 datepicker 함수
 */
 
function initializeDatepicker(selector, customOptions = {}) {
    // 기본 옵션 설정
    var defaultOptions = {
        dateFormat: 'yy-mm-dd', // 날짜 형식
        showOtherMonths: true, // 다른 달의 날짜도 표시
        showMonthAfterYear: true, // 년도가 월 앞에 표시
        changeYear: true, // 연도 선택 가능
        changeMonth: true, // 월 선택 가능
        showOn: "both", // 버튼과 input 클릭 시 달력 표시
        buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif", // 버튼 이미지 경로
        buttonImageOnly: true, // 버튼 이미지만 표시
        buttonText: "선택", // 버튼에 마우스 올렸을 때 텍스트
        yearSuffix: "년", // 연도 뒤에 붙는 텍스트
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], // 월 단축명
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], // 월 전체 이름
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], // 요일 단축명
        dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'], // 요일 전체 이름
        minDate: "-15Y", // 선택 가능한 최소 날짜 (15년 전)
        maxDate: "+5Y" // 선택 가능한 최대 날짜 (5년 후)
    };

    // 사용자 정의 옵션과 기본 옵션 병합
    var settings = $.extend({}, defaultOptions, customOptions);

    // 지정한 요소에 datepicker 적용
    $(selector).datepicker(settings);

    // 기본 오늘 날짜 설정을 사용하고 싶지 않으면 조건문으로 제어
    if (customOptions.setDate !== false) {
        $(selector).datepicker('setDate', 'today');
    }
}