<style>
	.date_field {position: relative; z-index:1000;}
	.ui-datepicker{position: relative; z-index:1000!important;}
</style>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="ListLedger" value='${requestScope["outputObject"].get("ListLedger")}' />
<c:set var="customerDetails" value='${requestScope["outputObject"].get("customerDetails")}' />

<c:set var="totalDetails" value='${requestScope["outputObject"].get("totalDetails")}' />
<c:set var="customerMaster" value='${requestScope["outputObject"].get("customerMaster")}' />
<c:set var="ListOffirms" value='${requestScope["outputObject"].get("ListOffirms")}' />

<c:set var="txtfromdate" value='${requestScope["outputObject"].get("txtfromdate")}' />
<c:set var="txttodate" value='${requestScope["outputObject"].get("txttodate")}' />

<br>


<div class="card">


<br>

<div class="row">
              
              
              
              
              
              
              
               
              
              
				<div class="col-sm-2" align="center">
					<div class="input-group input-group-sm" style="width: 200px;">
  						<input type="text" id="txtfromdate" onchange="checkforvalidfromtodate();ReloadFilters();"  name="txtfromdate" readonly class="form-control date_field" placeholder="From Date"/>
                  </div>
				</div>
				
				<div class="col-sm-2" align="center">
					<div class="input-group input-group-sm" style="width: 200px;">
					<input type="text" id="txttodate"  onchange="checkforvalidfromtodate();ReloadFilters();"    name="txttodate" readonly class="form-control date_field"  placeholder="To Date"/>
  						
                    </div>
				</div>
				
				
				
				
				<div class="col-sm-2" align="center">
					<div class="input-group input-group-sm" style="width: 200px;">
	  					<select id="drpFirmId" name="drpFirmId"  class="form-control float-right" onchange='ReloadFilters()' style="margin-right: 15px;" >
	  						
	  						<option value='-1'>--Select--</option>  						
	  						<c:forEach items="${ListOffirms}" var="firm">
								<option value='${firm.firmId}'> ${firm.firmName}</option>
							</c:forEach>  							
	  					</select>
                  	</div>
				</div>
				
				<div class="col-sm-2" align="center">
					<div class="input-group input-group-sm" style="width: 200px;">


				<datalist id="customerList">
				<c:forEach items="${customerMaster}" var="customer">
						<option id="${customer.customerId}">${customer.customerName}~${customer.mobileNumber}~${customer.customerType}</option>
					</c:forEach>
				</datalist>
				
			<div class="input-group input-group-sm" style="width: 200px;">
				<input type="text" class="form-control form-control-sm"
					id="txtsearchcustomer" placeholder="Search"
					name="txtsearchcustomer" autocomplete="off"
					oninput="checkforLengthAndEnableDisable();checkforMatchCustomer()">
				<input type="hidden" name="hdnSelectedCustomer"
					id="hdnSelectedCustomer" value=""> <span
					class="input-group-append">
					<button type="button" class="btn btn-danger btn-flat"
						onclick="resetCustomer()">Reset</button>
				</span>
			</div>
                  	</div>
				</div>
				
				
				
				
				<div class="col-sm-2" align="center">
							 <div class="card-tools">
                  <div class="input-group input-group-sm" align="center" style="width: 200px;display:inherit">
                    <div class="icon-bar" style="font-size:22px;color:firebrick">
  						<a title="Download Excel" onclick="downloadExcel()"><i class="fa fa-file-excel-o" aria-hidden="true"></i></a> 
 						<a title="Download PDF" onclick="exportPDFForLedger()"><i class="fa fa-file-pdf-o"></i></a>
  						<a title="Download Text"  onclick="downloadText()"><i class="fa fa-file-text-o"></i></a>  
					</div>           
                  </div>
                </div>
				</div>
				
			  </div>


           <div class="card-header">    
                
                
                
               
                               
                               
              </div>
              
                <div class="card-body table-responsive p-0">                
                <table id="testing"class="table table-head-fixed  table-bordered table-striped" role="grid" aria-describedby="example1_info">             
                 <thead>
                    <tr>                  
                    <th colspan="3"><b>Name:-${customerDetails.customer_name }</b></th>
                    <th colspan="2"><b>Type:- ${customerDetails.customer_type }</b></th>
                    <th colspan="1"><b>From Date:-${fromDate1}</b></th>                    
                    <th colspan="1"><b>To Date:-${toDate1}</b></th>                                        
                     </th>
                     </tr>
                  <thead>    
                  
              
				
				
                  </tbody>
                </table>
              </div>
              

            
              
              
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 580px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">             
                  <thead>
                    <tr>
                    <th><b>Firm Name</b></th>
                    <th><b>Transaction Date</b></th>
					<th><b>Particular</b></th>                    
                    <th><b>Transaction Type</b></th>
                     <th><b>Ref Id</b></th>
                     
                    
                     <th><b>Debit</b>
                     <th><b>Credit</b>
                     
                     
                     
                     
                     
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${ListLedger}" var="item">
					<tr >
					<td>${item.firm_name}</td>
					<td>${item.transaction_date}</td>
										<td>${item.Particular}</td>
					
					<td>${item.type}</td>
					
						<td>
						
						<c:if test="${item.type eq 'Sales' }">
							<a href="?a=showGenerateSI&invoiceId=${item.RefId}">${item.RefId}</a>
						</c:if>						
						
						
						<c:if test="${item.type eq 'Purchase' }">
							<a href="?a=showGeneratePI&invoiceId=${item.RefId}">${item.RefId}</a>
						</c:if>
						
						
						<c:if test="${item.type eq 'JournalEntryDebit'or item.type eq 'JournalEntryCredit'}">
							<a href="?a=showJournalEntry&journal_id=${item.RefId}">${item.RefId}</a>
						</c:if>
						
						
						<c:if test="${item.type eq 'Collection' or item.type eq 'Payment'}">
							<a href="?a=showAddTransactions&payment_id=${item.RefId}">${item.RefId}</a>
						</c:if>
						
						
						</td>
						
						<td>${item.debitAmount}</td>
						<td>${item.creditAmount}</td>  
											
						  
					
						
					</tr>
				</c:forEach>
				
				
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
              
              
                <div class="card-body table-responsive p-0">                
                <table id="testing"class="table table-head-fixed  table-bordered table-striped" role="grid" aria-describedby="example1_info">             
                 <thead>
                    <tr>                  
                    <th colspan="3"></th>
                    <th colspan="2">Opening Balance: ${totalDetails.openingAmount} </th>
                    <th colspan="1"><b>Debit Total: ${totalDetails.debitSum}</b></th>                    
                    <th colspan="1"><b>Credit Total: ${totalDetails.creditSum}</b></th>
                    <th colspan="1"><b>Closing Balance : ${totalDetails.totalAmount}</b></th>                                        
                     </th>
                     </tr>
                  <thead>    
                  
              
				
				
                  </tbody>
                </table>
              </div>
              
              
              
</div>
            
            
            
            



<script>
  $(function () {
    
    $('#example1').DataTable({
      "paging": true,      
      "lengthChange": false,
      "searching": false,      
      "info": true,
      "autoWidth": false,
      "responsive": true,
      "pageLength": 50,
      "order": [[ 4, 'desc' ]],
      "zeroRecords": " "

    });
  });
  
  document.getElementById("divTitle").innerHTML="Ledger Report";
  
  
  $( "#txtfromdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
  $( "#txttodate" ).datepicker({ dateFormat: 'dd/mm/yy' });



  txtfromdate.value='${txtfromdate}';
  txttodate.value='${txttodate}';
  
  if('${param.customerId}'!='')
	{
		txtsearchcustomer.value='${customerDetails.customer_name}';//
		hdnSelectedCustomer.value='${customerDetails.customer_id}';//
		txtsearchcustomer.disabled=true;
	}
  
  
  drpFirmId.value='${param.firmId}';

  

  

  
  
  
  function exportPDFForLedger()
  {
	  
	  var stringtosend="?a=exportCustomerLedgerAsPDF&fromDate="
			+ txtfromdate.value + "&toDate=" + txttodate.value
			+ "&customerId=" + hdnSelectedCustomer.value + "&firmId="
			+ drpFirmId.value;
	  window.open(stringtosend);
		return;

  }
  

	function checkforvalidfromtodate() {
		var fromDate = document.getElementById("txtfromdate").value;
		var toDate = document.getElementById("txttodate").value;

		var fromDateArr = fromDate.split("/");
		var toDateArr = toDate.split("/");

		var fromDateArrDDMMYYYY = fromDate.split("/");
		var toDateArrDDMMYYYY = toDate.split("/");

		var fromDateAsDate = new Date(fromDateArrDDMMYYYY[2],
				fromDateArrDDMMYYYY[1] - 1, fromDateArrDDMMYYYY[0]);
		var toDateAsDate = new Date(toDateArrDDMMYYYY[2],
				toDateArrDDMMYYYY[1] - 1, toDateArrDDMMYYYY[0]);

		if (fromDateAsDate > toDateAsDate) {
			alert("From Date should be less than or equal to To Date");
			window.location.reload();
		}
	}

	function ReloadFilters() {
		window.location = "?a=showCustomerLedger&txtfromdate="
				+ txtfromdate.value + "&txttodate=" + txttodate.value
				+ "&customerId=" + hdnSelectedCustomer.value + "&firmId="
				+ drpFirmId.value;
	}

	function checkforLengthAndEnableDisable() {
		if (txtsearchcustomer.value.length >= 3) {
			txtsearchcustomer.setAttribute("list", "customerList");
		} else {
			txtsearchcustomer.setAttribute("list", "");
		}
	}

	function checkforMatchCustomer() {

		var searchString = document.getElementById("txtsearchcustomer").value;
		var options1 = document.getElementById("customerList").options;
		var customerId = 0;
		for (var x = 0; x < options1.length; x++) {
			if (searchString == options1[x].value) {
				customerId = options1[x].id;

				break;
			}
		}
		if (customerId != 0) {
			document.getElementById("hdnSelectedCustomer").value = customerId;
			document.getElementById("txtsearchcustomer").disabled = true;
			ReloadFilters();
		} else {
			//searchForCustomer(searchString);
		}

	}

	function resetCustomer() {
		txtsearchcustomer.disabled = false;
		txtsearchcustomer.value = "";
		hdnSelectedCustomer.value = "";
		ReloadFilters();
	}
</script>