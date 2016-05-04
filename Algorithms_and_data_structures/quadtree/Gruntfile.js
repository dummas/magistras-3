module.exports = function(grunt) {

    // measures the time each task takes
    require('time-grunt')(grunt);

    // Loading all the tasks
    require('load-grunt-config')(grunt);



    // The npm load part is read from the package.json
    // everything with grunt-* prefix is loaded
};
