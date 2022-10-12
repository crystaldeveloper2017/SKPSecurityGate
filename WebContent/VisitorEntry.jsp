<style>
	.date_field {position: relative; z-index:1000;}
	.ui-datepicker{position: relative; z-index:1000!important;}
</style>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<script>
function deleteVisitor(visitorId)
{
	
	var answer = window.confirm("Are you sure you want to delete ?");
	if (!answer) 
	{
		return;    
	}
	
	

	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() 
	  {
	    if (xhttp.readyState == 4 && xhttp.status == 200) 
	    { 		
	    	toastr["success"](xhttp.responseText);
	    	toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
	    	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
	    	  "hideDuration": "500","timeOut": "500","extendedTimeOut": "500","showEasing": "swing","hideEasing": "linear",
	    	  "showMethod": "fadeIn","hideMethod": "fadeOut"}
	    	
	    	window.location.reload();
		}
	  };
	  
	  xhttp.open("GET","?a=deleteVisitor&visitorId="+visitorId, true);    
	  xhttp.send();
}

</script>

<c:set var="message" value='${requestScope["outputObject"].get("ListOfVisitors")}' />
<c:set var="txtfromdate" value='${requestScope["outputObject"].get("txtfromdate")}' />
<c:set var="txttodate" value='${requestScope["outputObject"].get("txttodate")}' />

<br>
<div class="card">
	<br>
	
	<div class="row">
	
		<div class="col-sm-1" align="center">
			<label for="txtfromdate">From Date</label>
		</div>
	
		<div class="col-sm-2" align="center">
			<div class="input-group input-group-sm" style="width: 200px;">
				<input type="text" id="txtfromdate" onchange="checkforvalidfromtodate();ReloadFilters();"  name="txtfromdate" readonly class="form-control date_field" placeholder="From Date"/>
			</div>
		</div>
		
		<div class="col-sm-1" align="center">
			<label for="txttodate">To Date</label>
		</div>
	
		<div class="col-sm-2" align="center">
			<div class="input-group input-group-sm" style="width: 200px;">				
				<input type="text" id="txttodate"  onchange="checkforvalidfromtodate();ReloadFilters();"    name="txttodate" readonly class="form-control date_field"  placeholder="To Date"/>									
			</div>
		</div>
		
		<div class="col-sm-3" align="center">
			<div class="input-group input-group-sm" align="center" style="width: 200px;display:inherit">
				<div class="icon-bar" style="font-size:22px;color:firebrick">
					<a title="Download Excel" onclick="downloadExcel()"><i class="fa fa-file-excel-o" aria-hidden="true"></i></a> 
					<a title="Download PDF" onclick="downloadPDF()"><i class="fa fa-file-pdf-o"></i></a>
					<a title="Download Text"  onclick="downloadText()"><i class="fa fa-file-text-o"></i></a>  
				</div>           
			</div>
		</div> 
		 
		<div class="col-sm-3" align="center">
			<div class="input-group input-group-sm" style="width: 200px;">                    
				<input type="button"  class="btn btn-block btn-primary btn-sm" onclick="window.location='?a=showAddVisitor'" value="Add New Visitor" class="form-control float-right" >                      
			</div>
		</div>     
                
	</div>
	
              
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 580px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                  <thead>
                    <tr>
                     <th><b>Visitor Id</b></th>
                     <th><b>Name</b></th>
                     <th><b>Purpose Of Visit</b></th>
                     <th><b>Mobile No</b></th>
                     <th><b>Email</b></th>
                     <th><b>Updated Date</b><th></th><th></th>
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${message}" var="item">
					<tr >
						<td>${item.visitorId}</td>
						<td>${item.visitorname}</td>
						<td>${item.purpose_of_visit}</td>
						<td>${item.MobileNo}</td>
						<td>${item.EmailId}</td>
						<td>${item.in_time}</td>
						
						<td><button class="btn btn-danger" onclick="deleteVisitor(${item.visitorId})">Delete</button></td>
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
  
  document.getElementById("divTitle").innerHTML="Visitor Entry";
  document.title +=" Visitor Entry ";
  
  $( "#txtfromdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
  $( "#txttodate" ).datepicker({ dateFormat: 'dd/mm/yy' });
  
  txtfromdate.value='${txtfromdate}';
  txttodate.value='${txttodate}';
  
  function exportPDFForLedger()
  {
	  
	  window.open("?a=exportVisitorEntryAsPDF&fromDate="+txtfromdate.value+"&toDate="+txttodate.value);
		return;

  }  
  
  
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
  	  window.location="?a=showVisitorEntry&txtfromdate="+txtfromdate.value+"&txttodate="+txttodate.value;  	  
  }
  
  function searchprod(elementInput,evnt)
	{
		if(evnt.which==13)
			{
				// do some search stuff
				window.location="?a=showVisitorEntry&colNames="+document.getElementById("colNames").value+"&searchInput="+elementInput.value;
			}
			
	}

  
</script>