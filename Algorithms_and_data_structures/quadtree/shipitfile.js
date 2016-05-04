module.exports = function(shipit) {
  require('shipit-deploy')(shipit);

  shipit.initConfig({
    default: {
      workspace: './',
      repositoryUrl: 'https://github.com/dummas/quadtree.git',
      deployTo: '/var/www/quadtree/'
    },
    live: {
      servers: 'agurkas@nork.lt'
    }
  });
};
