# Deep-Plant-Phenotyping: DeepPod
The proposed pipeline in [our paper](https://www.overleaf.com/read/hrnxjzcvnvdm) is based on a deep convolutional network to classify Arabidopsis thaliana plant parts into 4 classes and use patch based classification approach (through sliding window method) to detect and  count fruits of this plant.


This repository contains the following folders:

- **Annotation-Toolbox** : A GUI for manually annotating plants

- **prepare data to train model** : To prepare 3 datasets (training, validation and testing) used for developing the classification model.

- **trained models**: Two convolutional neural networks were trained and the trained weights can be used in the Caffe platform for doing classification.

- **silique counting** : reconstructs the plant image to detect and count the silique numbers on the whole plant image.

-------------------------------------------------------------------------------------------------
- To do annotation refer to **Annotation-Toolbox**.

- To train  the model from scratch refer to **prepare data to train model**.

- To use the trained models (no need for learning process) for 4-class classification, refer to **trained models**.

- To count the number of siliques, and extract several quantitative phenotype information refer to **silique counting**.

--------------------------------------------------------------------------------------------------

**Requirements**

- MATLAB v9.3??, Python 2.7, CAFFE 1.0.0-rc3.

- Other requirements: CUDA version 8.0, CuDNN v5.1, BLAS: atlas, DIGITS version5.1-dev.

- To install CAFFE and DIGITS, follow the link:

https://www.nvidia.co.uk/object/caffe-installation-uk.html 
https://docs.nvidia.com/deeplearning/digits/digits-installation/index.html
