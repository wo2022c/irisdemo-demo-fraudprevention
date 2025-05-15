## 1.13.0 (May 21, 2024)
  - Bumping IRIS version to latest-cd

## 1.12.0 (June 14, 2023)
  - Bumping IRIS version to 2023.2

## 1.11.0 (September 06, 2022)
  - Bumping IRIS version to 2022.1.0.209.0

## 1.10.1 (May 25, 2022)
  - The name of the model class has changed to BankingSrv.PMML.FraudPreventionBoostedTreeModel.cls
  - Adding --check-caps false to IRIS in docker compose
  - Changing composition to start IRIS without SECCOMP so that IRIS can start.

## 1.9.1 (January 25, 2022)
  - Bumping IRIS version to 2021.2.0.649.0

## 1.9.0 (December 29, 2021)
  - Bumping IRIS version to 2021.2.0.619.0

## 1.8.0 (December 06, 2021)
  - Upgrading demo to use IRIS 2021.1
  - Adding reference to the Kafka demo
  - Adding reference to the readmission demo
  - Improving run.sh command

## 1.7.0 (January 24, 2020)
  - Merge pull request #5 from intersystems-community/ML-package-version
  - adding final updates for business process and updates to instructions for running demo
  - adding final updates for switching demo over to ML Package
  - updated notebook
  - adding MAcro file for quick PMML Model testing
  - updating the DTL to set amount instead of dollars
  - updated notebook
  - Adding updates for converting the demo to ML package and use of boosted trees as ML model
  - added ML notebook
  - Update README.md
  - Eliminating test notebook
  - Update README.md
  - Update README.md

## 1.6.3 (November 11, 2019)
  - Fixing bumpversion to only change versions of images belonging to this repo.
  - bumpversion will also push to master

## 1.6.2 (November 11, 2019)
  - Fixing autobuild push hook. 
  - Improving documentation

## 1.6.1 (November 11, 2019)
  - Security fixes to image-map-resizer
  - Better README
  - Adding .gitignore to root folder
  - Making docker compose rely on images on docker hub. build.sh now builds without docker compose.
  - Eliminating the need for .env
  
## 1.6.0 (November 08, 2019)
  - adding updates to Docker file to run on node10 and package updates for UI

## 1.5.0 (November 08, 2019)
  - Bump version to 1.4.3.
  - Fixing bumpversion

## 1.4.3 (November 08, 2019)
  - Fixing bumpversion
  - Running now on IRIS Community 2019.3
  - Configured hooks for DockerHub Auto builds