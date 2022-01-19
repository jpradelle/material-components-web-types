# Web-Types for Material Web components
Web-Types is a framework-agnostic format aimed at providing IDEs and other tools with the metadata 
information about the contents of a component library. Its powerful name patterns allow encoding 
information about web framework syntax or customizing code completion suggestions for large icon 
libraries in the IDEs that support Web-Types.

See [web-types](https://github.com/JetBrains/web-types) project

# material-components-web-types
`material-components-web-types` contains Web-Types definition of
[Material Web](https://github.com/material-components/material-web) components like
`@material/mwc-button`, `@material/mwc-textfield` and so on.

## Getting started with lit
To use it when working with lit you need [`lit-web-types`](https://github.com/jpradelle/lit-web-types)
extra dependency to enable autocompletion on your project.
```bash
npm i lit-web-types material-components-web-types -D
```

If using IntelliJ or WebStorm, IDE restart might be needed after install to enable autocomplete.

## Getting started with polymer
To use it when working with polymer you need [`polymer-web-types`](https://github.com/jpradelle/polymer-web-types)
extra dependency to enable autocompletion on your project.
```bash
npm i polymer-web-types material-components-web-types -D
```

If using IntelliJ or WebStorm, IDE restart might be needed after install to enable autocomplete.

# Contributing
Steps to update web-types definitions of `material-components-web-types` package:

#### Clone/Pull material-web
To generate Material Web components web-types you need to clone the project:
```bash
npm run clone
```

#### Update sources
`src/gen` folder contains generated sources by `web-component-analyser`, should not be updated
by hand, only via generator:
```bash
npm run web-types-gen
```

Other sources in `src` can be updated by hand.

#### Build template to web-types
```bash
npm run build
```

#### Release
```bash
npm version patch && npm publish && git push && git push --tags
```