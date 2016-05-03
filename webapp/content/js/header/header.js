/**
 * Created by kinkoo on 2016-03-28.
 */
$('document').ready(function(){
	var width = $('.navbar').width();
	$('#li_auto').width(width-700);
	
	$(window).resize(function(){
		var width = $('.navbar').width();
		$('#li_auto').width(width-700);
	});
});

$(function () {
    $("#input_search").keyup(onSearchChange);
    //$("#btn_search").on("click", onBtnSearch);
    
    $("#form_search").keypress(function(ev){
    	  var ev=window.event||ev;
    	  if(ev.keyCode==13||ev.which==13)
    	  {
    		  return false;
    	  }
    });
});

function onSearchChange(evt)
{ 
	evt.stopPropagation();
	
	if(evt.which==38 || evt.which==40 || evt.which==13)
	{
        var result = false;
		$('#ui_menu li').each(function(i,n){
			if($(n).hasClass("active")) 
			{
                result = true;
                if(evt.which == 40) 
                {
                    if ($(n).next().length != 0)
                    {
                        $(n).removeClass("active");
                        $(n).next().addClass("active");
                        return false;
                    }
                }
                
                if(evt.which==38)
                {
                    if ($(n).prev().length != 0)
                    {
                        $(n).removeClass("active");
                        $(n).prev().addClass("active");
                        return false;
                    }
                }
                
                if(evt.which==13)
                {
                	$('#input_search').val($(n).text());
                	$("#ui_menu").addClass("hidden");
                	return false;
                }
                
                return false;
            }
		});

        if(!result)
            $("#ui_menu li:first-child").addClass("active");
        
		return;
	}
	
	$("#ui_menu").addClass("hidden");
    $("#ui_menu").empty();
    
    var keyword = $('#input_search').val();
    if(keyword==null || keyword == "")
    	return;

    var pData = {
        "keyword": keyword
    };

    $.ajax({
        url : "../search/suggest.action",
        //crossDomain: true,
        type : "post",
        contentType: "application/json",
        dataType : 'json',
        data : JSON.stringify(pData),
        async : false,
        cache : false,
        error : function(msg) {
            var d = dialog({
                title: '提示',
                content: '提交请求失败, 请检测网络连接是否通畅并重试!',
                cancelValue: '确定',
                cancel: function () {}
            });

            d.showModal();
        },
        success : function(msg)
        {
        	if(msg.headers.ret == 1000)
        		return;
        	
        	var html = "";
        	for(var i=0; i<msg.body.suggests.length; ++i)
        	{
        		html += '<li><a>'+msg.body.suggests[i] + '</a></li>';
        	}
        	
        	if(html=="")
        		return;
        	
        	$("#ui_menu").append(html);
        	$("#ui_menu").removeClass("hidden");
        	$('#ui_menu').children('li').bind('click', function(){
        		$("#input_search").val($(this).text());
        	});
        }
    });
}