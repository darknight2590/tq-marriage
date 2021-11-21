var kisi = "asdas"

window.addEventListener("message", function (event) {
    if (event.data.display) {
        $('#text').html(event.data.isim + " ile evlenmeyi kabul ediyor musun?");
        kisi = event.data.kimlik;
        $('.thermiteqy').css('display', 'block');
    } else {
        $('.thermiteqy').css('display', 'none');
    }
});

$(document).on('click', '#married-accept', function(e){
    e.preventDefault();

    $.post('https://tq-marriage/accept', JSON.stringify({
        forring : kisi,
    }));
});

$(document).on('click', '#married-cancel', function(e){
    e.preventDefault();

    $.post('https://tq-marriage/denied', JSON.stringify({
        forring : kisi,
    }));
});