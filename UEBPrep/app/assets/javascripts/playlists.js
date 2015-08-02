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

