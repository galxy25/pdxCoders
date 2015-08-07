$(document).ready(function(){
    //$(".edit_handler").on("click", function(){
    $("#user_playlists li").on("click", function(event){
        var playlistName = $(this).text();

        var playlist_id = $(this).attr('playlist-id');

        var route = '/playlists/' + playlist_id + '/cards.json';

        $.get(route, function(data) {
            alert("FART");
            alert(data);
            var thingy = $.parseJSON(data);
            //var cards = $.parseJSON(data.card);

            $.each(thingy, function(key, value) {
                alert(value);
            });
        });
        // Grab the id from whatever got clicked?
        // Get the json from the route for that id
        // Fill #edit_playlist_dialog with the info.
        // Open the dialog

        $('#edit_playlist_dialog').dialog({
            autoOpen: false,
            draggable: true,
            modal: true,
            resizable: false,
            title: "Edit Playlist: " + $(this).text(),
            width: 750,
            buttons: {
                Save: function() {alert("submit edit"); var idsInOrder = $("#sortable2").sortable("toArray"); console.log(idsInOrder);
                    $('#edit_playlist_dialog').dialog("close");},
                Cancel: function() {$('#edit_playlist_dialog').dialog("close");}
            }

        }).dialog("open").css('display', 'block');

        $('#sortable').sortable({
            axis: "y",
            cursor: "move"
        });

        var title = $(this).text();
        var splits = title.split('(');

        $('#playlist_title').val(splits[0].trim());


    });


})

