$(document).ready(function(){
	$(document).on('click',".add-question,.add-option,.add-questiontype",init_element);
  $(document).on('click',".remove-option,.remove-questiontype,.remove-question",remove_div);
	$(".submit-form").submit(ordering);
	$(".question-sortable,.option-sortable,.questiontype-sortable").sortable();

	function init_element(){
    console.log("working successfully");
		var button= $(this).data("name");
		var button_type=$(this).siblings(".".concat(button,"-type"));
		var hidden_button=button_type.children('.hidden'+button);
		var hidden_button_length=hidden_button.length
		if((!hidden_button.is(":visible"))&&(hidden_button_length==1)){
			hidden_button.show();
			hidden_button.find(":input").prop('disabled', false)
		}
		else{
			var clonedtype=hidden_button.last().clone();
			clonedtype.find('div.signup-error').remove();
			button_type.append(clonedtype)
			$(":input",clonedtype).each(function(){
				this.name=this.name.replace(this.name.substr(this.name.indexOf(button)),this.name.substr(this.name.indexOf(button)).replace(/[0-9]+/,hidden_button_length))
			});
			if(button == "question"){
				$('.option-sortable,.questiontype-sortable', clonedtype).sortable();
			}
		}
	}

	function remove_div(){
		var button=$(this).data("name");
		var button_type=$(this).closest("."+button+"-type");
    var hidden_button=button_type.children('.hidden'+button);
    var this_button=$(this).closest('.hidden'+button)
		if(hidden_button.length>1){
			var namestring=this_button.find(":input")[0].name
			var index=parseInt(namestring.substring(namestring.indexOf(button)).match(/[0-9]+/)[0])
			button_type.find(":input").each(function(){
				ind=parseInt(this.name.substring(this.name.indexOf(button)).match(/[0-9]+/)[0])
				if(ind>index)
					this.name=this.name.replace(this.name.substr(this.name.indexOf(button)),this.name.substr(this.name.indexOf(button)).replace(/[0-9]+/,ind-1))
			})
			this_button.remove();
		}
		else
		{
			this_button.hide();
			this_button.find(":input").prop('disabled',true);
		}
	}

	function ordering(){
		$(".question-type").children('div').each(function(index){
			$(this).children(".order-question").find(":input").first().val(index+1)
			$(this).children(".option-type").children('div').each(function(ind){
				$(this).children(".order-option").find(":input").first().val(ind+1)
			});
		});
	}
});
