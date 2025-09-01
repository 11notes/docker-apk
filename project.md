${{ content_synopsis }} This image will let you build your own custom apk’s for Alpine in a self-containing and easy manner. Simply add all the projects you want to build to the ```/src``` directory and execute ```amake```. This will create all your apk’s and put them into ```/apk``` for use in other layers or to export them. You can also sparse checkout and build official packages from different releases by simply calling ```amake python3 main 3.18``` which would build python3 in the latest version of [Alpine 3.18](https://pkgs.alpinelinux.org/package/v3.18/main/x86_64/python3) from the main branch. Since this is a sparse checkout, it will only download the python3 folder in question and not the entire aports repo, which makes for very quick builds.

${{ content_build }}

${{ content_defaults }}

${{ content_environment }}

${{ content_source }}

${{ content_parent }}

${{ content_built }}

${{ content_tips }}