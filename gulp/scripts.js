var config = require('./config'),
    gulp = require('gulp'),
    minify = require('gulp-minify'),
    exec = require('gulp-exec'),
    elmOut = config.public.js + '/app.js',
    elmCmd =
      'elm-make source/Main.elm --output ' + elmOut;

gulp.task('elm', function() {
    gulp.src(config.source.js)
        .pipe(exec(elmCmd))
});

gulp.task('elm-bundle', ['elm'], function() {
    gulp.src(elmOut)
        .pipe(minify())
        .pipe(gulp.dest(config.public.js));
});

