## Outcomes in Patients With Severe Coronary Artery Disease and Aortic Stenosis Undergoing Surgical Aortic Valve Replacement and Coronary Artery Bypass Grafting vs. Transcatheter Aortic Valve Replacement

<strong>Full citation:</strong> <em>Pending final publication</em>

<strong>DOI:</strong> <em>Pending final publication</em>

This repository contains reproducible code for the manuscript cited above.
<br><br><br><br><br>


## Visual Abstract
<img width="2400" height="1200" alt="glm" src="https://github.com/user-attachments/assets/47fdce36-6b7b-449a-a61f-fb69af647fc7" />
<strong>Fig. 2. Predicted probabilities (lines) and 95% confidence intervals (shaded regions) from logistic regression fitted to model the odds of stroke following SAVR + CABG and TAVR.</strong> Prior heart surgery was held constant at “no”. SAVR, surgical aortic valve replacement; CABG, coronary artery bypass grafting; TAVR, transcatheter aortic valve replacement.
<br><br><br><br><br>

<img width="2400" height="1200" alt="km" src="https://github.com/user-attachments/assets/ae4f032e-c105-4208-b822-fc3294fa63b1" />
<strong>Fig. 3. Kaplan–Meier survival curves for five-year survival following SAVR + CABG and TAVR.</strong> Significant hazard ratios (HRs) from the time-varying Cox proportional hazards model are shown and positioned within their respective time intervals, with SAVR + CABG serving as the reference cohort. Tick marks on survival curves indicate right-censoring. Mortality HR is 0.4 between 1 and 6 months (95% CI 0.15, 0.95; p = 0.001) for TAVR, and mortality HR is 1.7 between 2 and 5 years (95% CI 1.05, 2.70; p = 0.030) for TAVR. 
<br><br><br><br><br>
 

## To use this repository

- Clone the repository and open the `./SAVR-CABG_vs_TAVR_for_CAD-AS.Rproj` R Project file
- This repository uses `renv` dependency management; all software, package, and dependency version information is listed in the `./renv.lock` file and will automatically configure once prompted
- All scripts are in the `./scripts` directory
- Execute scripts in their numbered order to format data, propensity match, fit and plot models, generate tables and figures
  - Users must provide their own VASQIP data file and update `00_format.R` with the appropriate filepath
  - As stated in the manuscript, the VASQIP database is available upon request through the Veterans Affairs National Surgery Office: https://www.data.va.gov/dataset/Veterans-Affairs-Surgical-Quality-Improvement-Prog/nf89-pcxq/about_data
- Please direct any questions to smlee@gwu.edu
<br>  
<br> 
