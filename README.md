Meshfree Workshop Fall 2014 Presentation
============================

This repo serves as an example workflow for using `pandoc`, and LaTeX beamer for
creating slides.  It is also a template for a beamer theme that adheres to The
University of Texas at Austin Style Guide color schemes.

**Note**: Requies [pandoc](http://johnmacfarlane.net/pandoc/)

To clone:

````
git clone https://github.com/johntfoster/MeshfreeWorkshop.git
````

I use a submodule to keep common files such as special definitions and bibliography
in sync across all LaTeX repos.  So you will also need to run:

````
git submodule init
git submodule update
````

To build PDF:

````
latexmk
````

To continuously build and view:

````
latexmk -pvc
````

To clean:

````
latexmk -CA
````


