var CART_ITEMS = $('#cartItems');
var ADD_TO_CART = $('#addToCart')

ADD_TO_CART.onclick(function (){
    var data = {id: ADD_TO_CART.val()};
    fetch("/book/addToCart", {
        method: "POST",
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    }).then(function (){
        var cur = parseInt(CART_ITEMS);
        CART_ITEMS.html(cur+1);
    });
    // $.ajax({
    //     url: "/book/addToCart",
    //     method: "POST",
    //     data:{id: id}
    // }).success(function () {
    //
    // })
})