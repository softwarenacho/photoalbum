$(document).ready(function() {
	// Este código corre después de que `document` fue cargado(loaded) 
	// completamente. 
	// Esto garantiza que si amarramos(bind) una función a un elemento 
	// de HTML este exista ya en la página. 
  $("#login_form").submit(function(event) {
    event.preventDefault();
    var form_data = $("#login_form").serializeArray();
    var url = "/feed"
    $.post("/login", form_data, function(data){
      if (data == "User or password are incorrect") {
        $("#result").html(data);
      } else {
        window.location.href = url;
      }
    });
  });

  $("#register_form").submit(function(event) {
    event.preventDefault();
    var form_data = $("#register_form").serialize();
    var url = "/feed"
    $.post("/save_user", form_data, function(data){
      //console.log(data);
      if (data == "Your passwords do not match, please retype.") {
        $("#result").html(data);
      } else if (data == "Your email is already registered.") {
        $("#result").html(data);
      } else {
        window.location.href = url;
      }
    });
  });

  $("#update_user").submit(function(event) {
    event.preventDefault();
    var form_data = $("#update_user").serialize();
    var url = "/edit"
    $.post("/update_user", form_data, function(data){
      //console.log(data);
      if (data == "Your passwords do not match, please retype.") {
        $("#result").html(data);
      } else if (data == "Your email is already registered.") {
        $("#result").html(data);
      } else {
        $("#result").html(data);
      }
    });
  });

  //CARROUSEL FUNCTION'S
  var carousel = $('#frames'),
    images = carousel.find('li'),
    length = images.length,
    current = 1,
    first = images.filter(':first'),
    last = images.filter(':last');

    first.before(last.clone(true));
    last.after(first.clone(true));

    var width = (100 * length)+200;
    width += "%";

    $("#frames").css("width", width);

  $('.button_car').click( function (){

    var cycle, direction;
    cycle = false;
    direction = (this.id === "previous_frame")? -1 : 1;
  

    carousel.animate({ left: "+=" + (-550 * direction) }, 1000, function () {
      current += direction;
      cycle = !!(current === 0 || current > length)

      if (cycle) {
        current = (current === 0)? length : 1;
        carousel.css({left: -550 * current });
      }
    });
  });


  // ASYNC COMMENT FUNCTIONS
  $("#new_comment_button").click(function(event){
    event.preventDefault();
    var url_comment = "/comment_form";
    $("#comment_div").append(
      $("<form/>",{
        action: "/new_comment",
        method: "post",
        id: "new_comment"
      }).append (
      $("<textarea/>", {
        form: "new_comment",
        id: "comment_text",
        placeholder: "Comments", 
        rows: "6"
      }),
      $("<input/>", {
        type: "submit",
        value: "Submit"
      })
      )
    )
  });

  $("#comment_div").submit("#new_comment",function(event){
    event.preventDefault();
    var comment = $('#comment_text').val();
    var photo_id = $('#photo_id').val();
    var user_id = $('#user_id').val();
    var author = $('#user_name').val();
    console.log("name " + author + " comment " + comment + " photo id " + photo_id + "user id" + user_id);
    $("#comment_list").append('<h3 class="inline answer">' + comment + '<p class="score">Score: 0</p></h3><br><h5 class="inline">Author: <a href="/profile/<%= author.id %>">' + author + '</a></h5><br><br>');
    var url = "/answer_new/" + user_id + "&" + photo_id + "&" + comment;
    $.get(url);
    $("#comment_div").html("");
    alert("Your comment was saved successfully");
  });


  //END ASYN COM

  

  $(function() {
    $( "#sortable" ).sortable({
      update: function(){
        ordered_array = [];
        $.each($(".sort_element"), function(index, value){
          ordered_array.push($(value).data("index"));
        });
        $("#order").val(ordered_array);
      }
    });

  });

  $("#save_sort").click( function (){
    event.preventDefault();
    $.ajax({
      type: 'POST',
      url: '/save_sort',
      data: {order:ordered_array},
      async: false
    });

  });

});
