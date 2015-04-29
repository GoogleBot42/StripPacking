# StripPacking
Packs rects optimally into an infinitely long strip with a specfic width.

Install Love2D to see visual representation of the rects and make sure to add the define "#define USE_LOVE2D" to the top of main.cpp before the includes.  (On windows copy the love binaries to "C:" or to "C:\Windows" so that "love" can be called directly from the command line.)

Without the USE_LOVE2D define the solutions are printed to the console.

To build and run on Linux simply do:

cmake .

make

cd Build

./Main


On windows use cmake gui and choose the build tool of your choice such as visual studio and build and run from their.


See this for more info it was great help to me in creating this: http://cgi.csc.liv.ac.uk/~epa/surveyhtml.html
