# ALE data preparation and analysis

This repository is used to prepare and process the ALE data from the original data collection. Scans and the raw digitalisation can be inspected (and corrected) at <http://ale.paralleltext.info>. Corrected coordinates of all locations can be inspected at <http://ale.paralleltext.info/all_places>.

Data extraction and orthographic correction/transliteration is exemplified in `manualData.R`. A quick approach at mapping is exemplified in `manualMap.R`. Any automatic analyses will always put results into the directory `sandbox` so as not to overwrite any existing files.

Actual analysis of the data can be found in the directory `alignments`. Words are automatically aligned (using <http://lingpy.org>) and then manually corrected (using <https://github.com/cysouw/msa-editor>). Note that the actualy decisions on cognacy are somtimes quite daring! Visualisations of cognacy and sounds correspondences can be found in `alignments/maps`.