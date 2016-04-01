# BMP2HEX

A quick little script to turn a 16-bit bitmap into a C-style int array.

## Background

The original intended purpose is to display 16x16 graphics on an Adafruit 2.8" TFT LCD with touchscreen (at the time of the writing of this document you can see that [here](https://www.adafruit.com/products/1770)) using an MSP430 Launchpad from TI.

## Disclaimer

Please bear in mind that this is a widely untested and very domain-specific script. It requires explicit following of the directions. I've only used it to make 16x16 pixel images, and had trouble with other sizes. I don't need it for any other images so this script is provided as-is.

## Prep

You will need:

- [Ruby](https://www.ruby-lang.org/) installation (tested only on 2.2.3)
- [GIMP 2.8+](https://www.gimp.org)

## Usage

1. Create/open a 16x16 px image in GIMP **without transparency** (see disclaimer for other sizes)
2. Export it as a bitmap, and under "Advanced Options" select `16 Bit > R5 G6 B5`. (This is the correct bit format for the LCD screen we're using)
3. Copy the image to the same directory as your script (this isn't strictly necessary but makes the object name come out nice)
4. From a command line, run the script, passing in the name of your .bmp file as the first parameter.
5. Open the resulting hex file of the same name as the original file and check it. It should show a C int array declaration which contains 256 values arranged in a 16x16 value layout. If not, something probably went wrong in your export step.

### Notes

- The `ex` directory contains an example of an image generated with the script so you can see how it works.
- The two values at the top of the script deal with image size. As stated in the disclaimer, this has only been tested successfully on 16x16 images, and other image sizes have produced incorrect arrays.
- To find out the size of the bitmap header in bytes I opened the file in [Frhed](http://frhed.sourceforge.net/en/) and selected all the bytes up to what I could see was the first pixel value.
- If you experiment and find a good solution to make this more automated or work with more sizes consistently then please submit a pull request and I'll be happy to merge it in.

#### Attribution

Earth image for demonstration found at https://www.iconfinder.com/icons/10094/web_icon#size=16, and requires link to `http://www.aspneticons.com/` which is, at the time of this writing, a dead domain.
