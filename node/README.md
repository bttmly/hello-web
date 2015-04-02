# Node.js

Node.js [provides downloadable binaries](https://nodejs.org/download/) for Linux, Mac OS X, and Windows. Alternately, it can be installed with platform-specific package managers. Node installations come with `npm`, the excellent JavaScript package and dependency management tool.

Once Node is installed, you can run programs like so:

```
node path/to/program.js
```

Node programs contain a `package.json` file in the root, which, [among other things](https://docs.npmjs.com/files/package.json), lists dependencies. Running `npm install` will read dependencies from `package.json` and download them from the npm registry. npm uses a nested dependency system that is designed to avoid conflicts -- you can read more about it [here](http://maxogden.com/nested-dependencies.html).

# Linux

`apt-get node`

# Mac

`brew install node`

# Windows
