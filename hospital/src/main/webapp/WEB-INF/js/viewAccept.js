function Myfuncion() {

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
	
}


