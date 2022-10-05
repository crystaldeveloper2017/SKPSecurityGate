<style>
	.date_field {position: relative; z-index:1000;}
	.ui-datepicker{position: relative; z-index:1000!important;}
</style>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="message" value='${requestScope["outputObject"].get("listReturnData")}' />
<c:set var="ListOffirms" value='${requestScope["outputObject"].get("ListOffirms")}' />

<c:set var="txtfromdate" value='${requestScope["outputObject"].get("txtfromdate")}' />
<c:set var="txttodate" value='${requestScope["outputObject"].get("txttodate")}' />
<c:set var="firmId" value='${requestScope["outputObject"].get("firmId")}' />





<br>
<div class="card">


	<br>
	
<div class="row">
              
              
              
              
              
              
              
               
              
              
				<div class="col-sm-3" align="center">
					<div class="input-group input-group-sm" style="width: 200px;">
  						<input type="text" id="txtfromdate" onchange="checkforvalidfromtodate();ReloadFilters();"  name="txtfromdate" readonly class="form-control date_field" placeholder="From Date"/>
                  </div>
				</div>
				
				<div class="col-sm-3" align="center">
					<div class="input-group input-group-sm" style="width: 200px;">
					<input type="text" id="txttodate"  onchange="checkforvalidfromtodate();ReloadFilters();"    name="txttodate" readonly class="form-control date_field"  placeholder="To Date"/>
  						
                    </div>
				</div>
				
				<div class="col-sm-3" align="center">
					<div class="input-group input-group-sm" style="width: 200px;">
	  					<select id="drpfirmId" name="drpfirmId"  class="form-control float-right" onchange='ReloadFilters()' style="margin-right: 15px;" >
	  						
	  						<option value='-1'>--Select--</option>  						
	  						<c:forEach items="${ListOffirms}" var="firm">
								<option value='${firm.firmId}'> ${firm.firmName}</option>
							</c:forEach>  							
	  					</select>
                  	</div>
				</div>
				
				
				<div class="col-sm-3" align="center">
							<div class="card-tools">
		                  <div class="input-group input-group-sm" align="center" style="width: 200px;display:inherit">
		                    <div class="icon-bar" style="font-size:22px;color:firebrick">
		  						<a title="Download Excel" onclick="downloadExcel()"><i class="fa fa-file-excel-o" aria-hidden="true"></i></a> 
		 						<a title="Download PDF" onclick="downloadPDF()"><i class="fa fa-file-pdf-o"></i></a>
		  						<a title="Download Text"  onclick="downloadText()"><i class="fa fa-file-text-o"></i></a>  
							</div>           
		                  </div>
		                </div>
				</div>
				
			  </div>

           
              
              
              
              
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 580px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                  <thead>
                    <tr>
                     <th><b>Challan Id</b></th>
                     <th><b>Customer Name</b></th>
                     <th><b>Date</b></th>
                     <th><b>Firm Name</b></th>
                     
                     <th><b>Remarks</b></th>
                     
                     <th><b></b></th>
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${message}" var="item">
					<tr >
						<td>${item.challan_id}</td>
						<td>${item.customer_name}</td>	
						<td>${item.invoice_date}</td>
						<td>${item.firm_name}</td>
						
						<td>${item.remarks}</td>
						
						<td></td>
						<td>
							
							
							
							<c:if test="${item.challan_invoice_id eq null}">
								<button class="btn btn-danger" onclick="deleteChallan(${item.challan_id})">Delete</button>
							</c:if>
							
							
						</td>
						<td><button class="btn btn-primary" onclick="generatePdfChallanIn(${item.challan_id})">Generate PDF</button></td>
						<td>
						<c:if test="${item.challan_invoice_id eq null}">
							<button class="btn btn-success" onclick="generateInvoice('${param.type}',${item.challan_id})">Generate Invoice</button>
						</c:if>
						</td>
					</tr>
				</c:forEach>
				
				
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
</div>
            
            
            
            



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
      "pageLength": 50
    });
  });
  
  
  
  <c:if test="${param.type eq 'O'}">
  	document.getElementById("divTitle").innerHTML="Challans (Out)";
  </c:if>
  
  <c:if test="${param.type eq 'I'}">
  document.getElementById("divTitle").innerHTML="Challans (In)";
  </c:if>
  
  
  
  
  $( "#txtfromdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
  $( "#txttodate" ).datepicker({ dateFormat: 'dd/mm/yy' });
  
  
  
    
  
  
  
  function checkforvalidfromtodate()
  {        	
  	var fromDate=document.getElementById("txtfromdate").value;
  	var toDate=document.getElementById("txttodate").value;
  	
  	var fromDateArr=fromDate.split("/");
  	var toDateArr=toDate.split("/");
  	
  	
  	var fromDateArrDDMMYYYY=fromDate.split("/");
  	var toDateArrDDMMYYYY=toDate.split("/");
  	
  	var fromDateAsDate=new Date(fromDateArrDDMMYYYY[2],fromDateArrDDMMYYYY[1]-1,fromDateArrDDMMYYYY[0]);
  	var toDateAsDate=new Date(toDateArrDDMMYYYY[2],toDateArrDDMMYYYY[1]-1,toDateArrDDMMYYYY[0]);
  	
  	if(fromDateAsDate>toDateAsDate)
  		{
  			alert("From Date should be less than or equal to To Date");
  			window.location.reload();        			
  		}
  }
  
  function ReloadFilters()
  {
	  window.location="?a=showChallans&type=${param.type}&firmId="+drpfirmId.value+"&txtfromdate="+txtfromdate.value+"&txttodate="+txttodate.value;
	  
  }
  
  txtfromdate.value='${txtfromdate}';
  txttodate.value='${txttodate}';
  drpfirmId.value='${firmId}';
  
  
  function deleteChallan(customerId)
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
  	  xhttp.open("GET","?a=deleteChallan&type=${param.type}&challanid="+customerId, true);    
  	  xhttp.send();
  }
  
  
  function generatePdfChallanIn(challanId)
  {
  	var xhttp = new XMLHttpRequest();
  	  xhttp.onreadystatechange = function() 
  	  {
  	    if (xhttp.readyState == 4 && xhttp.status == 200) 
  	    { 		      
  	    	window.open("BufferedImagesFolder/"+xhttp.responseText);		  
  		}
  	  };
  	  xhttp.open("GET","?a=generateChallanPDF&challanId="+challanId+"&type=${param.type}", false);    
  	  xhttp.send();
  }
  function generateInvoice(type,challanId)
  {
	  if(type=='I')
		  {
	  		window.location="?a=showGeneratePI&challanId="+challanId;
		  }
	  else
		  {
		  	window.location="?a=showGenerateSI&challanId="+challanId;	
		  }
	  	  
  }
  
  
</script>