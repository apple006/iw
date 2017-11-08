<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ taglib uri="http://www.xnx3.com/java_xnx3/xnx3_tld" prefix="x" %><%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<jsp:include page="../../common/head.jsp">
	<jsp:param name="title" value="访问统计"/>
</jsp:include>

<!-- echarts -->
<script src="http://res.weiunity.com/js/echarts.min.js" type="text/javascript"></script>

<div style="padding:20px;">
	<!-- 当天、昨天的折线图，每小时访问情况 -->
	<div id="dayLine" style="width: 100%;height:400px;"></div>
	<!-- 当月的折线图，每小时访问情况 -->
	<div id="monthLine" style="width: 100%;height:400px;"></div>
</div>
                     

<script type="text/javascript">
var basePath = '<%=basePath %>';


// 基于准备好的dom，初始化echarts实例
var dayLine = echarts.init(document.getElementById('dayLine'));
dayLine.showLoading();
$.get('<%=basePath %>admin/log/dayLineForCurrentDay.do').done(function (data) {
    dayLine.hideLoading();
    dayLine.setOption({
	    title: {
	        text: '当日访问统计，展示今天每个时间段的访问情况',
	        subtext: '按小时划分'
	    },
	    tooltip: {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['当日访问量','昨日访问量']
	    },
	    toolbox: {
	        show: true,
	        feature: {
	            dataZoom: {
	                yAxisIndex: 'none'
	            },
	            dataView: {readOnly: false},
	            magicType: {type: ['line', 'bar']},
	            restore: {},
	            saveAsImage: {}
	        }
	    },
	    xAxis:  {
	        type: 'category',
	        boundaryGap: false,
	        data: data.nameArray
	    },
	    yAxis: {
	        type: 'value',
	        axisLabel: {
	            formatter: '{value} pv'
	        }
	    },
	    series: [
	        {
	            name:'当日访问量',
	            type:'line',
	            data:data.dataArray,
	            markPoint: {
	                data: [
	                    {type: 'max', name: '最大值'},
	                    {type: 'min', name: '最小值'}
	                ]
	            },
	            markLine: {
	                data: [
	                    {type: 'average', name: '平均值'}
	                ]
	            }
	        },
	        {
	            name:'昨日访问量',
	            type:'line',
	            data:data.dataArray2,
	            markPoint: {
	                data: [
	                    {type: 'max', name: '最大值'},
	                    {type: 'min', name: '最小值'}
	                ]
	            },
	            markLine: {
	                data: [
	                    {type: 'average', name: '平均值'}
	                ]
	            }
	        }
	    ]
	});
});


//统计一个月内，最近30天的每天访问情况
var monthLine = echarts.init(document.getElementById('monthLine'));
monthLine.showLoading();
$.get('<%=basePath %>admin/log/dayLineForCurrentMonth.do').done(function (data) {
    monthLine.hideLoading();
    monthLine.setOption({
	    title: {
	        text: '当月访问统计,展示最近30天，每天的访问情况',
	        subtext: '按天划分'
	    },
	    tooltip: {
	        trigger: 'axis'
	    },
/* 	    legend: {
	        data:['最近30天访问统计']
	    }, */
	    toolbox: {
	        show: true,
	        feature: {
	            dataZoom: {
	                yAxisIndex: 'none'
	            },
	            dataView: {readOnly: false},
	            magicType: {type: ['line', 'bar']},
	            restore: {},
	            saveAsImage: {}
	        }
	    },
	    xAxis:  {
	        type: 'category',
	        boundaryGap: false,
	        data: data.nameArray
	    },
	    yAxis: {
	        type: 'value',
	        axisLabel: {
	            formatter: '{value} pv'
	        }
	    },
	    series: [
	        {
	            name:'当日访问量',
	            type:'line',
	            data:data.dataArray,
	            markPoint: {
	                data: [
	                    {type: 'max', name: '最大值'},
	                    {type: 'min', name: '最小值'}
	                ]
	            },
	            markLine: {
	                data: [
	                    {type: 'average', name: '平均值'}
	                ]
	            }
	        }
	    ]
	});
});

//字符串截取
function subString(text){
	if(text.length > 40){
		text = text.substr(0,40)+'...';
	}
	return text;
}

//传入10位时间戳，返回描述文字
function timezhuanhuan(timestamp){
	var d = new Date(timestamp * 1000);    //根据时间戳生成的时间对象
	var date = (d.getFullYear()) + "-" + 
           (d.getMonth() + 1) + "-" +
           (d.getDate()) + " " + 
           (d.getHours()) + ":" + 
           (d.getMinutes()) + ":" + 
           (d.getSeconds());
	return date;
}
</script>

</body></html>