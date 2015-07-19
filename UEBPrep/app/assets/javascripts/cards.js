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