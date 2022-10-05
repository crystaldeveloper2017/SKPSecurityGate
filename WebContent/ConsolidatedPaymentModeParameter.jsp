<br>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="message" value='${requestScope["outputObject"].get("listfirmData")}' />

<form method="POST" action="?a=generateConsolidatedPaymentModeCollection"> 

<div class="container" style="padding:20px;background-color:white">
	<table class="table table-bordered tablecss">
	
	
	
	
		<tr align="center" style="background-color:cornsilk;">
			<td>From Date</td>
			<td><input type="text" id="txtfromdate" name="txtfromdate" readonly class="form-control" placeholder="From Date"/></td>
			<td>To Date</td>
			<td><input type="text" id="txttodate" name="txttodate" readonly class="form-control"  placeholder="To Date"/></td>
		</tr>
		<tr  align="center" style="background-color:cornsilk;">
			<td>firm Name</td>
			
		
			
			<td>
			<select class='form-control' id="txtfirm" name = "txtfirm" class="form-control" >
				<option value="-1">-------------------------Select --------------------</option>
				<c:forEach items="${message}" var="item">
				    <option value="${item.firmId}">${item.firmName}</option>			    
		   		</c:forEach>
	  		
			
			</select>
			 </td>
				
		</tr>		
		
		<tr>			
			<td colspan="5" align="center">
				<input class="btn btn-primary" type="submit"></button>
			</td>			
		</tr>
		
		
	</table>
</div>
  
  </form>
<!-- to set values while update page is loaded  ends-->



  <script type="text/javascript">
        $( function() 
        		{
            $( "#txtfromdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
            $( "#txttodate" ).datepicker({ dateFormat: 'dd/mm/yy' });
            
            var date = new Date();
            var reqStr=date.getDate()+'/'+(date.getMonth()+1)+'/'+date.getFullYear();
            document.getElementById("txtfromdate").value=reqStr;
            document.getElementById("txttodate").value=reqStr;
            
            
            
            
            
          } );
        
        document.getElementById("divTitle").innerHTML="Consolidated Payment Mode Collection";

        </script>
        