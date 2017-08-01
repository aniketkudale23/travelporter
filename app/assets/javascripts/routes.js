
 $(document).ready(function(){

  
$('#find_form').submit(function(event){
event.preventDefault();
 var search = $("#search").val();
        var  destination = $("#destination").val();
        
        
         $.ajax({
            type: "POST",
            url: "/search",
            data: "search=" + search + "&destination=" + destination,
            success: function(data){
                 alert(data);
                 console.log(data.sources);
                 console.log(data);
                 $('#op').append(data);
            }
        });
});

});

