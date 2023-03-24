function Myfuncion() {
	/*
	let a = document.queryselector('.medicomcount');
	console.log(a);
	let b = document.queryselector('.room');
	let c = document.queryselector('.meal');
	let d = document.queryselector('.injection');
	let e = document.queryselector('.medicine');
	let f = document.queryselector('.btest');
	let g = document.queryselector('.utest');
	*/
	
	let medicomcount = $(".medicomcount").val();
	let room = $(".room").val();
	let meal = $(".meal").val();
	let injection = $(".injection").val();
	let medicine = $(".medicine").val();
	let btest = $(".btest").val();
	let utest = $(".utest").val();
	console.log(medicomcount);
	console.log(room);
	console.log(meal);
	console.log(injection);
	console.log(medicine);
	console.log(btest);
	console.log(utest);
	
	let total = Number(medicomcount) + Number(room) + Number(meal) + Number(injection) + Number(medicine) + Number(btest) + Number(utest)
	console.log(total);
	
	$("#total").val(total);
	
	$(".healthS").val(total * 0.2);	
	$("#healthC").val(total * 0.8);	
	
	$(".medicalS").val(total * 0.1);
	$("#medicalC").val(total * 0.9);
	
	//let total = document.queryselector('.total')
//	total.value = a.value + b.value + c.value + d.value + e.value + f.value + g.value;
	//var total = a.value/* + b.value + c.value + d.value + e.value + f.value + g.value */
	//document.getElementById("total").val("왜 안나와");
	//$('input[name=total]').attr('value',total);
}


