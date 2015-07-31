$(document).ready(function(){
    $("#user_playlists li").on("click", function(){
        $('#edit_playlist_dialog').dialog({
            autoOpen: false,
            draggable: true,
            modal: true,
            resizable: false,
            title: "Edit Playlist: " + $(this).text(),
            width: 750,
            buttons: {
                Edit: function() {alert("submit edit")},
                Cancel: function() {$('#edit_playlist_dialog').dialog("close"); $('#edit_playlist_dialog').empty();}
            }
        }).dialog("open");
    });
})

