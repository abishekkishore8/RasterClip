# 🌍 Clip Multiple TIFF Rasters with a Shapefile in R 🌿

Welcome to the **Raster Clipper**! 🎉 This R script makes it easy to clip multiple `.TIF` raster files using a shapefile, ensuring **maximum inclusivity** by using coverage fractions. Perfect for geospatial enthusiasts working with satellite imagery, land use data, or any raster-based analysis! 🗺️

---

## 🚀 What Does This Script Do?

This script automates the process of clipping multiple TIFF raster files with a shapefile in R, ensuring that even partially covered pixels are included. Here's a quick overview of what it does:

1. 📂 **Prompts you to select** a folder with `.TIF` raster files.
2. 🗺️ **Asks for a shapefile** (`.shp`) to use as the clipping boundary.
3. 💾 **Lets you choose an output folder** to save the clipped rasters.
4. 🔄 **Processes each `.TIF` file** by:
   - 📖 Reading the raster and shapefile.
   - 🌐 Ensuring both are in the same Coordinate Reference System (CRS).
   - ✂️ Cropping the raster to the shapefile's extent.
   - 🖌️ Rasterizing the shapefile to calculate coverage fractions.
   - 🎭 Creating a binary mask to keep pixels with any coverage.
   - 💾 Saving the clipped raster to the output folder.
5. 📊 **Provides a summary** of processed and failed files.

The script uses the `terra`, `sf`, and `tcltk` packages to handle geospatial data and interactive file selection. 🛠️

---

## 📋 Prerequisites

Before running the script, ensure you have:

- 🖥️ **R installed** (version 4.0 or higher recommended).
- 📦 **Required R packages**:
  - `terra`: For raster and vector operations.
  - `sf`: For shapefile handling.
  - `tcltk`: For interactive folder/file selection dialogs.
- 📁 **Input files**:
  - A folder containing `.TIF` raster files (e.g., satellite imagery).
  - A `.shp` shapefile with a defined CRS for clipping.
- 💾 **Write permissions** for the output folder.

The script will automatically install missing packages! 🚀

---

## 🛠️ How to Use the Script

1. 📥 **Download the script**:
   - Save `raster_clipper.R` to your R working directory or a known location.

2. 📂 **Prepare your files**:
   - Place your `.TIF` raster files in a folder.
   - Ensure your shapefile (`.shp`) is ready and has a valid CRS.

3. 🏃 **Run the script in R**:
   - Open R or RStudio.
   - Source the script using:
     ```R
     source(" raster_clipper.R")
     ```
   - Alternatively, copy and paste the script into the R console.

4. 🖱️ **Follow the prompts**:
   - Select the folder containing your `.TIF` files.
   - Choose the `.shp` shapefile for clipping.
   - Pick an output folder for the clipped rasters.

5. ✅ **Check the output**:
   - The script will process each `.TIF` file and save the clipped rasters to the output folder.
   - A summary will display the number of successfully processed files and any errors.

---

## 🎯 Features & Benefits

- **User-Friendly**: Interactive prompts guide you to select files and folders. 🖱️
- **CRS Handling**: Automatically aligns the shapefile's CRS with each raster. 🌐
- **Max Inclusivity**: Uses coverage fractions to include partially covered pixels. 🔲
- **Error Handling**: Validates shapefile geometries and reports errors clearly. ⚠️
- **Efficient**: Processes multiple rasters in a loop with progress updates. ⏳

---

## ⚠️ Notes & Tips

- **Shapefile Validity**: The script attempts to fix invalid geometries, but ensure your shapefile is clean to avoid issues.
- **CRS Matching**: The shapefile is reprojected to match each raster's CRS, which may increase processing time for large datasets.
- **Output Naming**: Clipped files are prefixed with `clipped_` to avoid overwriting originals.
- **Performance**: For large rasters or many files, ensure sufficient memory and disk space.
- **Dependencies**: Requires `terra`, `sf`, and `tcltk`. Internet connection needed for initial package installation.

---

## 📚 References

- [terra R Package](https://cran.r-project.org/package=terra): For raster and vector operations.
- [sf R Package](https://cran.r-project.org/package=sf): For shapefile handling.
- [tcltk R Package](https://cran.r-project.org/package=tcltk): For interactive dialogs.
- [GeeksforGeeks: Clipping Raster in R](https://www.geeksforgeeks.org/clipping-raster-using-shapefile-in-r/)

---

## 🌟 Contributing

Feel free to fork this repository, submit pull requests, or open issues for improvements or bug reports! 🙌 Let's make geospatial processing even better together! 🚀
