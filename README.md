# ARIA Lesion Modelling in a Digital Human Phantom

## Overview

This project investigates the computational modelling of Amyloid-Related Imaging Abnormalities (ARIA), which can occur as complications of anti-amyloid treatments for Alzheimer's disease.

The aim was to generate anatomically plausible synthetic ARIA lesions within a Digital Human Phantom (DHP), providing a foundation for medical imaging research and the development of AI-based detection methods.

The project was developed in MATLAB as an individual research project at the University of Manchester.

## Methodology

The framework processes a three-dimensional brain representation constructed from two-dimensional Portable Gray Map (PGM) image slices.

Anatomical tissue masks and mathematical models are used to generate two categories of abnormalities:

**ARIA-E (Oedema and Effusion)**
- Models fluid-related abnormalities within appropriate brain regions.
- Uses Gaussian-based intensity distributions to represent lesion morphology.
- Generates examples across mild, moderate and severe presentations.

**ARIA-H (Haemorrhagic Abnormalities)**
- Models cerebral microhaemorrhages and superficial siderosis.
- Uses spatially constrained lesion generation within relevant anatomical regions.
- Produces examples across different severity levels.

The generated brain models are exported as PGM image slices, preserving the tissue-based representation of the original phantom.

## Key Findings

- Developed synthetic representations of ARIA-E and ARIA-H across multiple severity levels.
- Applied white matter and cortical masks to constrain lesion placement.
- Compared generated lesion appearances with clinical MRI examples to assess anatomical plausibility.
- Identified further improvements needed in ARIA-H modelling, quantitative image similarity assessment and computational efficiency.

## Technologies

MATLAB · Medical Image Processing · Computational Modelling · Synthetic Data Generation

## Running the Code

The project requires MATLAB and access to a compatible Digital Human Phantom dataset.

The source files are provided in the `src/` directory.

The scripts depend on the original DHP image structure and tissue classifications. Input data paths and any configuration parameters must be adjusted to match the local environment.

**Note:** The underlying phantom data and clinical reference images are not included in this repository. Users must obtain any required datasets from their authorised sources.

## Project Context

Individual MEng Mechatronic Engineering research project, University of Manchester, 2025–2026.

This repository demonstrates computational lesion-modelling methods developed for research purposes. The generated models have not undergone quantitative clinical validation and are not intended for medical diagnosis.
