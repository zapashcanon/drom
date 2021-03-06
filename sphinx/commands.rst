
Sub-commands and Arguments
==========================
Common arguments to all sub-commands:


* :code:`-q` or :code:`--quiet`   Set verbosity level to 0

* :code:`-v` or :code:`--verbose`   Increase verbosity level

Overview of sub-commands::
  
  build
    Build a project
  
  build-deps
    Install build dependencies only
  
  clean
    Clean the project from build files
  
  config
    Read/write configuration
  
  dep (since version 0.2.1)
    Manage dependency of a package
  
  dev-deps
    Install dev dependencies (odoc, ocamlformat, merlin, etc.)
  
  doc
    Generate all documentation (API and Sphinx)
  
  fmt
    Format sources with ocamlformat
  
  install
    Build & install the project in the project opam switch
  
  lock (since version 0.2.1)
    Generate a .locked file for the project
  
  new
    Create a new project
  
  odoc
    Generate API documentation using odoc in the _drom/docs/doc directory
  
  opam-plugin (since version 0.2.1)
    Install drom as an opam plugin (called by 'opam drom')
  
  package
    Manage a package within a project
  
  project
    Update an existing project
  
  promote
    Promote detected changes after running drom test or drom fmt
  
  publish
    Update opam files with checksums and copy them to a local opam-repository for publication
  
  run
    Execute the project
  
  sphinx
    Generate documentation using sphinx
  
  test
    Run tests
  
  tree
    Display a tree of dependencies
  
  uninstall
    Uninstall the project from the project opam switch
  
  update
    Update packages in switch


drom build
~~~~~~~~~~~~

Build a project



**DESCRIPTION**


This command performs the following actions:

* 1.
  Create a local opam switch. The argument **--switch SWITCH** can be used to make the local switch a link to a global switch. The argument **--local** can be used to force a local switch to be created.

* 2.
  Check that the OCaml version is at least the **min-edition** specified in the project. If OCaml is not installed, use the **--edition VERSION** argument or the **edition** field specified in the project to install OCaml.

* 3.
  Install all the dependencies in the opam switch. If the argument **--locked** was specified, use the **${package}-deps.opam.locked** file in the project to get exact dependencies.

* 4.
  Build the project by calling **opam exec -- dune build @install**

* 5.
  If build was ok, copy executable in the top directory of the project

**USAGE**
::
  
  drom build [OPTIONS]

Where options are:


* :code:`--edition VERSION`   Use this OCaml edition

* :code:`--local`   Create a local switch instead of using a global switch

* :code:`--locked`   (since version 0.2.1) Use .locked file if it exists

* :code:`--profile PROFILE`   Build profile to use

* :code:`--switch OPAM_SWITCH`   Use global switch SWITCH instead of creating a local switch

* :code:`--upgrade`   Upgrade project files from drom.toml

* :code:`-y` or :code:`--yes`   Reply yes to all questions


drom build-deps
~~~~~~~~~~~~~~~~~

Install build dependencies only


**USAGE**
::
  
  drom build-deps [OPTIONS]

Where options are:


* :code:`--edition VERSION`   Use this OCaml edition

* :code:`--local`   Create a local switch instead of using a global switch

* :code:`--locked`   (since version 0.2.1) Use .locked file if it exists

* :code:`--profile PROFILE`   Build profile to use

* :code:`--switch OPAM_SWITCH`   Use global switch SWITCH instead of creating a local switch

* :code:`--upgrade`   Upgrade project files from drom.toml

* :code:`-y` or :code:`--yes`   Reply yes to all questions


drom clean
~~~~~~~~~~~~

Clean the project from build files


**USAGE**
::
  
  drom clean [OPTIONS]

Where options are:


* :code:`--distclean`   Also remove _opam/ (local switch) and _drom/


drom config
~~~~~~~~~~~~~

Read/write configuration



**DESCRIPTION**


This command is useful to read/write drom configuration


**EXAMPLE**


The following displays the list of project skeletons:
::
  
  drom config --project-skeletons
  

**USAGE**
::
  
  drom config [OPTIONS]

Where options are:


* :code:`--drom-project-skeletons`   List available project skeletons from drom

* :code:`--package-skeletons`   List available package skeletons

* :code:`--project-skeletons`   List available project skeletons


drom dep (since version 0.2.1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Manage dependency of a package



**DESCRIPTION**


Add, remove and modify dependencies from **drom.toml** and  **package.toml** files.

If the argument **--package** is not specified, the dependency is added project-wide (i.e. for all packages), updating the *drom.toml* file.

If the argument **--package** is provided, the dependency is added to the *package.toml* file for that particular package.

Dependencies can be added **--add**, removed **--remove** or just modified. The **--tool** argument should be used for tool dependencies, i.e. dependencies that are not linked to the library/program.

If no modification argument is provided, the dependency is printed in the terminal. Modification arguments are **--ver VERSION** for the version, **--lib LIBNAME** for the *dune* library name, **--doc BOOL** for documentation deps and **--test BOOL** for test deps.


**EXAMPLE**

::
  
  drom dep --package drom_lib --add ez_cmdliner --ver ">0.1"
  drom dep --package drom_lib --remove ez_cmdliner
  drom dep --add --tool odoc --ver ">1.0 <3.0" --doc true
  


**VERSION SPECIFICATION**


The version specified in the **--ver VERSION** argument should follow the following format:

* 1.
  Spaces are used to separate a conjunction of version constraints.

* 2.
  An empty string is equivalent to no version constraint.

* 3.
  Constraints are specified using a comparison operation directly followed by the version, like **>1.2** or **<=1.0**.

* 4.
  A semantic version like **1.2.3** is equivalent to the constraints  **>=1.2.3** and **<2.0.0**.

**USAGE**
::
  
  drom dep DEPENDENCY [OPTIONS]

Where options are:


* :code:`DEPENDENCY`   Name of dependency

* :code:`--add`   Add as new dependency

* :code:`--diff`   Print a diff of user-modified files that are being skipped

* :code:`--doc BOOL`   Whether dependency is only for doc

* :code:`-f` or :code:`--force`   Force overwriting modified files (otherwise, they would be skipped)

* :code:`--lib LIBNAME`   Dependency should have this libname in dune

* :code:`--package PACKAGE`   Attach dependency to this package name

* :code:`--promote-skip`   Promote user-modified files to skip field

* :code:`--remove`   Remove this dependency

* :code:`--skip FILE`   Add FILE to skip list

* :code:`--test BOOL`   Whether dependency is only for tests

* :code:`--tool`   Dependency is a tool, not a library

* :code:`--unskip FILE`   Remove FILE from skip list

* :code:`--ver VERSION`   Dependency should have this version


drom dev-deps
~~~~~~~~~~~~~~~

Install dev dependencies (odoc, ocamlformat, merlin, etc.)


**USAGE**
::
  
  drom dev-deps [OPTIONS]

Where options are:


* :code:`--edition VERSION`   Use this OCaml edition

* :code:`--local`   Create a local switch instead of using a global switch

* :code:`--locked`   (since version 0.2.1) Use .locked file if it exists

* :code:`--profile PROFILE`   Build profile to use

* :code:`--switch OPAM_SWITCH`   Use global switch SWITCH instead of creating a local switch

* :code:`--upgrade`   Upgrade project files from drom.toml

* :code:`-y` or :code:`--yes`   Reply yes to all questions


drom doc
~~~~~~~~~~

Generate all documentation (API and Sphinx)


**USAGE**
::
  
  drom doc [OPTIONS]

Where options are:


* :code:`--edition VERSION`   Use this OCaml edition

* :code:`--local`   Create a local switch instead of using a global switch

* :code:`--locked`   (since version 0.2.1) Use .locked file if it exists

* :code:`--profile PROFILE`   Build profile to use

* :code:`--switch OPAM_SWITCH`   Use global switch SWITCH instead of creating a local switch

* :code:`--upgrade`   Upgrade project files from drom.toml

* :code:`--view`   Open a browser on the documentation

* :code:`-y` or :code:`--yes`   Reply yes to all questions


drom fmt
~~~~~~~~~~

Format sources with ocamlformat


**USAGE**
::
  
  drom fmt [OPTIONS]

Where options are:


* :code:`--auto-promote`   Promote detected changes immediately

* :code:`--edition VERSION`   Use this OCaml edition

* :code:`--local`   Create a local switch instead of using a global switch

* :code:`--locked`   (since version 0.2.1) Use .locked file if it exists

* :code:`--profile PROFILE`   Build profile to use

* :code:`--switch OPAM_SWITCH`   Use global switch SWITCH instead of creating a local switch

* :code:`--upgrade`   Upgrade project files from drom.toml

* :code:`-y` or :code:`--yes`   Reply yes to all questions


drom install
~~~~~~~~~~~~~~

Build & install the project in the project opam switch


**USAGE**
::
  
  drom install [OPTIONS]

Where options are:


* :code:`--edition VERSION`   Use this OCaml edition

* :code:`--local`   Create a local switch instead of using a global switch

* :code:`--locked`   (since version 0.2.1) Use .locked file if it exists

* :code:`--profile PROFILE`   Build profile to use

* :code:`--switch OPAM_SWITCH`   Use global switch SWITCH instead of creating a local switch

* :code:`--upgrade`   Upgrade project files from drom.toml

* :code:`-y` or :code:`--yes`   Reply yes to all questions


drom lock (since version 0.2.1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Generate a .locked file for the project



**DESCRIPTION**


This command will build the project and call **opam lock** to generate a file *${project}-deps.opam.locked* with the exact dependencies used during the build, and that file will be added to the git-managed files of the project to be committed.

The generated .locked file can be used by other developers to build in the exact same environment by calling **drom build --locked** to build the current project.

**USAGE**
::
  
  drom lock [OPTIONS]

Where options are:


* :code:`--edition VERSION`   Use this OCaml edition

* :code:`--local`   Create a local switch instead of using a global switch

* :code:`--locked`   (since version 0.2.1) Use .locked file if it exists

* :code:`--profile PROFILE`   Build profile to use

* :code:`--switch OPAM_SWITCH`   Use global switch SWITCH instead of creating a local switch

* :code:`--upgrade`   Upgrade project files from drom.toml

* :code:`-y` or :code:`--yes`   Reply yes to all questions


drom new
~~~~~~~~~~

Create a new project



**DESCRIPTION**


This command creates a new project, with name **PROJECT** in a directory **PROJECT** (unless the **--inplace** argument was provided).


**EXAMPLE**


The following command creates a project containing library **my_lib** in **src/my_lib**:
::
  
  drom new my_lib --skeleton library
  

The following command creates a project containing a library **hello_lib** in **src/hello_lib** and a program **hello** in **src/hello** calling the library:
::
  
  drom new hello --skeleton program
  

**USAGE**
::
  
  drom new PROJECT [OPTIONS]

Where options are:


* :code:`PROJECT`   Name of the project

* :code:`--binary`   Compile to binary

* :code:`--diff`   Print a diff of user-modified files that are being skipped

* :code:`--dir DIRECTORY`   Dir where package sources are stored (src by default)

* :code:`-f` or :code:`--force`   Force overwriting modified files (otherwise, they would be skipped)

* :code:`--inplace`   Create project in the the current directory

* :code:`--javascript`   Compile to javascript

* :code:`--library`   Project contains only a library

* :code:`--program`   Project contains only a program

* :code:`--promote-skip`   Promote user-modified files to skip field

* :code:`--skeleton SKELETON`   Create project using a predefined skeleton or one specified in ~/.config/drom/skeletons/

* :code:`--skip FILE`   Add FILE to skip list

* :code:`--unskip FILE`   Remove FILE from skip list

* :code:`--virtual`   Package is virtual, i.e. no code


drom odoc
~~~~~~~~~~~

Generate API documentation using odoc in the _drom/docs/doc directory


**USAGE**
::
  
  drom odoc [OPTIONS]

Where options are:


* :code:`--edition VERSION`   Use this OCaml edition

* :code:`--local`   Create a local switch instead of using a global switch

* :code:`--locked`   (since version 0.2.1) Use .locked file if it exists

* :code:`--profile PROFILE`   Build profile to use

* :code:`--switch OPAM_SWITCH`   Use global switch SWITCH instead of creating a local switch

* :code:`--upgrade`   Upgrade project files from drom.toml

* :code:`--view`   Open a browser on the documentation

* :code:`-y` or :code:`--yes`   Reply yes to all questions


drom opam-plugin (since version 0.2.1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Install drom as an opam plugin (called by 'opam drom')



**DESCRIPTION**


This command performs the following actions:

* 1.
  Install drom executable in **$OPAMROOT/plugins/bin/opam-drom**

* 2.
  Install drom share files in **$OPAMROOT/plugins/opam-drom**, removing former files

**USAGE**
::
  
  drom opam-plugin [OPTIONS]

Where options are:


* :code:`--remove`   Remove drom as an opam plugin


drom package
~~~~~~~~~~~~~~

Manage a package within a project


**USAGE**
::
  
  drom package PACKAGE [OPTIONS]

Where options are:


* :code:`PACKAGE`   Name of the package

* :code:`--binary`   Compile to binary

* :code:`--diff`   Print a diff of user-modified files that are being skipped

* :code:`--dir DIRECTORY`   Dir where package sources are stored (src by default)

* :code:`-f` or :code:`--force`   Force overwriting modified files (otherwise, they would be skipped)

* :code:`--javascript`   Compile to javascript

* :code:`--library`   Package is a library

* :code:`--new SKELETON`   Add a new package to the project with skeleton NAME

* :code:`--new-file FILENAME`   (since version 0.2.1) Add new source file

* :code:`--program`   Package is a program

* :code:`--promote-skip`   Promote user-modified files to skip field

* :code:`--remove`   (since version 0.2.1) Remove a package from the project

* :code:`--rename NEW_NAME`   Rename secondary package to a new name

* :code:`--skip FILE`   Add FILE to skip list

* :code:`--unskip FILE`   Remove FILE from skip list

* :code:`--virtual`   Package is virtual, i.e. no code


drom project
~~~~~~~~~~~~~~

Update an existing project



**DESCRIPTION**


This command is used to regenerate the files of a project after updating its description.

With argument **--upgrade**, it can also be used to reformat the toml files, from their skeletons.

**USAGE**
::
  
  drom project [OPTIONS]

Where options are:


* :code:`--binary`   Compile to binary

* :code:`--diff`   Print a diff of user-modified files that are being skipped

* :code:`-f` or :code:`--force`   Force overwriting modified files (otherwise, they would be skipped)

* :code:`--javascript`   Compile to javascript

* :code:`--library`   Project contains only a library. Equivalent to **--skeleton library**

* :code:`--program`   Project contains a program. Equivalent to **--skeleton program**. The generated project will be composed of a *library* package and a *driver* package calling the **Main.main** of the library.

* :code:`--promote-skip`   Promote user-modified files to skip field

* :code:`--skeleton SKELETON`   Create project using a predefined skeleton or one specified in ~/.config/drom/skeletons/

* :code:`--skip FILE`   Add FILE to skip list

* :code:`--unskip FILE`   Remove FILE from skip list

* :code:`--upgrade`   Force upgrade of the drom.toml file from the skeleton

* :code:`--virtual`   Package is virtual, i.e. no code. Equivalent to **--skeleton virtual**.


drom promote
~~~~~~~~~~~~~~

Promote detected changes after running drom test or drom fmt


**USAGE**
::
  
  drom promote [OPTIONS]

Where options are:


* :code:`--edition VERSION`   Use this OCaml edition

* :code:`--local`   Create a local switch instead of using a global switch

* :code:`--locked`   (since version 0.2.1) Use .locked file if it exists

* :code:`--profile PROFILE`   Build profile to use

* :code:`--switch OPAM_SWITCH`   Use global switch SWITCH instead of creating a local switch

* :code:`--upgrade`   Upgrade project files from drom.toml

* :code:`-y` or :code:`--yes`   Reply yes to all questions


drom publish
~~~~~~~~~~~~~~

Update opam files with checksums and copy them to a local opam-repository for publication



**DESCRIPTION**


Before running this command, you should edit the file **$HOME/.config/drom/config** and set the value of the *opam-repo* option, like:
::
  
  [user]
  author = "John Doe <john.doe@ocaml.org>"
  github-organization = "ocaml"
  license = "LGPL2"
  copyright = "OCamlPro SAS & Origin Labs SAS"
  opam-repo = "/home/john/GIT/opam-repository"
  

Alternatively, you can run it with option **--opam-repo REPOSITORY**.

In both case, **REPOSITORY** should be the absolute path to the location of a local git-managed opam repository.

**drom publish** will perform the following actions:

* 1.
  Download the source archive corresponding to the current version

* 2.
  Compute the checksum of the archive

* 3.
  Copy updated opam files to the git-managed opam repository. During this operation, comment lines, :code:`version:` and :code:`name` lines are removed to conform to opam-repository policies.

Note that, prior to calling **drom publish**, you should update the opam-repository to the latest version of the **master** branch:
::
  git checkout master
  git pull ocaml master

Once the opam files have been added, you should push them to your local fork of opam-repository and create a merge request:
::
  cd ~/GIT/opam-repository
  git checkout -b z-$(date --iso)-new-package-version
  git add packages
  git commit -a -m "New version of my package"
  git push
  

To download the project source archive, **drom publish** will either use the *archive* URL of the drom.toml file, or the Github URL (if the *github-organization* is set in the project), assuming in this later case that the version starts with 'v' (like v1.0.0). Two substitutions are allowed in *archive*: *${version}* for the version, *${name}* for the package name.

**USAGE**
::
  
  drom publish [OPTIONS]

Where options are:


* :code:`-f` or :code:`--force`   Overwrite existing files

* :code:`--md5`   Use md5 instead of sha256 for checksums

* :code:`--opam-repo DIRECTORY`   Path to local git-managed opam-repository. The path should be absolute. Overwrites the value *opam-repo* from *$HOME/.config/drom/config*


drom run
~~~~~~~~~~

Execute the project



**DESCRIPTION**


This command performs the following actions:

* 1.
  Decrease verbosity level to display nothing during build

* 2.
  Build the project packages (see **drom build** for info).

* 3.
  Call **opam exec -- drun exec -- [PACKAGE] [ARGUMENTS]**, where **[PACKAGE]** is either the package name specified with the **-p PACKAGE** argument or the main package of the project if it is a program, **[ARGUMENTS]** are the arguments specified with **drom run**

**USAGE**
::
  
  drom run ARGUMENTS [OPTIONS]

Where options are:


* :code:`ARGUMENTS`   Arguments to the command

* :code:`--edition VERSION`   Use this OCaml edition

* :code:`--local`   Create a local switch instead of using a global switch

* :code:`--locked`   (since version 0.2.1) Use .locked file if it exists

* :code:`-p PACKAGE`   Package to run

* :code:`--profile PROFILE`   Build profile to use

* :code:`--switch OPAM_SWITCH`   Use global switch SWITCH instead of creating a local switch

* :code:`--upgrade`   Upgrade project files from drom.toml

* :code:`-y` or :code:`--yes`   Reply yes to all questions


drom sphinx
~~~~~~~~~~~~~

Generate documentation using sphinx



**DESCRIPTION**


This command performs the following actions:

* 1.
  Build the project, installing dev dependencies if not done yet (see **drom build** and **drom dev-deps** for more info).

* 2.
  If a file *scripts/before-sphinx.sh* exists, run it

* 3.
  Build Sphinx documentation using the command **sphinx-build sphinx _drom/docs/${sphinx-target}**, where **${sphinx-target}** is the **sphinx-target** field in the project description, or **sphinx** by default. Documentation source files are expected to be found in the top **sphinx/** directory.

* 4.
  If the argument **--view** was specified, open a browser on the newly generated documentation

**USAGE**
::
  
  drom sphinx [OPTIONS]

Where options are:


* :code:`--edition VERSION`   Use this OCaml edition

* :code:`--local`   Create a local switch instead of using a global switch

* :code:`--locked`   (since version 0.2.1) Use .locked file if it exists

* :code:`--profile PROFILE`   Build profile to use

* :code:`--switch OPAM_SWITCH`   Use global switch SWITCH instead of creating a local switch

* :code:`--upgrade`   Upgrade project files from drom.toml

* :code:`--view`   Open a browser on the sphinx documentation

* :code:`-y` or :code:`--yes`   Reply yes to all questions


drom test
~~~~~~~~~~~

Run tests



**DESCRIPTION**


This command performs the following actions:

* 1.
  Build the project, installing required test dependencies if needed

* 2.
  Run the test command **opam exec -- dune build @runtest**

If the **--all** argument was provided, a file **_drom/dune-workspace.dev** is created containing a context for every existing opam switch compatible with the project **min-edition** field, and the tests are run on all of them. Before using this option, you should make sure that dependencies are correctly installed on all of them, using the command drom build --switch SWITCH on every **SWITCH** in the list. Only switches starting with a number and without the *+* character are selected.

**USAGE**
::
  
  drom test [OPTIONS]

Where options are:


* :code:`--all`   Build and run tests on all compatible switches

* :code:`--edition VERSION`   Use this OCaml edition

* :code:`--local`   Create a local switch instead of using a global switch

* :code:`--locked`   (since version 0.2.1) Use .locked file if it exists

* :code:`--profile PROFILE`   Build profile to use

* :code:`--switch OPAM_SWITCH`   Use global switch SWITCH instead of creating a local switch

* :code:`--upgrade`   Upgrade project files from drom.toml

* :code:`-y` or :code:`--yes`   Reply yes to all questions


drom tree
~~~~~~~~~~~

Display a tree of dependencies



**DESCRIPTION**


Print the project as a tree of dependencies, i.e. dependencies are printed as branches of the package they are dependencies of. If a package is itself a dependency of another package, it will be printed there.


**EXAMPLE**

::
  
  └──drom (/src/drom)
     └──drom_lib (/src/drom_lib)
        └──toml 5.0.0
        └──opam-file-format 2.1.1
        └──ez_subst >= 0.1
        └──ez_file 0.2.0
        └──ez_config 0.1.0
        └──ez_cmdliner 0.2.0
        └──directories >= 0.2
  [tools]
  └── ppx_inline_test
  └── ppx_expect
  └── odoc
  └── ocamlformat
  

**USAGE**
::
  
  drom tree [OPTIONS]

Where options are:



drom uninstall
~~~~~~~~~~~~~~~~

Uninstall the project from the project opam switch


**USAGE**
::
  
  drom uninstall [OPTIONS]

Where options are:


* :code:`--edition VERSION`   Use this OCaml edition

* :code:`--local`   Create a local switch instead of using a global switch

* :code:`--locked`   (since version 0.2.1) Use .locked file if it exists

* :code:`--profile PROFILE`   Build profile to use

* :code:`--switch OPAM_SWITCH`   Use global switch SWITCH instead of creating a local switch

* :code:`--upgrade`   Upgrade project files from drom.toml

* :code:`-y` or :code:`--yes`   Reply yes to all questions


drom update
~~~~~~~~~~~~~

Update packages in switch



**DESCRIPTION**


This command performs the following actions:

* 1.
  Call **opam update** to get information on newly available packages

* 2.
  Pin the package dependencies in the local opam switch

* 3.
  Call **opam upgrade** to upgrade packages in the local opam switch

* 4.
  Unpin package dependencies

**USAGE**
::
  
  drom update [OPTIONS]

Where options are:


* :code:`--edition VERSION`   Use this OCaml edition

* :code:`--local`   Create a local switch instead of using a global switch

* :code:`--locked`   (since version 0.2.1) Use .locked file if it exists

* :code:`--profile PROFILE`   Build profile to use

* :code:`--switch OPAM_SWITCH`   Use global switch SWITCH instead of creating a local switch

* :code:`--upgrade`   Upgrade project files from drom.toml

* :code:`-y` or :code:`--yes`   Reply yes to all questions
