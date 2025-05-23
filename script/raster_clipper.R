if (!requireNamespace("terra", quietly = TRUE)) {
  install.packages("terra")
}
library(terra)

if (!requireNamespace("sf", quietly = TRUE)) {
  install.packages("sf")
}
library(sf)

if (!requireNamespace("tcltk", quietly = TRUE)) {
  install.packages("tcltk")
}
library(tcltk)

print("Welcome! This script will clip multiple TIF files using a shapefile.")
print("Please follow the prompts to select your input and output locations.")

print("Step 1: Please select the folder containing your .TIF raster files.")
raster_folder <- tk_choose.dir(caption = "Select Folder with TIF Raster Files")
if (is.na(raster_folder) || raster_folder == "") {
  stop("No raster folder selected. Script terminated.")
}
print(paste("Raster folder selected:", raster_folder))

print("Step 2: Please select your .shp shapefile for clipping.")
shapefile_path <- tk_choose.files(caption = "Select Shapefile (.shp)",
                                  multi = FALSE,
                                  filters = matrix(c("Shapefiles", ".shp", "All files", ".*"),
                                                   2, 2, byrow = TRUE))
if (length(shapefile_path) == 0 || shapefile_path == "") {
  stop("No shapefile selected. Script terminated.")
}
print(paste("Shapefile selected:", shapefile_path))

print("Step 3: Please select the folder where clipped rasters will be saved.")
output_folder <- tk_choose.dir(caption = "Select Output Folder for Clipped Rasters")
if (is.na(output_folder) || output_folder == "") {
  stop("No output folder selected. Script terminated.")
}
print(paste("Output folder selected:", output_folder))

if (!dir.exists(output_folder)) {
  dir.create(output_folder, recursive = TRUE)
  print(paste("Created output folder:", output_folder))
}

tif_files <- list.files(path = raster_folder,
                        pattern = "\\.tif$",
                        full.names = TRUE,
                        ignore.case = TRUE)

if (length(tif_files) == 0) {
  stop(paste("No .TIF files found in the selected folder:", raster_folder, ". Please check the folder and file extensions."))
} else {
  print(paste("Found", length(tif_files), "TIF files to process."))
  print("Files to be processed:")
  print(basename(tif_files))
}

print(paste("Reading shapefile from:", shapefile_path))
tryCatch({
  clip_shape_sf <- sf::st_read(shapefile_path, quiet = TRUE)
  if(any(!sf::st_is_valid(clip_shape_sf))){
    print("  Warning: Invalid geometries found in shapefile. Attempting to fix with st_make_valid().")
    clip_shape_sf <- sf::st_make_valid(clip_shape_sf)
    if(any(!sf::st_is_valid(clip_shape_sf))){
        print("  Error: Unable to fix all invalid geometries in the shapefile. This might lead to issues.")
    } else {
        print("  Invalid geometries successfully fixed.")
    }
  }
  clip_shape_terra_orig <- terra::vect(clip_shape_sf)
  print("Shapefile read and converted to SpatVector successfully.")
  print(paste("Original Shapefile CRS:", terra::crs(clip_shape_terra_orig, proj=TRUE)))
}, error = function(e) {
  stop(paste("Error reading or converting shapefile:", e$message))
})

print("Starting raster processing loop...")
processed_files_count <- 0
error_files_count <- 0

for (i in 1:length(tif_files)) {
  raster_path <- tif_files[i]
  raster_name <- basename(raster_path)
  output_raster_name <- paste0("clipped_", raster_name)
  output_path <- file.path(output_folder, output_raster_name)

  print(paste0("----------------------------------------------------"))
  print(paste0("Processing file ", i, " of ", length(tif_files), ": ", raster_name))

  tryCatch({
    current_raster <- terra::rast(raster_path)
    print(paste("  Raster loaded. Original CRS:", terra::crs(current_raster, proj=TRUE)))
    print(paste("  Raster resolution (x, y):", paste(terra::res(current_raster), collapse=", ")))

    crs_raster <- terra::crs(current_raster)
    if (!identical(terra::crs(clip_shape_terra_orig), crs_raster)) {
      print("  CRS mismatch detected. Reprojecting shapefile to match current raster CRS...")
      clip_shape_terra_proj <- terra::project(clip_shape_terra_orig, crs_raster)
      print(paste("  Shapefile reprojected to:", terra::crs(clip_shape_terra_proj, proj=TRUE)))
    } else {
      clip_shape_terra_proj <- clip_shape_terra_orig
      print("  CRS match. No reprojection of shapefile needed for this raster.")
    }

    print("  Cropping raster to shapefile extent (snap='out')...")
    raster_cropped <- terra::crop(current_raster, clip_shape_terra_proj, snap="out")
    print("  Raster cropped.")
    
    print("  Rasterizing shapefile to get pixel coverage fractions (cover=TRUE)...")
    coverage_fraction_raster <- terra::rasterize(x = clip_shape_terra_proj, 
                                                 y = raster_cropped, 
                                                 cover = TRUE)
    print("  Coverage fraction raster created.")

    print("  Creating binary mask from coverage fractions (any coverage > 0)...")
    binary_mask <- terra::ifel(coverage_fraction_raster > 1e-9, 1, NA)
    print("  Binary mask created.")

    print("  Masking raster with the binary coverage mask...")
    raster_final_clip <- terra::mask(raster_cropped, binary_mask)
    print("  Raster masked.")

    print(paste("  Saving final clipped raster to:", output_path))
    terra::writeRaster(raster_final_clip, output_path, overwrite = TRUE, datatype = terra::datatype(current_raster))
    print("  Clipped raster saved successfully.")
    processed_files_count <- processed_files_count + 1

  }, error = function(e) {
    print(paste("  ERROR processing file", raster_name, ":", e$message))
    error_files_count <- error_files_count + 1
  })
}

print(paste0("===================================================="))
print("All raster processing finished.")
print(paste("Successfully processed files:", processed_files_count))
print(paste("Files with errors:", error_files_count))
print(paste("Clipped files are saved in:", output_folder))
print("====================================================")
