(function(){
	$(document).ready(function(){
		$('.show-bio').show();
		$('.hidden-bio').hide();
		$('.show-bio').click(function(){
			$('.hidden-bio').slideToggle(1);
		});
		runTooltip();
	});

	function runTooltip(){
		$(document).tooltip({
			items: '.show-bio',
			position: { my: "left+15 top", at: "top right" },
			content: function(callback){
				var user_id = $("#hidden-id").attr("value");
				$.ajax({
					url: "/users/" + user_id + "/tooltip",
					method: 'GET',
					dataType: 'html',
					success: function(data){
						callback(data);
					}
				});
			}
		});
	}

}());

