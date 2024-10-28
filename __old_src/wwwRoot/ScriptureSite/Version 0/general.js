var prev_log_time = "";
var log_win_obj = "";
function StartLog() 
{
	var log_win = window.open("");
	log_win.document.body.innerHTML = "<Span id=LogControl width=50% bgcolor=yellow>Log Entries<BR></Span>";

	log_win_obj = log_win;
	
	LogEvent("Starting Log");
}

function LogEvent(event_description) 
{
	// get the current time
	var current_date = new Date();
	var current_time = current_date.getTime();
	
	// subtract it from the previous time (from global var)
	var time_diff = current_time - prev_log_time;
	
	// create a string with event_desc, current time, time diff
	var log_str = event_description + "----" + 
					current_date.getHours() + "-" + 
					current_date.getMinutes() + "-" + 
					current_date.getSeconds() + "-" + 
		   		    current_date.getMilliseconds() + "----" + 
				  time_diff + "<BR>";
	
	// get the control for display of log and append
	log_win_obj.document.all("LogControl").innerHTML = log_win_obj.document.all("LogControl").innerHTML + log_str;
	
	// set the prev global var
	prev_log_time = current_time;
}