function getTotalProductPrice(){
	if(document.getElementById('unit_price').value == "" || document.getElementById('quantity_per_unit').value == ""){
		document.getElementById('display_field').value = "";
		return;
	}
	
	var total = document.getElementById('unit_price').value * document.getElementById('quantity_per_unit').value;
	document.getElementById('display_field').value = total.toFixed(2);
}

