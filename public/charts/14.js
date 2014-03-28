var page = require('webpage').create();
page.open("https://docs.google.com/spreadsheet/pub?key=0AnxTJm98j9jpdHJINVgySlMzUnhqbkRJbE80N2V1dlE&single=true&gid=120", function () {
    console.log(page.content);
    phantom.exit();
});