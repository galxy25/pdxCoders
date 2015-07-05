$(document).ready(function() {
    $('#card_type').change(function(){
        $('#card_title_tr').remove();
        $('#card_textarea_tr').remove();
       var type = $('#card_type').val();
        if (type == "text"){
            $('<tr/>', {
                'id':'card_textarea_tr',
            }).insertAfter($('#card_type_tr'));
            $('<td/>', {
                'id':'card_textarea_td',
            }).appendTo($('#card_textarea_tr'));
            $('<label/>', {
                'id':'card_textarea_label',
                'text': 'Card Text:  '
            }).appendTo($('#card_textarea_td'));
            $('<textarea/>', {
                'id':'card_textarea',
                'class':'card-textarea'
            }).appendTo($('#card_textarea_label'));
        }
        else if (type == "rule"){
            $('<tr/>', {
                'id':'card_title_tr'
            }).insertAfter($('#card_type_tr'));
            $('<td/>', {
                'id':'card_title_td'
            }).appendTo($('#card_title_tr'));
            $('<label/>', {
                'id':'card_title_label',
                'class':'card-title-label',
                'text': 'Card Title:  '
            }).appendTo($('#card_title_td'));
            $('<input/>', {
                'type':'text',
                'id':'card_title',
                'class':'card-title'
            }).appendTo($('#card_title_td'))
            $('<tr/>', {
                'id':'card_textarea_tr'
            }).insertAfter($('#card_title_tr'));
            $('<td/>', {
                'id':'card_textarea_td'
            }).appendTo($('#card_textarea_tr'));
            $('<label/>', {
                'id':'card_textarea_label',
                'class':'card-textarea-label',
                'text': 'Card Text:  '
            }).appendTo($('#card_textarea_td'));
            $('<textarea/>', {
                'id':'card_textarea',
                'class':'card-textarea'
            }).appendTo($('#card_textarea_label'));
        }
    });
});