$(document).ready(function() {
    $('#cardtype').change(function(){
        $('label[for="cardtitle"]').css('display', 'none');
        $('#cardtitle').css('display', 'none');
        $('label[for="cardtext"]').css('display', 'none');
        $('#cardtext').css('display', 'none');
        $('label[for="cardimage"]').css('display', 'none');
        $('#cardimage').css('display', 'none');
        $('label[for="cardimagealt"]').css('display', 'none');
        $('#cardimagealt').css('display', 'none');
        $('label[for="uploadcardimage"]').text("Cannot upload an image for this card type");
        $('#cardsubmit').css('display', 'none');
        var type = $('#cardtype').val();
        if (type == "text"){
            $('label[for="cardtext"]').css('display', 'block');
            $('#cardtext').css('display', 'block');
            $('#cardsubmit').css('display', 'block');
        }
        else if (type == "rule"){
            $('label[for="cardtitle"]').css('display', 'block');
            $('#cardtitle').css('display', 'block');
            $('label[for="cardtext"]').css('display', 'block');
            $('#cardtext').css('display', 'block');
            $('#cardsubmit').css('display', 'block');
        }
        else if (type == "image"){
            $('label[for="cardtitle"]').css('display', 'block');
            $('#cardtitle').css('display', 'block');
            $('label[for="cardtext"]').css('display', 'block');
            $('#cardtext').css('display', 'block');
            $('label[for="cardimage"]').css('display', 'block');
            $('#cardimage').css('display', 'block');
            $('label[for="cardimagealt"]').css('display', 'block');
            $('#cardimagealt').css('display', 'block');
            $('label[for="uploadcardimage"]').text("Upload an image");
            $('#uploadcardimage').prop('disabled', false);
            $('#cardsubmit').css('display', 'block');
        }
    });
});

$(function() {
    $('#uploadcardimage').on('change', function(event) {
        var files = event.target.files;
        var image = files[0]
        var reader = new FileReader();
        reader.onload = function(file) {
            var img = new Image();
            img.src = file.target.result;
            $('#cardimage').attr('src',img.src);
        }
        reader.readAsDataURL(image);
    });
});

$(document).ready(function() {
    var card_id = $("#card-id").attr('card-id');
    $('.drop-item').click(function(event){
        var playlist_id = $(this).attr('id');
        var route = '/playlists/' + playlist_id + '/add_card/' + card_id;
        $.ajax({
            url: route,
            type: 'PUT',
            success: function(result) {
                // ??
            }
        });
    });
});

$(document).ready(function() {
    $("#newPlaylistModal input[type=submit]").click(function() {
        var input_name = $("#newPlaylistModal input[type=text]").val();
        $.post('/playlists', { playlist: { name: input_name  }, ajax: true });
        $.getJSON('/users/1/playlists.json', function(data) {
            var playlists = $.parseJSON(data.playlists);
            var list_items = [];
            $.each(playlists, function(key, val) {
                alert(val + ' | ' + val.playlist.id + ' | ' + val.playlist.name);
                list_items.push( "<li id='" + val.playlist.id + "' class='drop-item'><a href='#'>" + val.playlist.name + "</a></li>");
            });
            list_items.push("<li id='card-view-new-playlist' class='drop-item'><a href='#' data-reveal-id='newPlaylistModal'>New Playlist...</a></li>");
            $('#add-to-playlist').empty();
            $('#add-to-playlist').append(list_items);
            $(document).foundation();
        });
        $("#newPlaylistModal .close-reveal-modal").trigger("click");
    });
});