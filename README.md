# `mdAL`: A DSL for AL Extension Development

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/mdal-lang/mdal/Build)
![Codecov](https://img.shields.io/codecov/c/gh/mdal-lang/mdal)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/mdal-lang/mdal)

This repository contains the implementation of the Domain Specific Language (DSL) `mdAL`. `mdAL` enables a Model-Driven approach to extension module development for the ERP System Microsoft Dynamics 365 Business Central. `mdAL` stands for **m**odel-**d**riven **AL**.

## Features

`mdAL` is a descriptive language used to define the needed core entities and views of an AL solution. In addition, the data flow between entities can be specified. General features and integrations which have to be provided in an AL solution (e. g. comment line table and pages, source code and navigate integration) and features that can be derived from the entity and view specification are added automatically.

Thus, `mdAL` provides AL code generation for:

* Tables
  * Setup
  * Master
  * Supplemental
  * (Posted) Document Header and Line
  * Document Comment Line
  * Journal Template, Batch and Line
* Enums
  * From specified table fields
* Pages
  * Master
    * Card and List Page
  * Supplemental
    * List Page
  * (Posted) Document
    * Document and List Page
  * Ledger Entry
    * List Page
* Codeunits
  * Post
  * Post (Yes/No)
  * Jnl. Check Line
  * Jnl. Post Line
  * Reg.-Show Ledger

Moreover, these customizations to standard objects are generated:

* Event subscribers implementing the Navigate functionality for the specified Posted Document Header
* `Source Code Setup` table extension
* `Comment Line` table extension
* `Comment Line Table Name` enum extension

Specific code that cannot be generated from a `mdAL` model file can be integrated by subscribing to the various event publishers available in the generated AL code. Hence, you can use `mdAL` to automatically generate a base AL extension and create an additional AL extension that depends on the base extension and adds your specific code. This way you do not have to change generated code in order to do customizations. Take a look at the [demo projects](#demo-projects) to see how this could be done.

If you need additional event publishers or find errors in the generated code, please open an [issue](https://github.com/mdal-lang/mdal/issues).

## Repository Structure

This repository consists of the following projects:

* `de.joneug.mdal` contains the language implementation and AL code generator.
* `de.joneug.mdal.ide` implements a language server complying to the [Language Server Protocol ](https://microsoft.github.io/language-server-protocol/) (LSP). It is used in the [`mdAL` VS Code extension](https://marketplace.visualstudio.com/items?itemName=joneug.mdal) to add language support and IDE features like commands, code actions, content proposals and documentation hovers.
* `de.joneug.mdal.standalone` implements a standalone CLI tool that can be used to generate AL code from a `mdAL` model file. This tool is useful for CI/CD pipelines. It can be used conveniently with the docker image [`mdal/cli`](https://hub.docker.com/r/mdal/cli) which is available for Unix and Windows systems. If you use GitHub Actions also consider using the [`mdAL` action](https://github.com/mdal-lang/mdal-action) for your workflows.

## Demo Projects

To see `mdAL` in action take a look at the following demo projects which implement a seminar management solution (cf. Microsoft official training material: Course 80437 — C/SIDE Solution Development in Microsoft Dynamics® NAV 2013):

* [`mdal-lang/mdal-demo`](https://github.com/mdal-lang/mdal-demo) contains the `mdAL` model file used to generate the base AL extension.
* [`mdal-lang/mdal-demo-extension`](https://github.com/mdal-lang/mdal-demo-extension) contains the AL extension that adds specific features to the base extension that are too specific to be generated (e. g. completing the generated posting routines through event subscribers).

## Development

All projects are built using the build tool [Gradle](https://gradle.org/). If the [Java JDK](https://www.oracle.com/de/java/technologies/javase-downloads.html) is installed, you can use the bundled Gradle wrapper and build all projects with this single command:

```sh
$ ./gradlew build
```

A list of all available Gradle tasks can be obtained with this command:

```sh
$ ./gradlew tasks
```

## License

Apache 2.0 (c) Jonathan Neugebauer
