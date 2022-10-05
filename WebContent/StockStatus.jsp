
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ListStock"
	value='${requestScope["outputObject"].get("ListStock")}' />
<c:set var="ListOfCategories"
	value='${requestScope["outputObject"].get("ListOfCategories")}' />
<c:set var="listOffirm"
	value='${requestScope["outputObject"].get("listOffirm")}' />
	
<c:set var="listofwarehouse"
	value='${requestScope["outputObject"].get("listofwarehouse")}' />
	
	

<c:set var="totalDetails"
	value='${requestScope["outputObject"].get("totalDetails")}' />

<c:set var="sumTotal"
	value='${requestScope["outputObject"].get("sumTotal")}' />	
	




<script>
function deleteStock(stockId)
{
	
	var answer = window.confirm("Are you sure you want to delete ?");
	if (!answer) 
	{
		return;    
	}
	
	  document.getElementById("closebutton").style.display='none';
	   document.getElementById("loader").style.display='block';
	$('#myModal').modal({backdrop: 'static', keyboard: false});;

	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() 
	  {
	    if (xhttp.readyState == 4 && xhttp.status == 200) 
	    { 		      
	      document.getElementById("responseText").innerHTML=xhttp.responseText;
		  document.getElementById("closebutton").style.display='block';
		  document.getElementById("loader").style.display='none';
		  $('#myModal').modal({backdrop: 'static', keyboard: false});;
	      
		  
		}
	  };
	  xhttp.open("GET","?a=deleteStock&stockid="+stockId, true);    
	  xhttp.send();
}

function configureLowStock(stockId)
{
		window.location='?a=showConfigureLowStock&stockId='+stockId;
}

</script>







<br>
<div class="card">

	<br>

	<div class="row">
		<div class="col-sm-2" align="center">
			<div class="input-group input-group-sm" style="width: 200px;">
				<select id="drpfirmId" style="margin-left:3px;" name="drpfirmId" class="form-control float-right" onchange="ReloadFilters()" style="margin-right: 15px;" >
  						
  						<option value='-1'>--Select--</option>  						
  						<c:forEach items="${listOffirm}" var="firm">
							<option value='${firm.firmId}'> ${firm.firmName}</option>
						</c:forEach>  							
  					</select>
			</div>
		</div>
		
		
		<div class="col-sm-2" align="center">
			<div class="input-group input-group-sm" style="width: 200px;">
				<select id="drpwarehouseId" style="margin-left:3px;" name="drpwarehouseId" class="form-control float-right" onchange="ReloadFilters()" style="margin-right: 15px;" >
  						
  						<option value='-1'>--Select--</option>  						
  						<c:forEach items="${listofwarehouse}" var="warehouse">
							<option value='${warehouse.ware_house_id}'> ${warehouse.ware_house_name}</option>
						</c:forEach>  							
  					</select>
			</div>
		</div>
		
		
		
		
		<div class="col-sm-2" align="center">
			<div class="input-group input-group-sm" style="width: 200px;">
				<select id="drpcategoryId" name="drpcategoryId"
					class="form-control float-right" onchange="ReloadFilters()"
					style="margin-right: 15px;">

					<option value='-1'>--Select--</option>

					<c:forEach items="${ListOfCategories}" var="item">
						<option value='${item.category_id}'>
							${item.category_name}</option>
					</c:forEach>
				</select>
			</div>
		</div>

		<div class="col-sm-2" align="center">
			<div class="input-group input-group-sm" style="width: 200px;">
				<input class="form-control form-control-sm" placeholder="Search Item" id="txtsearch"
					type="text">
			</div>
		</div>

		<div class="col-sm-1" align="center">
			<input type="button" class="btn btn-primary btn-sm"
				style="margin-right: 11px;" onclick="ReloadFilters()" value="Search"
				class="form-control float-right">
		</div>




		<div class="col-sm-1" align="center">
			<div class="icon-bar" style="font-size: 22px; color: firebrick">
				<a title="Download Excel" onclick="downloadExcel()"><i
					class="fa fa-file-excel-o" aria-hidden="true"></i></a> <a
					title="Download PDF" onclick="exportPDFForLedger()"><i
					class="fa fa-file-pdf-o"></i></a> <a title="Download Text"
					onclick="downloadText()"><i class="fa fa-file-text-o"></i></a>
			</div>
		</div>

		



	</div>

	<div class="row">

<div class="col-sm-5" >

			
				<!-- <input type="button" class="btn btn-primary btn-sm"					
					onclick="window.location='?a=showStockTransfer'"
					value="Stock Transfer" class="form-control float-right">
			



			
				<input type="button" class="btn btn-primary btn-sm"

					onclick="window.location='?a=showAddStock&type=Add'"
					value="Add New Stock" class="form-control float-right">
			



			
				<input type="button" class="btn btn-primary btn-sm"				
					onclick="window.location='?a=showAddStock&type=Remove'"
					value="Damaged Stock" class="form-control float-right">
					
			
			<input type="button" class="btn btn-primary btn-sm"				
					onclick="window.location='?a=showInventoryCounting'"
					value="Inventory Counting" class="form-control float-right"> -->

		</div>



</div>











<!-- /.card-header -->
<div class="card-body table-responsive p-0" style="height: 580px;">
	<table id="example1"
		class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline"
		role="grid" aria-describedby="example1_info">
		<thead>
			<tr>
				<th><b>firm Name</b></th>
				<th>Ware House</th>
				<th>Item Name</th>
				<th>Product Code</th>
				<th>Available Quantity</th>
				<th>Avg Price</th>
				<th>Value</th>
				
				



			</tr>
		</thead>
		<tbody>
			<c:forEach items="${ListStock}" var="item">

				

				
					<tr style="color: green">
				

				
				<td>${item.firm_name}</td>
				<td>${item.ware_house_name}</td>

				<td><a
					href="?a=showItemHistory&itemId=${item.item_id}&firmId=${item.firm_id}">${item.item_name}</a></td>
				<td>${item.product_code}</td>
				<td>${item.availableqty.intValue()}</td>
				<td>${item.PurchaseRate.setScale(2,4)}</td>
				<td>${item.value1.setScale(2,4)}</td>
				
				
				
				</tr>
			</c:forEach>


		</tbody>
	</table>
</div>
<!-- /.card-body -->
</div>

Total Stock Value
${sumTotal}












<script>
  $(function () {
    
    $('#example1').DataTable({
      "paging": true,      
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false,
      "responsive": true,
      "pageLength": 50,
      "order": [[ 0, "desc" ]]
    });
  });
  
  document.getElementById("divTitle").innerHTML="Stock Status";
  
  function ReloadFilters()
  {
	  window.location="?a=showStockStatus&categoryId="+drpcategoryId.value+"&firmId="+drpfirmId.value+"&warehouseid="+drpwarehouseId.value+"&searchString="+txtsearch.value;
	  
  }
  
  drpcategoryId.value="${param.categoryId}";
  drpfirmId.value="${param.firmId}";
  drpwarehouseId.value="${param.warehouseid}";
  txtsearch.value="${param.searchString}";
  
  
  function deleteStock(categoryId)
  {
  	
  	var answer = window.confirm("Are you sure you want to delete ?");
  	if (!answer) 
  	{
  		return;    
  	}
  	
  	  document.getElementById("closebutton").style.display='none';
  	   document.getElementById("loader").style.display='block';
  	$('#myModal').modal({backdrop: 'static', keyboard: false});;

  	var xhttp = new XMLHttpRequest();
  	  xhttp.onreadystatechange = function() 
  	  {
  	    if (xhttp.readyState == 4 && xhttp.status == 200) 
  	    { 		      
  	      document.getElementById("responseText").innerHTML=xhttp.responseText;
  		  document.getElementById("closebutton").style.display='block';
  		  document.getElementById("loader").style.display='none';
  		  $('#myModal').modal({backdrop: 'static', keyboard: false});;
  	      
  		  
  		}
  	  };
  	  xhttp.open("GET","?a=deleteStock&stockid="+categoryId, true);    
  	  xhttp.send();
  }
  

  function exportPDFForLedger()
  {
	  

		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() 
		  {
		    if (xhttp.readyState == 4 && xhttp.status == 200) 
		    { 		      
		    	//window.open("BufferedImagesFolder/"+xhttp.responseText);
		    	window.location="BufferedImagesFolder/"+xhttp.responseText;
			}
		  };
		  var url1=window.location.href;
		  url1=url1.substring(url1.indexOf("&"),url1.length);
			
		  

		  xhttp.open("GET","?a=exportCustomerLedgerAsPDF"+url1, true);    
		  xhttp.send();
  }
  
  
  
</script>