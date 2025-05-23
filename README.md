🌍 Clip Multiple TIFF Rasters with a Shapefile in R 🌿

Welcome to the Raster Clipper! 🎉 This R script makes it easy to clip multiple .TIF raster files using a shapefile, ensuring maximum inclusivity by using coverage fractions. Perfect for geospatial enthusiasts working with satellite imagery, land use data, or any raster-based analysis! 🗺️

🚀 What Does This Script Do?
This script automates the process of clipping multiple TIFF raster files with a shapefile in R, ensuring that even partially covered pixels are included. Here's a quick overview of what it does:


📂 Prompts you to select a folder with .TIF raster files.
🗺️ Asks for a shapefile (.shp) to use as the clipping boundary.
💾 Lets you choose an output folder to save the clipped rasters.
🔄 Processes each .TIF file by:
📖 Reading the raster and shapefile.
🌐 Ensuring both are in the same Coordinate Reference System (CRS).
✂️ Cropping the raster to the shapefile's extent.
🖌️ Rasterizing the shapefile to calculate coverage fractions.
🎭 Creating a binary mask to keep pixels with any coverage.
💾 Saving the clipped raster to the output folder.



📊 Provides a summary of processed and failed files.


The script uses the terra, sf, and tcltk packages to handle geospatial data and interactive file selection. 🛠️


📋 Prerequisites
Before running the script, ensure you have:


🖥️ R installed (version 4.0 or higher recommended).
📦 Required R packages:
terra: For raster and vector operations.
sf: For handling shapefiles.
tcltk: For interactive folder/file selection dialogs.



📁 Input files:
A folder containing .TIF raster files (e.g., satellite imagery).
A .shp shapefile with a defined CRS for clipping.



💾 Write permissions for the output folder.


The script will automatically install missing packages! 🚀


🛠️ How to Use the Script地道
Follow these steps to run the script:


📥 Download the script:


Copy the raster_clipper.R script (provided below) into your R working directory or a known location.



📂 Prepare your files:


Place your .TIF raster files in a folder.
Ensure your shapefile (.shp) is ready and has a valid CRS.



🏃 Run the script in R:


Open R or RStudio.
Source the script using:
source("raster_clipper.R")



Alternatively, copy and paste the script into the R console.



🖱️ Follow the prompts:


Select the folder containing your .TIF files.
Choose the .shp shapefile for clipping.
Pick an output folder for the clipped rasters.



✅ Check the output:


The script will process each .TIF file and save the clipped rasters to the output folder.
A summary will display the number of successfully processed files and any errors.
