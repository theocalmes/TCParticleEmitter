TCPixelReader
=============

Lightweight library for reading the pixels in an image.

Installation
------------
We recommend installing with [CocoaPods][]

    pod 'TCPixelReader', :git => 'git@github.com:theocalmes/TCPixelReader.git'

Alternatively, you can just copy the category from the `Source` directory into
your project.

[CocoaPods]: http://cocoapods.org

Usage
-----

Initialize the reader with `-initWithImage:`. Then you may access individual pixels by either using `-pixelForRow:column:` or `mapPixelsWithBlock:`.
