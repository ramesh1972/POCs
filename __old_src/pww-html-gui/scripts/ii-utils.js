// Util functions
function array_get_element_pos(a, elem)
{
	for (var i=0;i<a.length;i++)
	{
		if (a[i].id == elem.id)
			return i;
	}
	
	return -1;
}

function array_remove_element(a, elem)
{
	var found = false;
	var pos = -1;
	for (var i=0;i<a.length;i++)
	{
		if (!found && a[i].id == elem.id)
		{
			pos = i;
			found = true;
		}
		
		if (found && i != a.length-1)
			a[i] = a[i+1];
	}
	
	if (found)
	{
		a.pop();
	}

	return pos;
}

function array_move_last_element_to_pos(a, elem, pos)
{
	if (pos == -1)
		return;
		
	if (a.length == 0)
	{ 
		a[0] = elem;
		return;
	}
	
	for (var i=a.length-1;i>=0;i--)
	{
		if (i == pos)
		{
			a[i+1] = a[i];
			a[i] = elem;
			break;
		}

		a[i+1] = a[i];
	}
	
	a.pop();
}
