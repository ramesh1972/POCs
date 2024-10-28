
function DateValidation(MonthValue,DateValue)
{
 
 if (MonthValue==4 || MonthValue==6 || MonthValue==9 || MonthValue==11)
 {
   if (DateValue>30)
     alert('Please Select Below 31st');
  } 
   
}

function LeapYearValidation(YearValue,DateValue,MonthValue)
{
if (YearValue % 4 ==0 && MonthValue==2)
 {
   if (DateValue > 29 )
     {
     alert ('Please Select Below 29th');
     return false;
     }
 }
 else if (YearValue % 4 !=0 && MonthValue==2)
 {
    if (DateValue > 28)
		{
         alert ('Please Select Below 28th');
         alert('hi');
         return false;
         }
  }
 return true;
}

