// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function toggleBG(item)
{
    if(item.style.backgroundColor == "rgb(102, 153, 51)")
	{
	item.style.backgroundColor = "#FFF";
	$("s"+item.id).value = "0";
	}
    else
    {
        item.style.backgroundColor = "#669933";
	$("s"+item.id).value = "1";
    }
    
}