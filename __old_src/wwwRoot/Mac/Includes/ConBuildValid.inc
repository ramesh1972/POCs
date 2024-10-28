if(document.frmContBuild.lstConCode.value=="" )
	     {
	     alert("Contract Code Must Not Left Blank")
	     document.frmContBuild.lstConCode.focus()
	     return false;   
	     }
	  if(document.frmContBuild.txtDesc.value =="")
	    {
	     alert("Contract Description Code Must Not Left Blank")
	     document.frmContBuild.txtDesc.focus()
	     return false;
	    }
	    
	  if(document.frmContBuild.lstConGrp.value=="")
	    {
	    alert("Contract Group Code Must Not Left Blank")
	    document.frmContBuild.lstConGrp.focus()
	    return false;
	    }
	    
	  if(document.frmContBuild.lstConType.value=="")
	    {
	    alert("Contract Type Code Must Not Left Blank")
	    document.frmContBuild.lstConType.focus()
	    return false;
	    }
	    
	  if(document.frmContBuild.txtContBasePrice.value=="")
	    {
	    alert("Contract Base Price Must Not Left Blank")
	    document.frmContBuild.txtContBasePrice.focus()
	    return false;
	    }
	    
	  if(document.frmContBuild.txtContBasePrice.value <0 )
	    {
	    alert("Not a valid price")
	    document.frmContBuild.txtContBasePrice.focus()
	    return false;
	    }
	  
	  if(document.frmContBuild.lstConStatus.value=="")
	    {
	    alert("Contract Status Code Must Not Left Blank")
	    document.frmContBuild.lstConStatus.focus()
	    return false;
	    }
	  
	  if(document.frmContBuild.lstConUnit.value=="")
	    {
	    alert("Contract Unit Code Must Not Left Blank")
	    document.frmContBuild.lstConUnit.focus()
	    return false;
	    }
	    
	  if(document.frmContBuild.txtTrdStDate.value=="")
	    {
	    alert("Contract Trade Start Date Must Not Left Blank")
	    document.frmContBuild.txtTrdStDate.focus()
	    return false;
	    }
	    
	  if(document.frmContBuild.txtTrdEndDate.value=="")
	    {
	    alert("Contract Trade End Date Must Not Left Blank")
	    document.frmContBuild.txtTrdEndDate.focus()
	    return false;
	    }
	   
	 if(document.frmContBuild.txtDlvdStDate.value=="")
	    {
	    alert("Contract Delivery Start Date Must Not Left Blank")
	    document.frmContBuild.txtDlvdStDate.focus()
	    return false;
	    } 
	 
	  if(document.frmContBuild.txtDlvEndDate.value=="")
	    {
	    alert("Contract Delivery End Date Must Not Left Blank")
	    document.frmContBuild.txtDlvEndDate.focus()
	    return false;
	    }   
	    
	  if(document.frmContBuild.txtDlvEndDate.value < document.frmContBuild.txtDlvdStDate.value)
	    {
	    alert("Delivery End Date must be greater or equals to Start date")
	    document.frmContBuild.txtDlvdStDate.focus()
	    return false;
	    }
	    
	  if(document.frmContBuild.txtTrdStDate.value > document.frmContBuild.txtTrdEndDate.value)
	    {
	    alert("Trade End Date must be greater than Start date"")
	    document.frmContBuild.txtTrdStDate.focus()
	    return false;
	    } 
	  
	  if(document.frmContBuild.txtTrdStDate.value > document.frmContBuild.txtDlvdStDate.value)
	    {
	    alert("Delivery Should Start After Trading Start")
	    document.frmContBuild.txtDlvdStDate.focus()
	    return false;
	    } 
	 
	  if(document.frmContBuild.txtDlvdStDate.value > document.frmContBuild.txtDlvEndDate.value)
	    {
	    alert("Trading Should Close Before Delivery Start")
	    document.frmContBuild.txtDlvdStDate.focus()
	    return false;
	    }   
	  
	  if(document.frmContBuild.txtDlvdStDate.value > document.frmContBuild.txtDlvEndDate.value)
	    {
	    alert("Trading Should Close Before Delivery Start")
	    document.frmContBuild.txtDlvdStDate.focus()
	    return false;
	    }   
	  if(document.frmContBuild.txtCirFilter.value!="")
	    {
	      if(document.frmContBuild.txtCirFilter.value>10)
	         {
	          alert("Circuit Filter Percentage Should Be Less Than 10")
	          document.frmContBuild.txtCirFilter.focus()
	          return false;
	         }
	     }   
	     
	  if(document.frmContBuild.txtSettleFilter.value!="")
	    {
	      if(document.frmContBuild.txtSettleFilter.value>100)
	         {
	          alert("Percentage cannnot be more than 100"")
	          document.frmContBuild.txtSettleFilter.focus()
	          return false;
	         }
	     }  
	   
	   if (isNaN(document.frmContBuild.txtMktLot.value)==true)
	      {
			alert("Market Lot Should have only Numerals");
			return false;
		  }                        
	   
	   if (document.frmContBuild.txtMktLot.value<0)
	      {
			alert("Market Lot Should not be Negative")
			document.frmContBuild.txtMktLot.focus()   
			return false;
		  }                        
	                 
	   if (isNaN(document.frmContBuild.txtOCPTrdCount.value)==true)
	      {
			alert("OCP trade count have only Numerals");
			return false;
		  }                        
	   
	   if (document.frmContBuild.txtOCPTrdCount.value<0)
	      {
			alert("OCP trade Count  Should not be Negative")
			document.frmContBuild.txtOCPTrdCount.focus()   
			return false;
		  }
	   
	   if (isNaN(document.frmContBuild.txtOCPTrdDuration.value)==true)
	      {
			alert("OCP Duration  have only Numerals");
			return false;
		  }                        
	   
	   if (document.frmContBuild.txtOCPTrdDuration.value<0)
	      {
			alert("OCP Duration  Should not be Negative")
			document.frmContBuild.txtOCPTrdDuration.focus()   
			return false;
		  }  
	  
	   if (isNaN(document.frmContBuild.txtContBasePrice.value)==true)
	      {
			alert("Contract Base price  have only Numerals");
			return false;
		  }                        
	   
	   if (document.frmContBuild.txtContBasePrice.value<0)
	      {
			alert("Contract Base price should not be Negative")
			document.frmContBuild.txtContBasePrice.focus()   
			return false;
		  }  
	   if (isNaN(document.frmContBuild.txtCirFilter.value)==true)
	      {
			alert("Circuit Filter  have only Numerals");
			return false;
		  }                        
	   
	   if (document.frmContBuild.txtCirFilter.value<0)
	      {
			alert("Circuit filter  should not be Negative")
			document.frmContBuild.txtCirFilter.focus()   
			return false;
		  }  
	   	                	                        
	   if (isNaN(document.frmContBuild.txtSettleFilter.value)==true)
	      {
			alert("Settelment Circuit Filter  have only Numerals");
			return false;
		  }                        
	   
	   if (document.frmContBuild.txtSettleFilter.value<0)
	      {
			alert("Settelment filter  should not be Negative")
			document.frmContBuild.txtSettleFilter.focus()   
			return false;
		  }  
	  