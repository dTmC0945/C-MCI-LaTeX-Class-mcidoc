// 
// #INFO: A Simple JS for WebBook Interface
// 
// -----------------------------------------------------------------------------
// 
// Author: DTMc
// 
// This file is part of lms.
// 
// lms is free software: you can redistribute it and/or modify it under the
// terms of the GNU General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later
// version.
// 
// lms is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
// 
// -----------------------------------------------------------------------------

/**
 * [toggleTOC enable/disable of the TOC on the left-hand-side]
 */
function toggleTOC() {
    const toc_state = document.getElementsByClassName('wide')[0].style.display;

    if ( toc_state == 'none') {
        $(".wide").animate({width:'toggle'},350);
    } else {
        $(".wide").animate({width:'toggle'},350);            
    }
}
// box-shadow: 0 0 0 max(100vh, 100vw) rgba(0, 0, 0, .3);
/**
   The following function shows/hide the help menu for how to use the `webBook'
   
 **/

function ShowHelpMenu() {


}

function gotoNextChapter() {

    var hreflink = document.
        getElementsByClassName('nav-next')[0].parentElement.href;

    if (typeof hreflink == 'undefined') {

        window.alert("Reached end of WebBook. There are no more chapters to continue...");
        
    } else {
        window.location.href = hreflink
    }

}

function gotoPrevChapter() {
    
    var hreflink = document.
        getElementsByClassName('nav-prev')[0].parentElement.href

    if (typeof hreflink == 'undefined') {

        window.alert("Reached beginning of WebBook. There are no more chapters to go back...");
        
    } else {
        window.location.href = hreflink
    }
}


function gotoChapterPage() {

    const hreflink = document.
          getElementsByClassName('nav-up')[0].parentElement.href
    window.location.href = hreflink

}


// -----------------------------------------------------------------------------

/**
 * Here we define all the possible custom mathematics environments and short
 * hand-notation for LaTeX.
 */
window.MathJax = {
    loader: {
        load: ['[tex]/physics']
    },
    options: {
        renderActions: {
            addMenu: []
        }
    },
    tex: { 
        inlineMath: [['$', '$'], ['\\(', '\\)']],
        tags: 'ams',
        packages: {'[+]': ['physics']},
        macros: {
            relax:      "" ,
            muz:        '{\\mu_{0}}',
            epz:        '{\\epsilon_{0}}',
            therefor:   '{\\qquad\\text{therefore}\\qquad}',
            ttherefor:  '{\\qquad\\text{therefore}\\qquad}',
            and:        '{\\qquad\\text{and}\\qquad}',
            aand:       '{\\qquad\\text{and}\\qquad}',
            where:      '{\\qquad\\text{where}\\qquad}',
            wwhere:     '{\\qquad\\text{where}\\qquad}',
            qtext:     ['{\\quad\\text{#1}\\quad}',1],
            qqtext:     ['{\\qquad\\text{#1}\\qquad}',1],
            rp:         ['\\qty(#2)^{#1}',2,""],
            verp:       ['{\\left|{#2}\\right|^{{#1}}}',2,""],
            diver:      ['{\\div{#1}}', 1],
            dd:         '{\\, \\textrm{d}}',
            card:       ['{#1}',1],
            num:        ["{#1}",1],
            Eval:       ["{#1}\\Biggr|_{#2}^{#3}",3],
            QED:        '{\\quad\\blacksquare}',
            coulConst:  '{\\frac{1}{4\\pi{\\varepsilon_{0}}}}',
            yp:          '{{y}^{\\prime}}',
            ypp:         '{{y}^{\\prime\\prime}}',
            super:      ['{{#1}^{#2}}',2],
            aci:         '{\\text{#1}^{\circ}}',
            pde:        ['{\\dfrac{\\partial^{#1} {#2}}{\\partial {#3}^{#1}}}',3, ""]
        },
    } 
};

// Display Hiders --------------------------------------------------------------

// Here we create a simple function to hide exercises and other relevant boxes
// as they are not immediately relevant to the reader.x

function HideMyBody(selected_button) {

    let current_state = selected_button.parentElement.nextElementSibling.style.display;

    var qs = selected_button.parentElement.nextElementSibling;
    var qqs = $(qs);
    
    $(qs).stop().slideToggle(500,"linear", function () {});
}

// Keyboard Event Control ------------------------------------------------------

document.addEventListener("keypress", function(event) {
    if (document.querySelectorAll('dialog')[0].checkVisibility()){
    } else {
        if (event.key == 't') {
            toggleTOC();
        } else if (event.key == 'n') {
            gotoNextChapter()
        } else if (event.key == 'p') {
            gotoPrevChapter()
        } else if (event.key == 'b') {
            window.scrollTo(0, document.body.scrollHeight);
        } else if (event.key == 'u') {
            document.body.scrollTop = document.documentElement.scrollTop = 0;
        } else if (event.key == 'd') {
            gotoChapterPage()
        }
    }
});

// Code Higlighting ------------------------------------------------------------

document.addEventListener('DOMContentLoaded', (event) => {
    document.querySelectorAll('pre code').forEach((block) => {
        hljs.addPlugin(new CopyButtonPlugin());
        hljs.highlightElement(block);
    });
});


// String Manipulations --------------------------------------------------------

// Here, we basically have to remove some text about the index and the number 0
// as they are a remnant of the make4ht and are also there as an `index.html' is
// required by github pages. Here, we quickly fixt the naming of them for better
// presentation.

document.addEventListener('DOMContentLoaded', (event) => {
    document.querySelectorAll('.chapterToc .title a')[0]
        .innerText = "Welcome to WebBook"

    document.querySelectorAll('.chapterToc .number')[0]
        .innerText = ""
});

// Here, we need to do a slight conversion of the infamous `chapter 0' as it
// is not correct and it would be better to filter it out and just write the
// `welcome to webBook' string on it.

document.addEventListener('DOMContentLoaded', (event) => {
    if (document.querySelectorAll('.chapterHead')[0]
        .innerText.match("Chapter.*0")) {
        document.querySelectorAll('.chapterHead')[0]
        .innerText = "Welcome to WebBook"
    }

});


// Next we need to sort out some header information on the TOC as there is a
// slight delay between the chapter information processed by TeX and what is
// written by the make4ht.


function FixMyChapterHeaderInTOC () {

        let chapter_value = document.
            querySelectorAll('.chapterHead')[0]
            .innerText.split('\n').at(-1);
        
    document.querySelectorAll('.header-chapter')[0].innerText = chapter_value;
    
}


document.addEventListener('DOMContentLoaded', (event) => {

     if (typeof document.querySelectorAll('.chapterHead')[0] === 'undefined') {
    } else {
    FixMyChapterHeaderInTOC ()
    };
});


// Color Decider ---------------------------------------------------------------

// Here we write a simple switch-case statement to automatically choose the
// correct color scheme for the lecture materials.


var electroScience = ['Drive Technology',
                      'Drive Systems',
                      'Non-linear Electronics'];

var fundamentalScience = ['Higher Mathematics I',
                          'Higher Mathematics II',
                          'Electrodynamics'];

var aiScience = ['Data Science I',
                 'Data Science II'];

var roboticScience = ['Mobile Robotics',
                      'Autonomous Mobile Robotics'];

var computerScience = ['Academic Writing'];

document.addEventListener('DOMContentLoaded', function() {
    var currentDomain = document.
        getElementsByClassName('header-lecture-name')[0].innerHTML;


    if (electroScience.includes(currentDomain)) {
        document.documentElement.style
            .setProperty("--chosen-science",
                         "var(--electro-science)");
        return;
    }

    if (fundamentalScience.includes(currentDomain)) {
        document.documentElement.style
            .setProperty("--chosen-science",
                         "var(--fundamental-science)");
        return;
    }

    if (roboticScience.includes(currentDomain)) {
        document.documentElement.style
            .setProperty("--chosen-science",
                         "var(--robotic-science)");
          return;
    }

    if (computerScience.includes(currentDomain)) {
        document.documentElement.style
            .setProperty("--chosen-science",
                         "var(--computer-science)");
          return;
    }

    if (aiScience.includes(currentDomain)) {
        document.documentElement.style
            .setProperty("--chosen-science",
                         "var(--ai-science)");
          return;
    } else {

         document.documentElement.style
            .setProperty("--chosen-science",
                         "var(--org-science)");

        $('.lecture-materials').hide()

        if ( $('.header-lecture-name').text().includes("Thesis") ) {

             document.querySelectorAll('.chapterToc .title a')[0]
                .innerText = "Welcome to ThesisBook"
            
            $('.header-webBook').text("ThesisBook")
            $('.nav-comments').hide()
            $('.author-notes').hide()
            $('.pdf-icon').hide()

        }

        if ( $('.header-lecture-name').text().includes("mcidoc") ) {

             document.querySelectorAll('.chapterToc .title a')[0]
                .innerText = "Welcome to mciDoc"
            
            $('.header-webBook').text("mciDoc Documentation")
            $('.nav-comments').hide()
            $('.author-notes').hide()
            $('.pdf-icon').hide()

        }
        

    }

    
    
});


// -----------------------------------------------------------------------------
// flatjs.js ends here.
// 
// 
