var page = require('webpage').create();
page.open("https://docs.google.com/spreadsheet/pub?key=0AnxTJm98j9jpdDBtcWhxaktKbzIyT0dKVURqX2VqeXc&single=true&gid=120", function () {
    console.log(page.content);
    phantom.exit();
});