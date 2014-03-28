var page = require('webpage').create();
page.open("https://docs.google.com/spreadsheet/pub?key=0AnxTJm98j9jpdHhiai1XMDlQMVBOZDc2ejBpaC1QNlE&single=true&gid=118", function () {
    console.log(page.content);
    phantom.exit();
});