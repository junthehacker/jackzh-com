(function(){
    renderMathInElement(
        document.body,
        {
            delimiters: [
                {left: "$$", right: "$$", display: true},
                {left: "\\[", right: "\\]", display: true},
                {left: "$", right: "$", display: false},
                {left: "\\(", right: "\\)", display: false}
            ]
        }
    );

    $("#mobile-nav-button").click(function() {
        const btnRef = $("#mobile-nav-button");
        btnRef.toggleClass("expanded");
        if(btnRef.hasClass("expanded")) {
            btnRef.html('<i class="fa fa-angle-up" aria-hidden="true"></i> Navigation')
        } else {
            btnRef.html('<i class="fa fa-angle-down" aria-hidden="true"></i> Navigation')
        }
        $(".navbar").toggleClass("expanded");
    })
})();
