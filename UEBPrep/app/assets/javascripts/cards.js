$(document).ready(function() {
    $('#cardtype').change(function(){
        $('label[for="cardtitle"]').css('display', 'none');
        $('#cardtitle').css('display', 'none');
        $('label[for="cardtext"]').css('display', 'none');
        $('#cardtext').css('display', 'none');
        $('label[for="cardimage"]').css('display', 'none');
        $('#cardimage').css('display', 'none');
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
            $('#cardsubmit').css('display', 'block');
        }
    });
});