$(document).ready(function(){
    //$(".edit_handler").on("click", function(){
    $("#user_playlists li").on("click", function(event){
        var playlist_id = $(this).attr('playlist-id');

        var route = '/playlists/' + playlist_id + '/cards.json';

        $.getJSON(route, function(data) {
            var cards = $.parseJSON(data.card);
            var list_items = [];
            $.each(cards, function(key, val) {
                var title;
                if (typeof val.card.content.title == 'undefined') {
                    title = val.card.content.text;
                } else {
                    title = val.card.content.title;
                }
                list_items.push( "<li id='" + val.card.id + " class='ui-sortable-handle'>" + title + "</li>");
            });
            $('#edit_playlist_dialog ul').empty();
            $('#edit_playlist_dialog ul').append(list_items);
        });

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
});
