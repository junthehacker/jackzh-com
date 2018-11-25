# jackzh.com
My personal website &amp; blog.

To start a development server, run the following command

```bash
$ ./start.sh development
```

The website is built using Jekyll, but with a few tweaks.

### Environment Variables

You have to pass two environment variables when building or serving the site, they are:

* `JEKYLL_ENV` - Current environment, `development` or `production`, this determines some behaviours.
* `BUILD` - Build number, usually a git commit hash is fine, used to version assets.

These two variables can be accessed using `site.env` and `site.build` in Liquid.

### Special Tags

#### asset

Asset tag is defined in `Tag/AssetPathTag.rb`. Use it to link assets, it will automatically prepend asset path, and version it. For example:

```html
<link href="{% asset /css/style.css %}" rel="stylesheet" />
```

#### real_path

Real path is defined in `Tag/RealPathTag.rb`. Use it to generate absolute paths. For example:

```html
<a href="{% real_path /about.html %}">About</a>
```